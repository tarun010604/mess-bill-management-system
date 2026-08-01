<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.messbill.Entity.Bill" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");

    String keyword = request.getParameter("keyword");
    String month = request.getParameter("month");
    String year = request.getParameter("year");
    String billStatus = request.getParameter("billStatus");
    String studentStatus = request.getParameter("studentStatus");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>View Bills</title>

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


/*==========================
TOPBAR
===========================*/

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

flex-wrap:wrap;

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


/*==========================
MAIN CONTAINER
===========================*/

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

font-size:16px;

color:#64748b;

margin-bottom:35px;

}


/*==========================
MESSAGE
===========================*/

.msg{

padding:16px;

background:#dcfce7;

border-left:6px solid #16a34a;

border-radius:14px;

font-weight:600;

color:#166534;

margin-bottom:25px;

}


/*==========================
SEARCH CARD
===========================*/

.search-card{

background:
linear-gradient(
135deg,
#eff6ff,
#dbeafe);

padding:30px;

border-radius:25px;

box-shadow:
0 12px 30px rgba(37,99,235,.10);

margin-bottom:35px;

}

.search-title{

font-size:30px;

font-weight:700;

color:#2563eb;

margin-bottom:28px;

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

gap:20px;

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

border-radius:14px;

border:2px solid #bfdbfe;

font-size:15px;

background:white;

transition:.3s;

}

.form-group input:focus,
.form-group select:focus{

outline:none;

border-color:#2563eb;

box-shadow:
0 0 0 5px rgba(37,99,235,.15);

}

.search-btn{

height:55px;

padding:0 28px;

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

box-shadow:
0 15px 30px rgba(37,99,235,.25);

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

min-width:1600px;

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

.status-active{

display:inline-block;

background:#2563eb;

color:white;

padding:7px 16px;

border-radius:30px;

font-size:13px;

font-weight:700;

}

.status-inactive{

display:inline-block;

background:#6b7280;

color:white;

padding:7px 16px;

border-radius:30px;

font-size:13px;

font-weight:700;

}

.status-paid{

display:inline-block;

background:#16a34a;

color:white;

padding:7px 16px;

border-radius:30px;

font-size:13px;

font-weight:700;

}

.status-pending{

display:inline-block;

background:#dc2626;

color:white;

padding:7px 16px;

border-radius:30px;

font-size:13px;

font-weight:700;

}

.view-btn{

display:inline-block;

padding:10px 18px;

border-radius:10px;

background:

linear-gradient(
135deg,
#2563eb,
#1d4ed8);

color:white;

text-decoration:none;

font-weight:600;

transition:.3s;

}

.view-btn:hover{

transform:translateY(-2px);

box-shadow:0 10px 20px rgba(37,99,235,.25);

}

@media(max-width:1200px){

.search-form{

grid-template-columns:repeat(2,1fr);

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

.page-title{

font-size:32px;

text-align:center;

}

.subtitle{

text-align:center;

}

.search-form{

grid-template-columns:1fr;

}

.table-responsive{

overflow-x:auto;

}

table{

min-width:1400px;

}

.search-btn{

width:100%;

}

.container{

padding:20px;

}

}

@media(max-width:480px){

.page-title{

font-size:28px;

}

.search-title,

.table-title{

font-size:24px;

}

.dashboard-btn,

.logout-btn{

width:100%;

text-align:center;

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

View Bills

</h1>

<p class="subtitle">

Search, Filter and View Student Mess Bills

</p>

<%

String msg=request.getParameter("msg");

if(msg!=null){

%>

<div class="msg">

<%=msg%>

</div>

<%

}

%>

<div class="search-card">

<h2 class="search-title">

🔍 Search Bills

</h2>

<form method="get"

action="viewBills"

class="search-form">
<div class="form-group">

<label>Student</label>

<input
type="text"
name="keyword"
placeholder="Search Name or Roll No"
value="<%= keyword==null?"":keyword %>">

</div>


<div class="form-group">

<label>Month</label>

<select name="month">

<option value="">All Months</option>

<option value="January" <%= "January".equals(month)?"selected":"" %>>January</option>
<option value="February" <%= "February".equals(month)?"selected":"" %>>February</option>
<option value="March" <%= "March".equals(month)?"selected":"" %>>March</option>
<option value="April" <%= "April".equals(month)?"selected":"" %>>April</option>
<option value="May" <%= "May".equals(month)?"selected":"" %>>May</option>
<option value="June" <%= "June".equals(month)?"selected":"" %>>June</option>
<option value="July" <%= "July".equals(month)?"selected":"" %>>July</option>
<option value="August" <%= "August".equals(month)?"selected":"" %>>August</option>
<option value="September" <%= "September".equals(month)?"selected":"" %>>September</option>
<option value="October" <%= "October".equals(month)?"selected":"" %>>October</option>
<option value="November" <%= "November".equals(month)?"selected":"" %>>November</option>
<option value="December" <%= "December".equals(month)?"selected":"" %>>December</option>

</select>

</div>


<div class="form-group">

<label>Year</label>

<input
type="number"
name="year"
placeholder="2026"
value="<%= year==null?"":year %>">

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

📄 All Bills

</h2>

<div class="table-responsive">

<table>

<thead>

<tr>

<th>Student Name</th>

<th>Roll No</th>

<th>Student Status</th>

<th>Month</th>

<th>Year</th>

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

<%= b.getMonth() %>

</td>

<td>

<%= b.getYear() %>

</td>

<td>

₹ <%= String.format("%.2f", billAmount) %>

</td>

<td>

₹ <%= String.format("%.2f", lateFee) %>

</td>

<td>

<strong>

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

Paid

</span>

<%

}else{

%>

<span class="status-pending">

Pending

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

href="billDetails?billId=<%=b.getBillId()%>"

class="view-btn">

👁 View

</a>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="12"
style="padding:35px;
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