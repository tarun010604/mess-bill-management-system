<%@ page import="com.messbill.Entity.Bill" %>
<%@ page import="com.messbill.Service.BillService" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String billIdStr = request.getParameter("billId");
    String msg = request.getParameter("msg");

    BillService billService = new BillService();
    Bill bill = null;

    if (billIdStr != null && !billIdStr.trim().isEmpty()) {
        try {
            Integer billId = Integer.parseInt(billIdStr);
            bill = billService.findBillById(billId);
        } catch (NumberFormatException e) {
            bill = null;
        }
    }

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MMM-yyyy");

    boolean canPay = false;
    if (bill != null && bill.getStudent() != null) {
        String studentStatus = bill.getStudent().getStatus();
        canPay = "Active".equalsIgnoreCase(studentStatus)
                && !"Paid".equalsIgnoreCase(bill.getStatus());
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment</title>
<style>
    body{
        font-family:Arial,sans-serif;
        background:#f4f6f9;
        padding:20px;
    }

    .box{
        max-width:700px;
        margin:auto;
        background:white;
        padding:25px;
        border-radius:12px;
        box-shadow:0 2px 10px rgba(0,0,0,0.08);
    }

    .row{
        display:flex;
        justify-content:space-between;
        padding:10px 0;
        border-bottom:1px solid #eee;
    }

    .label{
        font-weight:bold;
    }

    .btn{
        padding:10px 16px;
        border:none;
        border-radius:6px;
        color:white;
        cursor:pointer;
        font-weight:bold;
        text-decoration:none;
        display:inline-block;
    }

    .pay{
        background:#16a34a;
    }

    .back{
        background:#6b7280;
    }

    select{
        padding:8px;
        width:250px;
    }

    .buttons{
        margin-top:25px;
        display:flex;
        gap:10px;
        flex-wrap:wrap;
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

    .badges {
        margin-top: 10px;
        margin-bottom: 15px;
    }

    .badge {
        display:inline-block;
        padding:6px 10px;
        border-radius:5px;
        color:white;
        font-weight:bold;
        margin-right:6px;
    }

    .active { background:#2563eb; }
    .inactive { background:#6b7280; }
    .paid { background:#16a34a; }
    .pending { background:#dc2626; }
</style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="box">
    <h2>Payment</h2>

    <% if (msg != null) { %>
        <div class="<%= msg.toLowerCase().contains("success") ? "msg" : "error" %>">
            <%= msg %>
        </div>
    <% } %>

    <%
        if (bill != null) {
            String studentStatus = bill.getStudent() != null ? bill.getStudent().getStatus() : "";
    %>

        <div class="badges">
            <span class="badge <%= "Active".equalsIgnoreCase(studentStatus) ? "active" : "inactive" %>">
                Student: <%= studentStatus %>
            </span>

            <span class="badge <%= "Paid".equalsIgnoreCase(bill.getStatus()) ? "paid" : "pending" %>">
                Bill: <%= bill.getStatus() %>
            </span>
        </div>

        <div class="row">
            <div class="label">Student Name</div>
            <div><%= bill.getStudent().getName() %></div>
        </div>

        <div class="row">
            <div class="label">Roll No</div>
            <div><%= bill.getStudent().getRollNo() %></div>
        </div>

        <div class="row">
            <div class="label">Month</div>
            <div><%= bill.getMonth() %></div>
        </div>

        <div class="row">
            <div class="label">Total Amount</div>
            <div>Rs. <%= bill.getTotalAmount() %></div>
        </div>

        <div class="row">
            <div class="label">Due Date</div>
            <div>
                <%= bill.getDueDate() != null ? bill.getDueDate().format(formatter) : "N/A" %>
            </div>
        </div>

        <br>

        <%
            if (canPay) {
        %>
            <form action="payBill" method="post">
                <input type="hidden" name="billId" value="<%= bill.getBillId() %>">

                <label><b>Payment Method</b></label>
                <br><br>

                <select name="paymentMethod" required>
                    <option value="">-- Select Payment Method --</option>
                    <option value="Cash">Cash</option>
                    <option value="UPI">UPI</option>
                    <option value="Net Banking">Net Banking</option>
                </select>

                <div class="buttons">
                    <button class="btn pay" type="submit">Confirm Payment</button>
                    <a class="btn back" href="billDetails?billId=<%= bill.getBillId() %>">Back</a>
                </div>
            </form>
        <%
            } else {
        %>
            <div class="error">
                Payment is not allowed for this bill.
                <%= "Paid".equalsIgnoreCase(bill.getStatus()) ? " This bill is already paid." : "" %>
                <%= "Active".equalsIgnoreCase(studentStatus) ? "" : " The student is inactive." %>
            </div>

            <div class="buttons">
                <a class="btn back" href="billDetails?billId=<%= bill.getBillId() %>">Back</a>
            </div>
        <%
            }
        %>

    <%
        } else {
    %>
        <h3>Bill Not Found</h3>
        <a class="btn back" href="viewBills.jsp">Back</a>
    <%
        }
    %>
</div>

</body>
</html>