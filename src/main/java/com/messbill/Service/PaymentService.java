package com.messbill.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Random;

import com.messbill.Entity.Bill;
import com.messbill.Entity.Payment;
import com.messbill.Repository.BillRepository;
import com.messbill.Repository.PaymentRepository;

public class PaymentService {

    private final BillRepository billRepository = new BillRepository();
    private final PaymentRepository paymentRepository = new PaymentRepository();
    private final ActivityService activityService = new ActivityService();

    private static final double LATE_FEE = 100.0;

    public Payment markAsPaid(Integer billId, String paymentMethod, String referenceNo) {
        return processPayment(billId, paymentMethod, referenceNo);
    }

    public Payment makePayment(Integer billId, String paymentMethod, String referenceNo) {
        return processPayment(billId, paymentMethod, referenceNo);
    }

    private Payment processPayment(Integer billId, String paymentMethod, String referenceNo) {

        Bill bill = billRepository.findBillById(billId);

        if (bill == null) {
            throw new RuntimeException("Bill not found");
        }

        if (bill.getStudent() == null) {
            throw new RuntimeException("Student not found");
        }

        if (bill.getStudent().getStatus() == null ||
                !"Active".equalsIgnoreCase(bill.getStudent().getStatus())) {
            throw new RuntimeException("Inactive student cannot make payment");
        }

        if ("Paid".equalsIgnoreCase(bill.getStatus())) {
            throw new RuntimeException("Bill already paid");
        }

        if (paymentRepository.existsByBillId(billId)) {
            throw new RuntimeException("Payment already exists for this bill");
        }

        String finalReferenceNo = referenceNo;

        if (finalReferenceNo == null || finalReferenceNo.trim().isEmpty()) {
            finalReferenceNo = generateUniqueReferenceNo();
        } else {
            if (paymentRepository.existsByReferenceNo(finalReferenceNo)) {
                throw new RuntimeException("Transaction reference already used");
            }
        }

        double lateFee = calculateLateFee(bill);
        double payableAmount = calculatePayableAmount(bill);

        Payment payment = new Payment();
        payment.setBill(bill);
        payment.setAmount(payableAmount);
        payment.setLateFee(lateFee);
        payment.setPaymentDate(LocalDate.now());
        payment.setPaymentMethod(paymentMethod);
        payment.setTransactionStatus("SUCCESS");
        payment.setReferenceNo(finalReferenceNo);

        paymentRepository.savePayment(payment);

        bill.setLateFee(lateFee);
        bill.setStatus("Paid");
        billRepository.updateBill(bill);

        activityService.saveActivity("Payment Updated", "Success");

        return payment;
    }

    public double calculateLateFee(Bill bill) {
        if (bill == null || bill.getDueDate() == null) {
            return 0.0;
        }

        if (LocalDate.now().isAfter(bill.getDueDate())) {
            return LATE_FEE;
        }

        return 0.0;
    }

    public double calculatePayableAmount(Bill bill) {
        double billAmount = bill != null && bill.getTotalAmount() != null
                ? bill.getTotalAmount()
                : 0.0;
        return billAmount + calculateLateFee(bill);
    }

    private String generateUniqueReferenceNo() {
        String refNo;
        do {
            Random random = new Random();
            refNo = "PAY" + (100000 + random.nextInt(900000));
        } while (paymentRepository.existsByReferenceNo(refNo));

        return refNo;
    }

    public List<Payment> getAllPayments() {
        return paymentRepository.getAllPayments();
    }

    public Long getTotalPaymentsCount() {
        return paymentRepository.countAllPayments();
    }

    public Long getPaymentsThisMonth(Integer month, Integer year) {
        return paymentRepository.countPaymentsThisMonth(month, year);
    }

    public Long getPaymentsThisMonthCount() {
        LocalDate startDate = LocalDate.now().withDayOfMonth(1);
        LocalDate endDate = startDate.plusMonths(1).minusDays(1);
        return paymentRepository.countPaymentsByDateRange(startDate, endDate);
    }
}