<%@ page import="com.messbill.Entity.Bill" %>
<%@ page import="com.messbill.Entity.Payment" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    Bill bill = (Bill) request.getAttribute("bill");
    Payment payment = (Payment) request.getAttribute("payment");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MMM-yyyy");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Success</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background: #f4f6f9;
        padding: 30px;
    }

    .box {
        max-width: 700px;
        margin: auto;
        background: white;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    }

    .success {
        color: #16a34a;
        font-weight: bold;
        font-size: 22px;
        margin-bottom: 20px;
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

    .btn {
        padding: 10px 16px;
        border: none;
        border-radius: 6px;
        text-decoration: none;
        color: white;
        display: inline-block;
        margin-top: 20px;
    }

    .print {
        background: #0f766e;
    }

    .back {
        background: #6b7280;
    }

    .buttons {
        display: flex;
        gap: 10px;
        margin-top: 20px;
        flex-wrap: wrap;
    }
</style>
</head>
<body>

<div class="box">
    <div class="success">Payment Completed Successfully</div>

    <div class="row">
        <div class="label">Student Name</div>
        <div><%= bill != null && bill.getStudent() != null ? bill.getStudent().getName() : "" %></div>
    </div>

    <div class="row">
        <div class="label">Roll No</div>
        <div><%= bill != null && bill.getStudent() != null ? bill.getStudent().getRollNo() : "" %></div>
    </div>

    <div class="row">
        <div class="label">Month</div>
        <div><%= bill != null ? bill.getMonth() : "" %></div>
    </div>

    <div class="row">
        <div class="label">Amount Paid</div>
        <div>Rs. <%= payment != null ? payment.getAmount() : "" %></div>
    </div>

    <div class="row">
        <div class="label">Late Fee</div>
        <div>Rs. <%= payment != null ? payment.getLateFee() : "" %></div>
    </div>

    <div class="row">
        <div class="label">Payment Date</div>
        <div><%= payment != null && payment.getPaymentDate() != null ? payment.getPaymentDate().format(formatter) : "" %></div>
    </div>

    <div class="row">
        <div class="label">Reference No</div>
        <div><%= payment != null ? payment.getReferenceNo() : "" %></div>
    </div>

    <div class="buttons">
        <button class="btn print" onclick="window.print()">Print</button>
      
    </div>
</div>

</body>
</html>