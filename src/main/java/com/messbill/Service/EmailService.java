package com.messbill.Service;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailService {

    private static final String FROM_EMAIL = "vit.hosteladmin@gmail.com";
    private static final String APP_PASSWORD = "bgze ajbd euzt klsr";

    public void sendEmail(String toEmail, String subject, String body) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);

            System.out.println("Email sent successfully to: " + toEmail);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void sendLateFeeReminder(
            String toEmail,
            String studentName,
            String month,
            Integer year,
            Double billAmount,
            Double lateFee,
            Double totalPayable,
            String paymentLink) {

        String subject =
                "Overdue Mess Bill Reminder - "
                + month + " " + year;

        String body =
                "Dear " + studentName + ",\n\n"

                + "Your mess bill payment is overdue for "+month+" "+ year+".\n\n"

                + "Original Bill Amount : Rs. "
                + billAmount + "\n"

                + "Late Fee             : Rs. "
                + lateFee + "\n"

                + "Total Payable Amount : Rs. "
                + totalPayable + "\n\n"

                + "Please complete your payment immediately.\n\n"

                + "Payment Link:\n"
                + paymentLink + "\n\n"

                + "Regards,\n"
                + "VIT Hostel Administration\n"
                + "Visionary Institute of Technology";

        sendEmail(toEmail, subject, body);
    }
}