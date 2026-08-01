<%@ page import="java.util.List" %>
<%@ page import="com.messbill.Entity.Payment" %>
<%@ page import="com.messbill.Service.PaymentService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    PaymentService paymentService =
            new PaymentService();

    List<Payment> payments =
            paymentService.getAllPayments();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Payment History</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{

background:
linear-gradient(
135deg,
#dbeafe,
#bfdbfe,
#93c5fd,
#60a5fa);

padding:25px;

}


/*=========================
TOPBAR
=========================*/

.topbar{

background:
linear-gradient(
135deg,
#1e3a8a,
#2563eb,
#3b82f6);

display:flex;

justify-content:space-between;

align-items:center;

padding:18px 30px;

border-radius:0 0 25px 25px;

margin-bottom:30px;

box-shadow:
0 18px 35px rgba(37,99,235,.30);

}

.topbar-left{

display:flex;

align-items:center;

gap:18px;

}

.logo{

width:72px;

height:72px;

background:white;

padding:4px;

border-radius:50%;

object-fit:cover;

}

.topbar-left h2{

color:white;

font-size:20px;

font-weight:700;

}

.topbar-left p{

color:white;

font-size:14px;

opacity:.9;

}

.topbar-right{

display:flex;

gap:15px;

}

.dashboard-btn,
.logout-btn{

text-decoration:none;

padding:13px 24px;

border-radius:14px;

font-weight:700;

transition:.3s;

}

.dashboard-btn{

background:white;

color:#2563eb;

}

.dashboard-btn:hover{

transform:translateY(-3px);

}

.logout-btn{

background:#ef4444;

color:white;

}

.logout-btn:hover{

background:#dc2626;

transform:translateY(-3px);

}


/*=========================
MAIN CONTAINER
=========================*/

.container{

max-width:1700px;

margin:auto;

background:rgba(255,255,255,.96);

backdrop-filter:blur(18px);

padding:35px;

border-radius:30px;

box-shadow:
0 20px 45px rgba(0,0,0,.10);

}

.page-title{

font-size:40px;

font-weight:800;

background:
linear-gradient(
90deg,
#1e3a8a,
#2563eb,
#60a5fa);

-webkit-background-clip:text;

-webkit-text-fill-color:transparent;

margin-bottom:8px;

}

.subtitle{

font-size:16px;

color:#64748b;

margin-bottom:30px;

}


/*=========================
TABLE CARD
=========================*/

.table-card{

background:white;

padding:30px;

border-radius:25px;

box-shadow:
0 15px 35px rgba(0,0,0,.08);

}

.table-title{

font-size:30px;

font-weight:700;

color:#2563eb;

margin-bottom:25px;

}

.table-responsive{

overflow-x:auto;

}

table{

width:100%;

min-width:1400px;

border-collapse:collapse;

}

thead{

background:
linear-gradient(
135deg,
#1e3a8a,
#2563eb);

color:white;

}

th{

padding:18px;

font-size:15px;

font-weight:700;

}

td{

padding:16px;

text-align:center;

border-bottom:1px solid #e5e7eb;

}

tbody tr:nth-child(even){

background:#f8fbff;

}

tbody tr:hover{

background:#dbeafe;

transition:.3s;

}

/*=========================
RESPONSIVE
=========================*/

@media(max-width:1200px){

.table-responsive{

overflow-x:auto;

}

table{

min-width:1200px;

}

}

@media(max-width:768px){

body{

padding:15px;

}

.topbar{

flex-direction:column;

gap:20px;

text-align:center;

}

.topbar-left{

flex-direction:column;

}

.topbar-right{

width:100%;

justify-content:center;

flex-wrap:wrap;

}

.logo{

width:65px;

height:65px;

}

.container{

padding:20px;

}

.page-title{

font-size:30px;

text-align:center;

}

.subtitle{

text-align:center;

}

.table-title{

font-size:24px;

text-align:center;

}

.dashboard-btn,
.logout-btn{

width:100%;

text-align:center;

}

}

@media(max-width:480px){

.page-title{

font-size:26px;

}

.table-card{

padding:18px;

}

th,
td{

padding:12px;

font-size:13px;

}

.success,
.failed{

font-size:12px;

padding:6px 14px;

}

}


/*=========================
PRINT
=========================*/

@media print{

body{

background:white;

padding:0;

}

.topbar{

display:none;

}

.container{

max-width:100%;

padding:0;

background:white;

box-shadow:none;

}

.table-card{

box-shadow:none;

padding:0;

}

.page-title{

-webkit-text-fill-color:#000;

color:#000;

}

.subtitle{

display:none;

}

}

.success{

display:inline-block;

padding:8px 18px;

background:#16a34a;

color:white;

border-radius:30px;

font-size:13px;

font-weight:700;

}

.failed{

display:inline-block;

padding:8px 18px;

background:#dc2626;

color:white;

border-radius:30px;

font-size:13px;

font-weight:700;

}

</style>

</head>

<body>

<div class="topbar">

<div class="topbar-left">

<img
src="<%=request.getContextPath()%>/images/Screenshot 2026-05-29 114949.png"
class="logo">

<div>

<h2>

Visionary Institute of Technology

</h2>

<p>

Mess Billing Management System

</p>

</div>

</div>

<div class="topbar-right">

<a
href="dashboard.jsp"
class="dashboard-btn">

Dashboard

</a>

<a
href="logout"
class="logout-btn">

Logout

</a>

</div>

</div>

<div class="container">

<h1 class="page-title">

Payment History

</h1>

<p class="subtitle">

View all successful student payment transactions.

</p>

<div class="table-card">

<h2 class="table-title">

💳 Payment Records

</h2>

<div class="table-responsive">

<table>

<thead>

<tr>

<th>Student Name</th>

<th>Roll No</th>

<th>Month</th>

<th>Year</th>

<th>Amount Paid</th>

<th>Payment Date</th>

<th>Payment Method</th>

<th>Reference No</th>

<th>Status</th>

</tr>

</thead>

<tbody>

<%
if(payments != null && !payments.isEmpty()){

for(Payment p : payments){

String status = p.getTransactionStatus();

%>

<tr>

<td>

<%= p.getBill()
      .getStudent()
      .getName() %>

</td>

<td>

<%= p.getBill()
      .getStudent()
      .getRollNo() %>

</td>

<td>

<%= p.getBill()
      .getMonth() %>

</td>

<td>

<%= p.getBill()
      .getYear() %>

</td>

<td>

<strong>

₹ <%= String.format("%.2f", p.getAmount()) %>

</strong>

</td>

<td>

<%= p.getPaymentDate() %>

</td>

<td>

<%= p.getPaymentMethod() %>

</td>

<td style="font-family:monospace;
font-weight:600;">

<%= p.getReferenceNo() %>

</td>

<td>

<%

if("SUCCESS".equalsIgnoreCase(status)
|| "PAID".equalsIgnoreCase(status)){

%>

<span class="success">

✔ SUCCESS

</span>

<%

}else{

%>

<span class="failed">

✖ FAILED

</span>

<%

}

%>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="9"
style="padding:40px;
font-size:18px;
font-weight:600;
color:#64748b;">

No Payment History Found

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

</div>

</div>

</body>

</html>