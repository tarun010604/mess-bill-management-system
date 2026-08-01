<%
    String msg = (String) request.getAttribute("msg");
    if (msg == null) {
        msg = request.getParameter("msg");
    }

    Object billIdObj = request.getAttribute("billId");
    String billId = null;

    if (billIdObj != null) {
        billId = billIdObj.toString();
    } else {
        billId = request.getParameter("billId");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Error</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background: #f4f6f9;
        padding: 40px;
    }
    .box {
        max-width: 500px;
        margin: auto;
        background: white;
        padding: 25px;
        border-radius: 10px;
        text-align: center;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    }
    .error {
        color: red;
        font-weight: bold;
        font-size: 18px;
    }
    .btn {
        display: inline-block;
        padding: 10px 14px;
        background: #2563eb;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        margin-top: 15px;
    }
</style>
</head>
<body>
<div class="box">
    <h2 class="error"><%= msg == null ? "Payment error" : msg %></h2>

    <% if (billId != null && !billId.trim().isEmpty()) { %>
        <a class="btn" href="retryPayment?billId=<%= billId %>">Retry Payment</a>
    <% } %>
</div>
</body>
</html>