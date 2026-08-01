package com.messbill.Service;

import java.time.LocalDateTime;
import java.util.Random;
import java.util.UUID;

import com.messbill.Entity.Bill;
import com.messbill.Entity.PaymentSession;
import com.messbill.Repository.BillRepository;
import com.messbill.Repository.PaymentSessionRepository;

public class PaymentSessionService {

    private PaymentSessionRepository paymentSessionRepository = new PaymentSessionRepository();
    private BillRepository billRepository = new BillRepository();

    public PaymentSession createSession(Integer billId) {
        Bill bill = billRepository.findBillById(billId);

        if (bill == null) {
            throw new RuntimeException("Bill not found");
        }

        if (bill.getStudent() == null) {
            throw new RuntimeException("Student not found");
        }

        if (!"Active".equalsIgnoreCase(bill.getStudent().getStatus())) {
            throw new RuntimeException("Inactive student cannot open payment session");
        }

        if ("Paid".equalsIgnoreCase(bill.getStatus())) {
            throw new RuntimeException("Bill already paid");
        }

        String token = UUID.randomUUID().toString().replace("-", "");
        String otp = generateOtp();

        PaymentSession session = new PaymentSession();
        session.setBill(bill);
        session.setToken(token);
        session.setOtp(otp);
        session.setCreatedAt(LocalDateTime.now());
        session.setExpiresAt(LocalDateTime.now().plusMinutes(5));
        session.setVerified(false);
        session.setUsed(false);

        paymentSessionRepository.save(session);

        return session;
    }

    public PaymentSession findByToken(String token) {
        return paymentSessionRepository.findByToken(token);
    }

    public boolean verifyOtp(PaymentSession session, String enteredOtp) {
        if (session == null) {
            return false;
        }

        if (session.isUsed()) {
            throw new RuntimeException("Session already used");
        }

        if (LocalDateTime.now().isAfter(session.getExpiresAt())) {
            throw new RuntimeException("Session expired, try again later");
        }

        if (session.getOtp() != null && session.getOtp().equals(enteredOtp)) {
            session.setVerified(true);
            paymentSessionRepository.update(session);
            return true;
        }

        return false;
    }

    public void markUsed(PaymentSession session) {
        session.setUsed(true);
        paymentSessionRepository.update(session);
    }

    private String generateOtp() {
        return String.valueOf(100000 + new Random().nextInt(900000));
    }
    
    public String getOtpByToken(String token) {
        PaymentSession session = paymentSessionRepository.findByToken(token);
        if (session == null) {
            throw new RuntimeException("Payment session not found");
        }
        return session.getOtp();
    }
}