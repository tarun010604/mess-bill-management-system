<%@ page import="com.messbill.Entity.PaymentSession" %>
<%@ page import="java.time.Duration" %>
<%@ page import="java.time.LocalDate" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    PaymentSession sessionObj = (PaymentSession) request.getAttribute("paymentSession");
    String msg = (String) request.getAttribute("msg");

    long remainingSeconds = 0;
    double billAmount = 0.0;
    double lateFee = 0.0;
    double payableAmount = 0.0;
    String dueDateText = "N/A";

    if (sessionObj != null && sessionObj.getBill() != null) {
        remainingSeconds = Duration.between(
                java.time.LocalDateTime.now(),
                sessionObj.getExpiresAt()).getSeconds();

        if (remainingSeconds < 0) {
            remainingSeconds = 0;
        }

        billAmount = sessionObj.getBill().getTotalAmount() == null ? 0.0 : sessionObj.getBill().getTotalAmount();

        if (sessionObj.getBill().getDueDate() != null
                && LocalDate.now().isAfter(sessionObj.getBill().getDueDate())) {
            lateFee = 100.0;
        }

        payableAmount = billAmount + lateFee;
        dueDateText = sessionObj.getBill().getDueDate() != null ? sessionObj.getBill().getDueDate().toString() : "N/A";
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mock Payment Gateway</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background: #f4f6f9;
        padding: 20px;
    }

    .box {
        max-width: 700px;
        margin: auto;
        background: white;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    }

    .row {
        display: flex;
        justify-content: space-between;
        padding: 10px 0;
        border-bottom: 1px solid #eee;
    }

    .label {
        font-weight: bold;
    }

    input, select {
        width: 100%;
        padding: 10px;
        margin-top: 8px;
        box-sizing: border-box;
    }

    .btn {
        margin-top: 15px;
        padding: 12px;
        width: 100%;
        border: none;
        background: #2563eb;
        color: white;
        border-radius: 6px;
        cursor: pointer;
        font-weight: bold;
    }

    .otp-btn {
        background: #0f766e;
    }

    .timer {
        color: red;
        font-weight: bold;
        margin-bottom: 15px;
    }

    .msg {
        color: green;
        font-weight: bold;
        margin-bottom: 12px;
    }

    .error {
        color: red;
        font-weight: bold;
        margin-bottom: 12px;
    }

    .badge {
        display: inline-block;
        padding: 6px 10px;
        border-radius: 5px;
        color: white;
        font-weight: bold;
        margin-right: 6px;
        margin-bottom: 10px;
    }

    .active { background: #2563eb; }
    .inactive { background: #6b7280; }
    .paid { background: #16a34a; }
    .pending { background: #dc2626; }

    .section {
        margin-top: 18px;
        padding-top: 10px;
        border-top: 1px solid #eee;
    }

    .small-text {
        color: #6b7280;
        font-size: 14px;
        margin-top: 8px;
    }
</style>

<script>
    let time = <%= remainingSeconds %>;

    function updateTimer() {
        let min = Math.floor(time / 60);
        let sec = time % 60;

        const timerEl = document.getElementById("timer");

        if (time <= 0) {
            timerEl.innerHTML = "Session expired";
            window.location = "paymentError.jsp?msg=Session%20expired.%20Try%20again%20later";
            return;
        }

        timerEl.innerHTML = "Session expires in: " + min + "m " + sec + "s";
        time--;
    }

    window.onload = function () {
        updateTimer();
        setInterval(updateTimer, 1000);
    };
</script>
</head>

<body>

<div class="box">
    <h2>College Mess Payment Gateway</h2>

    <% if (msg != null) { %>
        <div class="<%= msg.toLowerCase().contains("success") ? "msg" : "error" %>">
            <%= msg %>
        </div>
    <% } %>

    <% if (sessionObj != null && sessionObj.getBill() != null && sessionObj.getBill().getStudent() != null) { %>

        <div id="timer" class="timer"></div>

        <%
            String studentStatus = sessionObj.getBill().getStudent().getStatus();
            String billStatus = sessionObj.getBill().getStatus();
        %>

        <div>
            <span class="badge <%= "Active".equalsIgnoreCase(studentStatus) ? "active" : "inactive" %>">
                Student: <%= studentStatus %>
            </span>

            <span class="badge <%= "Paid".equalsIgnoreCase(billStatus) ? "paid" : "pending" %>">
                Bill: <%= billStatus %>
            </span>
        </div>

        <div class="row">
            <div class="label">Student Name</div>
            <div><%= sessionObj.getBill().getStudent().getName() %></div>
        </div>

        <div class="row">
            <div class="label">Roll No</div>
            <div><%= sessionObj.getBill().getStudent().getRollNo() %></div>
        </div>

        <div class="row">
            <div class="label">Bill Month</div>
            <div><%= sessionObj.getBill().getMonth() %> <%= sessionObj.getBill().getYear() %></div>
        </div>

        <div class="row">
            <div class="label">Due Date</div>
            <div><%= dueDateText %></div>
        </div>

        <div class="row">
            <div class="label">Bill Amount</div>
            <div>Rs. <%= billAmount %></div>
        </div>

        <div class="row">
            <div class="label">Late Fee</div>
            <div>Rs. <%= lateFee %></div>
        </div>

        <div class="row">
            <div class="label">Total Payable</div>
            <div>Rs. <%= payableAmount %></div>
        </div>

        <div class="small-text">
            The payment link is valid only for a few minutes. OTP will be sent to the student email.
        </div>

        <div class="section">
            <form action="sendOtp" method="post">
                <input type="hidden" name="token" value="<%= sessionObj.getToken() %>">
                <button class="btn otp-btn" type="submit">Send OTP</button>
            </form>
        </div>

        <div class="section">
            <form action="verifyPayment" method="post">
                <input type="hidden" name="token" value="<%= sessionObj.getToken() %>">

                <label>Enter Amount</label>
                <input type="number" step="0.01" name="amount" value="<%= payableAmount %>" required>

                <label>Payment Method</label>
                <select name="paymentMethod" required>
                    <option value="">Select</option>
                    <option value="UPI">UPI</option>
                    <option value="Net Banking">Net Banking</option>
                    <option value="Card">Card</option>
                </select>

                <label>Enter OTP</label>
                <input type="text" name="otp" required>

                <button class="btn" type="submit">Pay Now</button>
            </form>
        </div>

    <% } else { %>
        <div class="error">Payment session not found.</div>
    <% } %>
</div>

</body>
</html>