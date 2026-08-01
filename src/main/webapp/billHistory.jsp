<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.messbill.Entity.Bill" %>
<%@ page import="com.messbill.Service.BillService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String keyword = request.getParameter("keyword");
    String month = request.getParameter("month");
    String yearStr = request.getParameter("year");
    String billStatus = request.getParameter("billStatus");
    String studentStatus = request.getParameter("studentStatus");

    Integer year = null;
    if (yearStr != null && !yearStr.trim().isEmpty()) {
        try {
            year = Integer.parseInt(yearStr);
        } catch (NumberFormatException e) {
            year = null;
        }
    }

    BillService billService = new BillService();
    List<Bill> bills = billService.searchBills(keyword, month, year, billStatus, studentStatus);

    Long totalBills = billService.getTotalBillsCount();
    Long pendingBills = billService.getPendingBillsCount();
    Long paidBills = billService.getPaidBillsCount();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Bill History</title>

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

max-width:1800px;

margin:auto;

background:rgba(255,255,255,.96);

backdrop-filter:blur(18px);

padding:35px;

border-radius:30px;

box-shadow:
0 20px 45px rgba(0,0,0,.10);

}

.page-title{

font-size:42px;

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

color:#64748b;

font-size:16px;

margin-bottom:30px;

}


/*=========================
SUMMARY CARDS
=========================*/

.summary{

display:grid;

grid-template-columns:repeat(3,1fr);

gap:20px;

margin-bottom:35px;

}

.card{

background:
linear-gradient(
135deg,
#eff6ff,
#dbeafe);

padding:25px;

border-radius:22px;

box-shadow:
0 12px 30px rgba(37,99,235,.10);

text-align:center;

transition:.3s;

}

.card:hover{

transform:translateY(-4px);

}

.card h3{

font-size:15px;

color:#475569;

margin-bottom:10px;

}

.card h1{

font-size:34px;

font-weight:800;

color:#2563eb;

}


/*=========================
SEARCH CARD
=========================*/

.search-card{

background:
linear-gradient(
135deg,
#eff6ff,
#dbeafe);

padding:30px;

border-radius:24px;

box-shadow:
0 12px 30px rgba(37,99,235,.10);

margin-bottom:35px;

}

.search-title{

font-size:28px;

font-weight:700;

color:#2563eb;

margin-bottom:25px;

}

.search-form{

display:grid;

grid-template-columns:
2fr
1fr
1fr
1fr
1fr
auto;

gap:18px;

align-items:end;

}

.form-group{

display:flex;

flex-direction:column;

}

.form-group label{

font-weight:600;

margin-bottom:8px;

color:#334155;

}

.form-group input,
.form-group select{

height:55px;

padding:0 18px;

border:2px solid #bfdbfe;

border-radius:14px;

font-size:15px;

background:white;

}

.form-group input:focus,
.form-group select:focus{

outline:none;

border-color:#2563eb;

box-shadow:0 0 0 5px rgba(37,99,235,.15);

}

.search-btn{

height:55px;

padding:0 30px;

border:none;

border-radius:14px;

background:
linear-gradient(
135deg,
#2563eb,
#1d4ed8);

color:white;

font-size:17px;

font-weight:700;

cursor:pointer;

transition:.3s;

}

.search-btn:hover{

transform:translateY(-3px);

box-shadow:0 15px 30px rgba(37,99,235,.25);

}

.table-card{

background:white;

padding:30px;

border-radius:25px;

box-shadow:0 15px 35px rgba(0,0,0,.08);

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

min-width:1850px;

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

.status-active,
.status-inactive,
.status-paid,
.status-pending{

display:inline-block;

padding:8px 18px;

border-radius:30px;

font-size:13px;

font-weight:700;

color:white;

}

.status-active{

background:#2563eb;

}

.status-inactive{

background:#6b7280;

}

.status-paid{

background:#16a34a;

}

.status-pending{

background:#dc2626;

}

.print-btn{

display:inline-block;

padding:10px 18px;

border-radius:10px;

background:

linear-gradient(
135deg,
#0f766e,
#115e59);

color:white;

text-decoration:none;

font-weight:600;

transition:.3s;

}

.print-btn:hover{

transform:translateY(-2px);

box-shadow:0 10px 20px rgba(15,118,110,.25);

}

/*=========================
RESPONSIVE
=========================*/

@media(max-width:1200px){

.summary{

grid-template-columns:repeat(2,1fr);

}

.search-form{

grid-template-columns:repeat(2,1fr);

}

.table-responsive{

overflow-x:auto;

}

table{

min-width:1700px;

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

.summary{

grid-template-columns:1fr;

}

.search-form{

grid-template-columns:1fr;

}

.search-btn{

width:100%;

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

.search-title,
.table-title{

font-size:22px;

}

.card h1{

font-size:28px;

}

.card h3{

font-size:14px;

}

.table-card{

padding:18px;

}

th,
td{

padding:12px;

font-size:13px;

}

.status-active,
.status-inactive,
.status-paid,
.status-pending{

font-size:12px;

padding:6px 14px;

}

.print-btn{

padding:8px 14px;

font-size:13px;

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

.search-card{

display:none;

}

.container{

max-width:100%;

padding:0;

background:white;

box-shadow:none;

}

.summary{

display:none;

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

</style>

</head>

<body>

<div class="topbar">

<div class="topbar-left">

<img src="<%=request.getContextPath()%>/images/Screenshot 2026-05-29 114949.png"
class="logo">

<div>

<h2>Visionary Institute of Technology</h2>

<p>Mess Billing Management System</p>

</div>

</div>

<div class="topbar-right">

<a href="dashboard.jsp" class="dashboard-btn">

Dashboard

</a>

<a href="logout" class="logout-btn">

Logout

</a>

</div>

</div>

<div class="container">

<h1 class="page-title">

Bill History

</h1>

<p class="subtitle">

Search and review all generated student mess bills.

</p>

<div class="summary">

<div class="card">

<h3>Total Bills</h3>

<h1><%= totalBills %></h1>

</div>

<div class="card">

<h3>Pending Bills</h3>

<h1><%= pendingBills %></h1>

</div>

<div class="card">

<h3>Paid Bills</h3>

<h1><%= paidBills %></h1>

</div>

</div>

<div class="search-card">

<h2 class="search-title">

🔍 Search Bills

</h2>

<form method="get"

action="billHistory.jsp"

class="search-form">

<div class="form-group">

<label>Student</label>

<input
type="text"
name="keyword"
placeholder="Search Name or Roll No"
value="<%= keyword==null ? "" : keyword %>">

</div>


<div class="form-group">

<label>Month</label>

<select name="month">

<option value="">All Months</option>

<option value="January" <%= "January".equalsIgnoreCase(month)?"selected":"" %>>January</option>
<option value="February" <%= "February".equalsIgnoreCase(month)?"selected":"" %>>February</option>
<option value="March" <%= "March".equalsIgnoreCase(month)?"selected":"" %>>March</option>
<option value="April" <%= "April".equalsIgnoreCase(month)?"selected":"" %>>April</option>
<option value="May" <%= "May".equalsIgnoreCase(month)?"selected":"" %>>May</option>
<option value="June" <%= "June".equalsIgnoreCase(month)?"selected":"" %>>June</option>
<option value="July" <%= "July".equalsIgnoreCase(month)?"selected":"" %>>July</option>
<option value="August" <%= "August".equalsIgnoreCase(month)?"selected":"" %>>August</option>
<option value="September" <%= "September".equalsIgnoreCase(month)?"selected":"" %>>September</option>
<option value="October" <%= "October".equalsIgnoreCase(month)?"selected":"" %>>October</option>
<option value="November" <%= "November".equalsIgnoreCase(month)?"selected":"" %>>November</option>
<option value="December" <%= "December".equalsIgnoreCase(month)?"selected":"" %>>December</option>

</select>

</div>


<div class="form-group">

<label>Year</label>

<input
type="number"
name="year"
placeholder="Enter Year"
value="<%= yearStr==null ? "" : yearStr %>">

</div>


<div class="form-group">

<label>Bill Status</label>

<select name="billStatus">

<option value="">All Bills</option>

<option value="Paid"
<%= "Paid".equalsIgnoreCase(billStatus)?"selected":"" %>>

Paid

</option>

<option value="Pending"
<%= "Pending".equalsIgnoreCase(billStatus)?"selected":"" %>>

Pending

</option>

</select>

</div>


<div class="form-group">

<label>Student Status</label>

<select name="studentStatus">

<option value="">All Students</option>

<option value="Active"
<%= "Active".equalsIgnoreCase(studentStatus)?"selected":"" %>>

Active

</option>

<option value="Inactive"
<%= "Inactive".equalsIgnoreCase(studentStatus)?"selected":"" %>>

Inactive

</option>

</select>

</div>


<div>

<button
type="submit"
class="search-btn">

🔍 Search

</button>

</div>

</form>

</div>


<div class="table-card">

<h2 class="table-title">

📄 Bill Records

</h2>

<div class="table-responsive">

<table>

<thead>

<tr>

<th>Student Name</th>

<th>Roll No</th>

<th>Student Status</th>

<th>Department</th>

<th>Month</th>

<th>Year</th>

<th>Breakfast</th>

<th>Lunch</th>

<th>Dinner</th>

<th>Bill Amount</th>

<th>Late Fee</th>

<th>Total Payable</th>

<th>Due Date</th>

<th>Bill Status</th>

<th>Generated Date</th>

<th>Action</th>

</tr>

</thead>

<tbody>
<%
if (bills != null && !bills.isEmpty()) {

    for (Bill b : bills) {

        String stuStatus = "";

        if (b.getStudent() != null && b.getStudent().getStatus() != null) {
            stuStatus = b.getStudent().getStatus();
        }

        double billAmount = b.getTotalAmount() == null ? 0.0 : b.getTotalAmount();
        double lateFee = b.getLateFee() == null ? 0.0 : b.getLateFee();

        if (lateFee == 0.0
                && b.getDueDate() != null
                && LocalDate.now().isAfter(b.getDueDate())
                && !"Paid".equalsIgnoreCase(b.getStatus())) {

            lateFee = 100.0;
        }

        double payableAmount = billAmount + lateFee;
%>

<tr>

<td>

<%= b.getStudent()!=null ? b.getStudent().getName() : "" %>

</td>

<td>

<%= b.getStudent()!=null ? b.getStudent().getRollNo() : "" %>

</td>

<td>

<%

if("Active".equalsIgnoreCase(stuStatus)){

%>

<span class="status-active">

Active

</span>

<%

}else{

%>

<span class="status-inactive">

Inactive

</span>

<%

}

%>

</td>

<td>

<%= b.getStudent()!=null ? b.getStudent().getDepartment() : "" %>

</td>

<td>

<%= b.getMonth() %>

</td>

<td>

<%= b.getYear() %>

</td>

<td>

<%= b.getBreakfastCount() %>

</td>

<td>

<%= b.getLunchCount() %>

</td>

<td>

<%= b.getDinnerCount() %>

</td>

<td>

<strong>

₹ <%= String.format("%.2f", billAmount) %>

</strong>

</td>

<td>

<%

if(lateFee>0){

%>

<span style="color:#dc2626;font-weight:700;">

₹ <%= String.format("%.2f", lateFee) %>

</span>

<%

}else{

%>

<span style="color:#16a34a;font-weight:700;">

₹ 0.00

</span>

<%

}

%>

</td>

<td>

<strong style="color:#1d4ed8;">

₹ <%= String.format("%.2f", payableAmount) %>

</strong>

</td>

<td>

<%= b.getDueDate() %>

</td>

<td>

<%

if("Paid".equalsIgnoreCase(b.getStatus())){

%>

<span class="status-paid">

✔ Paid

</span>

<%

}else{

%>

<span class="status-pending">

⏳ Pending

</span>

<%

}

%>

</td>

<td>

<%= b.getGeneratedDate() %>

</td>

<td>

<a

href="billDetails?billId=<%= b.getBillId() %>&mode=history"

class="print-btn">

🖨 Print

</a>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="16"
style="padding:40px;
font-size:18px;
font-weight:600;
color:#64748b;">

No Bills Found

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