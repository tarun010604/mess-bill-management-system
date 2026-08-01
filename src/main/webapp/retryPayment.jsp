<%
    String msg = (String) request.getAttribute("msg");
    String paymentLink = (String) request.getAttribute("paymentLink");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Retry Payment</title>
<style>
    body { font-family: Arial; background:#f4f6f9; padding:30px; }
    .box { max-width:700px; margin:auto; background:white; padding:25px; border-radius:10px; }
    .msg { color: green; font-weight: bold; margin-bottom: 15px; }
    a.btn {
        display:inline-block; padding:10px 14px; background:#2563eb; color:white;
        text-decoration:none; border-radius:6px; margin-top:12px;
    }
</style>
</head>
<body>
<div class="box">
    <% if (msg != null) { %>
        <div class="msg"><%= msg %></div>
    <% } %>

    <% if (paymentLink != null) { %>
        <p>Open the new payment link below:</p>
        <a class="btn" href="<%= paymentLink %>">Open Payment Page</a>
    <% } %>
</div>
</body>
</html>