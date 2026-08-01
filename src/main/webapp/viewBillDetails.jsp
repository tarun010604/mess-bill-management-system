<%@ page import="com.messbill.Entity.Bill" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    Bill bill = (Bill) request.getAttribute("bill");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MMM-yyyy");

    double billAmount = bill.getTotalAmount() == null ? 0.0 : bill.getTotalAmount();
    double lateFee = bill.getLateFee() == null ? 0.0 : bill.getLateFee();

    if (lateFee == 0.0
            && bill.getDueDate() != null
            && LocalDate.now().isAfter(bill.getDueDate())
            && !"Paid".equalsIgnoreCase(bill.getStatus())) {
        lateFee = 100.0;
    }

    double payableAmount = billAmount + lateFee;
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Bill Details</title>

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

border-radius: 0px 0px 25px 25px;

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

max-width:900px;

margin:auto;

background:rgba(255,255,255,.95);

backdrop-filter:blur(18px);

padding:35px;

border-radius:30px;

box-shadow:
0 20px 45px rgba(0,0,0,.10);

}

.page-title{

font-size:38px;

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
DETAIL CARD
=========================*/

.detail-card{

background:
linear-gradient(
135deg,
#eff6ff,
#dbeafe);

padding:30px;

border-radius:24px;

box-shadow:
0 12px 30px rgba(37,99,235,.10);

}

.row{

display:flex;

justify-content:space-between;

align-items:center;

padding:16px 0;

border-bottom:1px solid #dbeafe;

}

.label{

font-weight:700;

color:#334155;

font-size:16px;

}

.value{

font-size:16px;

font-weight:600;

color:#0f172a;

}

.amount{

font-size:18px;

font-weight:700;

color:#1d4ed8;

}

.total{

font-size:22px;

font-weight:800;

color:#16a34a;

}

.buttons{

margin-top:35px;

display:flex;

justify-content:center;

gap:18px;

flex-wrap:wrap;

}

.btn{

display:inline-flex;

align-items:center;

justify-content:center;

padding:14px 28px;

border-radius:14px;

font-size:16px;

font-weight:700;

text-decoration:none;

border:none;

cursor:pointer;

transition:.3s;

}

.print-btn{

background:
linear-gradient(
135deg,
#2563eb,
#1d4ed8);

color:white;

}

.print-btn:hover{

transform:translateY(-3px);

box-shadow:
0 15px 30px rgba(37,99,235,.25);

}

.back-btn{

background:#6b7280;

color:white;

}

.back-btn:hover{

background:#4b5563;

transform:translateY(-3px);

box-shadow:
0 15px 30px rgba(75,85,99,.20);

}


/*=========================
RESPONSIVE
=========================*/

@media(max-width:768px){

body{

padding:15px;

}

.topbar{

flex-direction:column;

text-align:center;

gap:20px;

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

padding:22px;

}

.page-title{

font-size:30px;

text-align:center;

}

.subtitle{

text-align:center;

}

.row{

flex-direction:column;

align-items:flex-start;

gap:8px;

}

.label{

font-size:15px;

}

.value{

font-size:15px;

}

.buttons{

flex-direction:column;

}

.btn{

width:100%;

}

}

@media(max-width:480px){

.page-title{

font-size:26px;

}

.detail-card{

padding:20px;

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

.buttons{

display:none;

}

.container{

max-width:100%;

box-shadow:none;

padding:0;

background:white;

}

.detail-card{

box-shadow:none;

background:white;

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


</style>

</head>

<body>

<div class="topbar">

<div class="topbar-left">

<img
src="<%=request.getContextPath()%>/images/Screenshot 2026-05-29 114949.png"
class="logo">

<div>

<h2>Visionary Institute of Technology</h2>

<p>Mess Billing Management System</p>

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

Bill Details

</h1>

<p class="subtitle">

View complete student mess bill information.

</p>

<div class="detail-card">

<div class="row">

<div class="label">

Student Name

</div>

<div class="value">

<%= bill.getStudent().getName() %>

</div>

</div>


<div class="row">

<div class="label">

Roll Number

</div>

<div class="value">

<%= bill.getStudent().getRollNo() %>

</div>

</div>


<div class="row">

<div class="label">

Department

</div>

<div class="value">

<%= bill.getStudent().getDepartment() %>

</div>

</div>


<div class="row">

<div class="label">

Billing Month

</div>

<div class="value">

<%= bill.getMonth() %>

</div>

</div>


<div class="row">

<div class="label">

Academic Year

</div>

<div class="value">

<%= bill.getYear() %>

</div>

</div>


<hr style="margin:25px 0;border:none;border-top:2px dashed #bfdbfe;">


<h2 style="color:#2563eb;
margin-bottom:20px;
font-size:24px;
font-weight:700;">

🍽 Meal Summary

</h2>


<div class="row">

<div class="label">

Breakfast Count

</div>

<div class="value">

<%= bill.getBreakfastCount() %>

Meals

</div>

</div>


<div class="row">

<div class="label">

Lunch Count

</div>

<div class="value">

<%= bill.getLunchCount() %>

Meals

</div>

</div>


<div class="row">

<div class="label">

Dinner Count

</div>

<div class="value">

<%= bill.getDinnerCount() %>

Meals

</div>

</div>


<hr style="margin:25px 0;border:none;border-top:2px dashed #bfdbfe;">


<h2 style="color:#2563eb;
margin-bottom:20px;
font-size:24px;
font-weight:700;">

💰 Bill Summary

</h2>

<div class="row">

<div class="label">

Bill Amount

</div>

<div class="value amount">

₹ <%= String.format("%.2f", billAmount) %>

</div>

</div>


<div class="row">

<div class="label">

Late Fee

</div>

<div class="value <%= lateFee>0 ? "amount" : "" %>">

₹ <%= String.format("%.2f", lateFee) %>

</div>

</div>


<div class="row"
style="
background:#ecfdf5;
padding:18px;
margin:15px 0;
border-radius:16px;
border:2px solid #86efac;">

<div class="label"
style="font-size:18px;">

Total Payable

</div>

<div class="total">

₹ <%= String.format("%.2f", payableAmount) %>

</div>

</div>


<div class="row">

<div class="label">

Due Date

</div>

<div class="value">

<%= bill.getDueDate()!=null ?
bill.getDueDate().format(formatter) : "N/A" %>

</div>

</div>


<div class="row">

<div class="label">

Generated Date

</div>

<div class="value">

<%= bill.getGeneratedDate()!=null ?
bill.getGeneratedDate().format(formatter) : "N/A" %>

</div>

</div>


<div class="row">

<div class="label">

Payment Status

</div>

<div>

<%

if("Paid".equalsIgnoreCase(bill.getStatus())){

%>

<span style="
display:inline-block;
background:#16a34a;
color:white;
padding:8px 20px;
border-radius:30px;
font-weight:700;
font-size:14px;">

✔ Paid

</span>

<%

}else{

%>

<span style="
display:inline-block;
background:#dc2626;
color:white;
padding:8px 20px;
border-radius:30px;
font-weight:700;
font-size:14px;">

⏳ Pending

</span>

<%

}

%>

</div>

</div>

<div class="buttons">

<button
type="button"
class="btn print-btn"
onclick="window.print()">

🖨 Print Bill

</button>

<a
href="viewBills"
class="btn back-btn">

⬅ Back to Bills

</a>

</div>

</div>

</div>
</body>