<%@ page import="java.time.LocalDate" %>
<%@ page import="com.messbill.Service.StudentService" %>
<%@ page import="com.messbill.Service.BillService" %>
<%@ page import="com.messbill.Service.PaymentService" %>
<%@ page import="com.messbill.Service.AttendanceService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
    private long nz(Long value) {
        return value == null ? 0L : value.longValue();
    }

    private double ndz(Double value) {
        return value == null ? 0.0 : value.doubleValue();
    }

    private int monthToNumber(String month) {

        if(month == null) return 0;

        switch(month.trim().toLowerCase()) {

            case "january": return 1;
            case "february": return 2;
            case "march": return 3;
            case "april": return 4;
            case "may": return 5;
            case "june": return 6;
            case "july": return 7;
            case "august": return 8;
            case "september": return 9;
            case "october": return 10;
            case "november": return 11;
            case "december": return 12;

            default: return 0;
        }
    }

    private String monthName(int monthNumber) {

        switch(monthNumber) {

            case 1: return "January";
            case 2: return "February";
            case 3: return "March";
            case 4: return "April";
            case 5: return "May";
            case 6: return "June";
            case 7: return "July";
            case 8: return "August";
            case 9: return "September";
            case 10: return "October";
            case 11: return "November";
            case 12: return "December";

            default: return "";
        }
    }
%>

<%
    String monthParam = request.getParameter("month");
    String yearParam = request.getParameter("year");

    LocalDate now = LocalDate.now();

    String selectedMonth =
            (monthParam != null &&
             !monthParam.trim().isEmpty())
            ? monthParam
            : monthName(now.getMonthValue());

    int selectedYear = now.getYear();

    if(yearParam != null &&
       !yearParam.trim().isEmpty()) {

        try {

            selectedYear =
                    Integer.parseInt(yearParam);

        } catch(Exception e) {

            selectedYear = now.getYear();
        }
    }

    int selectedMonthNumber =
            monthToNumber(selectedMonth);

    StudentService studentService =
            new StudentService();

    BillService billService =
            new BillService();

    PaymentService paymentService =
            new PaymentService();

    AttendanceService attendanceService =
            new AttendanceService();

    long totalStudents =
            nz(studentService.getTotalStudentsCount());

    long activeStudents =
            nz(studentService.getActiveStudentsCount());

    long inactiveStudents =
            totalStudents > activeStudents
            ? totalStudents - activeStudents
            : 0L;

    long firstYear =
            nz(studentService.getStudentsCountByYear("1st year"));

    long secondYear =
            nz(studentService.getStudentsCountByYear("2nd year"));

    long thirdYear =
            nz(studentService.getStudentsCountByYear("3rd year"));

    long fourthYear =
            nz(studentService.getStudentsCountByYear("4th year"));

    long totalBills =
            nz(billService.getTotalBillsCount());

    long pendingBills =
            nz(billService.getPendingBillsCount());

    long paidBills =
            nz(billService.getPaidBillsCount());

    long overdueBills =
            nz(billService.getOverdueBillsCount());

    long totalPayments =
            nz(paymentService.getTotalPaymentsCount());

    long paymentsThisMonth =
            nz(paymentService.getPaymentsThisMonthCount());

    double totalBillAmount =
            ndz(billService.getTotalBillAmount());

    double totalLateFee =
            ndz(billService.getTotalLateFeeAmount());

    double totalPayableAmount =
            totalBillAmount + totalLateFee;

    long totalBreakfast =
            nz(attendanceService.getTotalMealCount("Breakfast"));

    long totalLunch =
            nz(attendanceService.getTotalMealCount("Lunch"));

    long totalDinner =
            nz(attendanceService.getTotalMealCount("Dinner"));

    long monthBills = 0L;
    long monthPaidBills = 0L;
    long monthPendingBills = 0L;

    double monthTotalAmount = 0.0;
    double monthLateFee = 0.0;

    long monthBreakfast = 0L;
    long monthLunch = 0L;
    long monthDinner = 0L;

    if(selectedMonthNumber > 0) {

        monthBills =
                nz(billService.getBillsCountByMonthAndYear(
                        selectedMonth,
                        selectedYear));

        monthPaidBills =
                nz(billService.getPaidBillsCountByMonthAndYear(
                        selectedMonth,
                        selectedYear));

        monthPendingBills =
                nz(billService.getPendingBillsCountByMonthAndYear(
                        selectedMonth,
                        selectedYear));

        monthTotalAmount =
                ndz(billService.getTotalAmountByMonthAndYear(
                        selectedMonth,
                        selectedYear));

        monthLateFee =
                ndz(billService.getLateFeeByMonthAndYear(
                        selectedMonth,
                        selectedYear));

        monthBreakfast =
                nz(attendanceService.getMealCountByMonthAndYear(
                        "Breakfast",
                        selectedMonth,
                        selectedYear));

        monthLunch =
                nz(attendanceService.getMealCountByMonthAndYear(
                        "Lunch",
                        selectedMonth,
                        selectedYear));

        monthDinner =
                nz(attendanceService.getMealCountByMonthAndYear(
                        "Dinner",
                        selectedMonth,
                        selectedYear));
    }

    long yearBreakfast =
            nz(attendanceService.getMealCountByYear(
                    "Breakfast",
                    selectedYear));

    long yearLunch =
            nz(attendanceService.getMealCountByYear(
                    "Lunch",
                    selectedYear));

    long yearDinner =
            nz(attendanceService.getMealCountByYear(
                    "Dinner",
                    selectedYear));

    String[] departments = {
            "CSE",
            "ECE",
            "IT",
            "EEE",
            "MECH",
            "AI & DS",
            "CIVIL"
    };
%>
<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Reports Dashboard</title>

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
==========================*/

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
.print-btn,
.logout-btn{

text-decoration:none;

padding:13px 24px;

border-radius:14px;

font-weight:700;

transition:.3s;

border:none;

cursor:pointer;

font-size:15px;

}

.dashboard-btn{

background:white;

color:#2563eb;

}

.dashboard-btn:hover{

transform:translateY(-3px);

}

.print-btn{

background:#10b981;

color:white;

}

.print-btn:hover{

background:#059669;

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
==========================*/

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

font-size:16px;

color:#64748b;

margin-bottom:30px;

}


/*==========================
FILTER CARD
==========================*/

.filter-card{

background:
linear-gradient(
135deg,
#eff6ff,
#dbeafe);

padding:28px;

border-radius:24px;

box-shadow:
0 12px 30px rgba(37,99,235,.10);

margin-bottom:35px;

}

.filter-title{

font-size:28px;

font-weight:700;

color:#2563eb;

margin-bottom:25px;

}

.filter-form{

display:grid;

grid-template-columns:
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

background:white;

font-size:15px;

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

padding:0 32px;

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

.dashboard-grid{

display:grid;

grid-template-columns:repeat(auto-fit,minmax(220px,1fr));

gap:22px;

margin-bottom:40px;

}

.stat-card{

background:

linear-gradient(
135deg,
#ffffff,
#eff6ff);

border-radius:22px;

padding:25px;

text-align:center;

box-shadow:0 12px 30px rgba(37,99,235,.10);

transition:.3s;

border:2px solid #e0ecff;

}

.stat-card:hover{

transform:translateY(-5px);

box-shadow:0 18px 35px rgba(37,99,235,.18);

}

.stat-card h1{

font-size:34px;

font-weight:800;

color:#2563eb;

margin-bottom:10px;

}

.stat-card p{

font-size:16px;

font-weight:600;

color:#475569;

}

.money{

color:#16a34a !important;

}

.warning{

color:#dc2626 !important;

}

.report-card{

background:white;

padding:30px;

border-radius:24px;

box-shadow:0 15px 35px rgba(0,0,0,.08);

margin-bottom:35px;

}

.report-title{

font-size:30px;

font-weight:700;

color:#2563eb;

margin-bottom:20px;

}

.report-table{

width:100%;

border-collapse:collapse;

overflow:hidden;

border-radius:18px;

}

.report-table thead{

background:
linear-gradient(
135deg,
#1e3a8a,
#2563eb);

color:white;

}

.report-table th{

padding:18px;

font-size:15px;

font-weight:700;

}

.report-table td{

padding:16px;

text-align:center;

border-bottom:1px solid #e5e7eb;

font-size:15px;

}

.report-table tbody tr:nth-child(even){

background:#f8fbff;

}

.report-table tbody tr:hover{

background:#dbeafe;

transition:.3s;

}

.amount{

font-weight:700;

color:#16a34a;

}

.count{

font-weight:700;

color:#2563eb;

}

/*==========================
RESPONSIVE
==========================*/

@media(max-width:1200px){

.dashboard-grid{

grid-template-columns:repeat(2,1fr);

}

.filter-form{

grid-template-columns:1fr 1fr;

}

.search-btn{

grid-column:span 2;

}

.report-table{

min-width:900px;

}

.report-card{

overflow-x:auto;

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

.filter-form{

grid-template-columns:1fr;

}

.search-btn{

grid-column:auto;

width:100%;

}

.dashboard-grid{

grid-template-columns:1fr;

}

.report-title{

font-size:24px;

}

.dashboard-btn,
.print-btn,
.logout-btn{

width:100%;

text-align:center;

}

}

@media(max-width:480px){

.page-title{

font-size:26px;

}

.filter-title{

font-size:22px;

}

.stat-card h1{

font-size:28px;

}

.stat-card p{

font-size:14px;

}

.report-table th,
.report-table td{

padding:12px;

font-size:13px;

}

}


/*==========================
PRINT
==========================*/

@media print{

body{

background:white;

padding:0;

}

.topbar{

display:none;

}

.filter-card{

display:none;

}

.container{

padding:0;

max-width:100%;

background:white;

box-shadow:none;

}

.stat-card{

break-inside:avoid;

}

.report-card{

box-shadow:none;

margin-bottom:20px;

break-inside:avoid;

}

.page-title{

-webkit-text-fill-color:#000;

color:#000;

}

.subtitle{

display:none;

}

}

/*==========================
SMOOTH SCROLL
==========================*/

html{

scroll-behavior:smooth;

}


/*==========================
CUSTOM SCROLLBAR
==========================*/

::-webkit-scrollbar{

width:10px;

height:10px;

}

::-webkit-scrollbar-track{

background:#dbeafe;

border-radius:20px;

}

::-webkit-scrollbar-thumb{

background:#2563eb;

border-radius:20px;

}

::-webkit-scrollbar-thumb:hover{

background:#1d4ed8;

}


/*==========================
SECTION ANIMATION
==========================*/

.report-card,
.stat-card,
.filter-card{

animation:fadeUp .6s ease;

}

@keyframes fadeUp{

from{

opacity:0;

transform:translateY(20px);

}

to{

opacity:1;

transform:translateY(0);

}

}


/*==========================
TABLE ROW ANIMATION
==========================*/

.report-table tbody tr{

transition:.25s;

}

.report-table tbody tr:hover{

transform:scale(1.005);

}


/*==========================
CARD NUMBER EFFECT
==========================*/

.stat-card h1{

letter-spacing:1px;

}


/*==========================
SECTION DIVIDER
==========================*/

.report-title{

display:flex;

align-items:center;

gap:10px;

padding-bottom:12px;

border-bottom:3px solid #dbeafe;

}


/*==========================
PRINT BUTTON EFFECT
==========================*/

.print-btn:active,
.search-btn:active,
.dashboard-btn:active,
.logout-btn:active{

transform:scale(.96);

}


/*==========================
PRINT HEADER
==========================*/

@media print{

body::before{

content:"Visionary Institute of Technology - Mess Billing Management System";

display:block;

font-size:24px;

font-weight:700;

text-align:center;

margin-bottom:20px;

}

.report-card{

border:1px solid #ddd;

}

.report-table th{

background:#2563eb !important;

color:white !important;

-webkit-print-color-adjust:exact;

print-color-adjust:exact;

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

<button
type="button"
class="print-btn"
onclick="window.print()">

🖨 Print Report

</button>

<a
href="logout"
class="logout-btn">

Logout

</a>

</div>

</div>

<div class="container">

<h1 class="page-title">

Reports Dashboard

</h1>

<p class="subtitle">

Comprehensive reports for students, bills, payments and attendance.

</p>

<div class="filter-card">

<h2 class="filter-title">

📊 Report Filters

</h2>

<form
method="get"
action="reports.jsp"
class="filter-form">

<div class="form-group">

<label>Select Month</label>

<select name="month">

<option value="">Select Month</option>

<option value="January" <%= "January".equalsIgnoreCase(selectedMonth)?"selected":"" %>>January</option>
<option value="February" <%= "February".equalsIgnoreCase(selectedMonth)?"selected":"" %>>February</option>
<option value="March" <%= "March".equalsIgnoreCase(selectedMonth)?"selected":"" %>>March</option>
<option value="April" <%= "April".equalsIgnoreCase(selectedMonth)?"selected":"" %>>April</option>
<option value="May" <%= "May".equalsIgnoreCase(selectedMonth)?"selected":"" %>>May</option>
<option value="June" <%= "June".equalsIgnoreCase(selectedMonth)?"selected":"" %>>June</option>
<option value="July" <%= "July".equalsIgnoreCase(selectedMonth)?"selected":"" %>>July</option>
<option value="August" <%= "August".equalsIgnoreCase(selectedMonth)?"selected":"" %>>August</option>
<option value="September" <%= "September".equalsIgnoreCase(selectedMonth)?"selected":"" %>>September</option>
<option value="October" <%= "October".equalsIgnoreCase(selectedMonth)?"selected":"" %>>October</option>
<option value="November" <%= "November".equalsIgnoreCase(selectedMonth)?"selected":"" %>>November</option>
<option value="December" <%= "December".equalsIgnoreCase(selectedMonth)?"selected":"" %>>December</option>

</select>

</div>


<div class="form-group">

<label>Select Year</label>

<input
type="number"
name="year"
value="<%= selectedYear %>">

</div>


<div>

<button
type="submit"
class="search-btn">

🔍 Generate Report

</button>

</div>

</form>

</div>

<div class="dashboard-grid">

<div class="stat-card">

<h1><%= totalStudents %></h1>

<p>👨‍🎓 Total Students</p>

</div>

<div class="stat-card">

<h1><%= activeStudents %></h1>

<p>✅ Active Students</p>

</div>

<div class="stat-card">

<h1 class="warning"><%= inactiveStudents %></h1>

<p>🚫 Inactive Students</p>

</div>

<div class="stat-card">

<h1><%= firstYear %></h1>

<p>1️⃣ First Year</p>

</div>

<div class="stat-card">

<h1><%= secondYear %></h1>

<p>2️⃣ Second Year</p>

</div>

<div class="stat-card">

<h1><%= thirdYear %></h1>

<p>3️⃣ Third Year</p>

</div>

<div class="stat-card">

<h1><%= fourthYear %></h1>

<p>4️⃣ Fourth Year</p>

</div>

<div class="stat-card">

<h1><%= totalBills %></h1>

<p>🧾 Total Bills</p>

</div>

<div class="stat-card">

<h1 class="warning"><%= pendingBills %></h1>

<p>⏳ Pending Bills</p>

</div>

<div class="stat-card">

<h1><%= paidBills %></h1>

<p>💳 Paid Bills</p>

</div>

<div class="stat-card">

<h1 class="warning"><%= overdueBills %></h1>

<p>⚠ Overdue Bills</p>

</div>

<div class="stat-card">

<h1 class="money">

₹ <%= String.format("%.2f", totalBillAmount) %>

</h1>

<p>Total Bill Amount</p>

</div>

<div class="stat-card">

<h1 class="money">

₹ <%= String.format("%.2f", totalLateFee) %>

</h1>

<p>Total Late Fee</p>

</div>

<div class="stat-card">

<h1 class="money">

₹ <%= String.format("%.2f", totalPayableAmount) %>

</h1>

<p>Total Payable</p>

</div>

<div class="stat-card">

<h1><%= totalPayments %></h1>

<p>💰 Total Payments</p>

</div>

<div class="stat-card">

<h1><%= paymentsThisMonth %></h1>

<p>📅 Payments This Month</p>

</div>

<div class="stat-card">

<h1><%= totalBreakfast %></h1>

<p>🍞 Total Breakfast</p>

</div>

<div class="stat-card">

<h1><%= totalLunch %></h1>

<p>🍛 Total Lunch</p>

</div>

<div class="stat-card">

<h1><%= totalDinner %></h1>

<p>🍽 Total Dinner</p>

</div>

<div class="report-card">

<h2 class="report-title">

🧾 Bill Summary

</h2>

<table class="report-table">

<thead>

<tr>

<th>Metric</th>

<th>Count / Amount</th>

</tr>

</thead>

<tbody>

<tr>

<td>Total Bills Generated</td>

<td class="count"><%= totalBills %></td>

</tr>

<tr>

<td>Pending Bills</td>

<td class="count"><%= pendingBills %></td>

</tr>

<tr>

<td>Paid Bills</td>

<td class="count"><%= paidBills %></td>

</tr>

<tr>

<td>Overdue Bills</td>

<td class="count"><%= overdueBills %></td>

</tr>

<tr>

<td>Total Bill Amount</td>

<td class="amount">

₹ <%= String.format("%.2f", totalBillAmount) %>

</td>

</tr>

<tr>

<td>Total Late Fee</td>

<td class="amount">

₹ <%= String.format("%.2f", totalLateFee) %>

</td>

</tr>

<tr>

<td>Total Payable Amount</td>

<td class="amount">

₹ <%= String.format("%.2f", totalPayableAmount) %>

</td>

</tr>

</tbody>

</table>

</div>



<div class="report-card">

<h2 class="report-title">

💳 Payment Summary

</h2>

<table class="report-table">

<thead>

<tr>

<th>Metric</th>

<th>Count</th>

</tr>

</thead>

<tbody>

<tr>

<td>Total Payments</td>

<td class="count">

<%= totalPayments %>

</td>

</tr>

<tr>

<td>Payments This Month</td>

<td class="count">

<%= paymentsThisMonth %>

</td>

</tr>

<tr>

<td>Pending Payments</td>

<td class="count">

<%= pendingBills %>

</td>

</tr>

</tbody>

</table>

</div>


</h2>

<table class="report-table">

<thead>

<tr>

<th>Metric</th>

<th>Count</th>

</tr>

</thead>

<tbody>

<tr>

<td>Total Students</td>

<td class="count"><%= totalStudents %></td>

</tr>

<tr>

<td>Active Students</td>

<td class="count"><%= activeStudents %></td>

</tr>

<tr>

<td>Inactive Students</td>

<td class="count"><%= inactiveStudents %></td>

</tr>

<tr>

<td>1st Year Students</td>

<td class="count"><%= firstYear %></td>

</tr>

<tr>

<td>2nd Year Students</td>

<td class="count"><%= secondYear %></td>

</tr>

<tr>

<td>3rd Year Students</td>

<td class="count"><%= thirdYear %></td>

</tr>

<tr>

<td>4th Year Students</td>

<td class="count"><%= fourthYear %></td>

</tr>

</tbody>

</table>

</div>



<div class="report-card">

<h2 class="report-title">

🍽 Overall Meal Summary

</h2>

<p class="subtitle">

Meal counts calculated from attendance records.

</p>

<table class="report-table">

<thead>

<tr>

<th>Meal</th>

<th>Total Count</th>

</tr>

</thead>

<tbody>

<tr>

<td>Breakfast</td>

<td class="count"><%= totalBreakfast %></td>

</tr>

<tr>

<td>Lunch</td>

<td class="count"><%= totalLunch %></td>

</tr>

<tr>

<td>Dinner</td>

<td class="count"><%= totalDinner %></td>

</tr>

</tbody>

</table>

</div>



<div class="report-card">

<h2 class="report-title">

📅 Bill Report -

<%= selectedMonth %> <%= selectedYear %>

</h2>

<table class="report-table">

<thead>

<tr>

<th>Metric</th>

<th>Count / Amount</th>

</tr>

</thead>

<tbody>

<tr>

<td>Bills Generated</td>

<td class="count">

<%= monthBills %>

</td>

</tr>

<tr>

<td>Paid Bills</td>

<td class="count">

<%= monthPaidBills %>

</td>

</tr>

<tr>

<td>Pending Bills</td>

<td class="count">

<%= monthPendingBills %>

</td>

</tr>

<tr>

<td>Total Bill Amount</td>

<td class="amount">

₹ <%= String.format("%.2f", monthTotalAmount) %>

</td>

</tr>

<tr>

<td>Total Late Fee</td>

<td class="amount">

₹ <%= String.format("%.2f", monthLateFee) %>

</td>

</tr>

<tr>

<td>Total Payable Amount</td>

<td class="amount">

₹ <%= String.format("%.2f", monthTotalAmount + monthLateFee) %>

</td>

</tr>

</tbody>

</table>

</div>



<div class="report-card">

<h2 class="report-title">

🍛 Meal Report -

<%= selectedMonth %> <%= selectedYear %>

</h2>

<table class="report-table">

<thead>

<tr>

<th>Meal</th>

<th>Total Count</th>

</tr>

</thead>

<tbody>

<tr>

<td>Breakfast</td>

<td class="count">

<%= monthBreakfast %>

</td>

</tr>

<tr>

<td>Lunch</td>

<td class="count">

<%= monthLunch %>

</td>

</tr>

<tr>

<td>Dinner</td>

<td class="count">

<%= monthDinner %>

</td>

</tr>

</tbody>

</table>

</div>



<div class="report-card">

<h2 class="report-title">

📆 Year-wise Meal Report -

<%= selectedYear %>

</h2>

<table class="report-table">

<thead>

<tr>

<th>Meal</th>

<th>Total Count</th>

</tr>

</thead>

<tbody>

<tr>

<td>Breakfast</td>

<td class="count">

<%= yearBreakfast %>

</td>

</tr>

<tr>

<td>Lunch</td>

<td class="count">

<%= yearLunch %>

</td>

</tr>

<tr>

<td>Dinner</td>

<td class="count">

<%= yearDinner %>

</td>

</tr>

</tbody>

</table>

</div>
<div class="report-card">

<h2 class="report-title">

👨‍🎓 Student Summary

</h2>

<table class="report-table">

<thead>

<tr>

<th>Metric</th>

<th>Count</th>

</tr>

</thead>

<tbody>

<tr>

<td>Total Students</td>

<td class="count"><%= totalStudents %></td>

</tr>

<tr>

<td>Active Students</td>

<td class="count"><%= activeStudents %></td>

</tr>

<tr>

<td>Inactive Students</td>

<td class="count"><%= inactiveStudents %></td>

</tr>

<tr>

<td>1st Year Students</td>

<td class="count"><%= firstYear %></td>

</tr>

<tr>

<td>2nd Year Students</td>

<td class="count"><%= secondYear %></td>

</tr>

<tr>

<td>3rd Year Students</td>

<td class="count"><%= thirdYear %></td>

</tr>

<tr>

<td>4th Year Students</td>

<td class="count"><%= fourthYear %></td>

</tr>

</tbody>

</table>

</div>



<div class="report-card">

<h2 class="report-title">

🍽 Overall Meal Summary

</h2>

<p class="subtitle">

Meal counts calculated from attendance records.

</p>

<table class="report-table">

<thead>

<tr>

<th>Meal</th>

<th>Total Count</th>

</tr>

</thead>

<tbody>

<tr>

<td>Breakfast</td>

<td class="count"><%= totalBreakfast %></td>

</tr>

<tr>

<td>Lunch</td>

<td class="count"><%= totalLunch %></td>

</tr>

<tr>

<td>Dinner</td>

<td class="count"><%= totalDinner %></td>

</tr>

</tbody>

</table>

</div>



<div class="report-card">

<h2 class="report-title">

📅 Bill Report -

<%= selectedMonth %> <%= selectedYear %>

</h2>

<table class="report-table">

<thead>

<tr>

<th>Metric</th>

<th>Count / Amount</th>

</tr>

</thead>

<tbody>

<tr>

<td>Bills Generated</td>

<td class="count">

<%= monthBills %>

</td>

</tr>

<tr>

<td>Paid Bills</td>

<td class="count">

<%= monthPaidBills %>

</td>

</tr>

<tr>

<td>Pending Bills</td>

<td class="count">

<%= monthPendingBills %>

</td>

</tr>

<tr>

<td>Total Bill Amount</td>

<td class="amount">

₹ <%= String.format("%.2f", monthTotalAmount) %>

</td>

</tr>

<tr>

<td>Total Late Fee</td>

<td class="amount">

₹ <%= String.format("%.2f", monthLateFee) %>

</td>

</tr>

<tr>

<td>Total Payable Amount</td>

<td class="amount">

₹ <%= String.format("%.2f", monthTotalAmount + monthLateFee) %>

</td>

</tr>

</tbody>

</table>

</div>



<div class="report-card">

<h2 class="report-title">

🍛 Meal Report -

<%= selectedMonth %> <%= selectedYear %>

</h2>

<table class="report-table">

<thead>

<tr>

<th>Meal</th>

<th>Total Count</th>

</tr>

</thead>

<tbody>

<tr>

<td>Breakfast</td>

<td class="count">

<%= monthBreakfast %>

</td>

</tr>

<tr>

<td>Lunch</td>

<td class="count">

<%= monthLunch %>

</td>

</tr>

<tr>

<td>Dinner</td>

<td class="count">

<%= monthDinner %>

</td>

</tr>

</tbody>

</table>

</div>



<div class="report-card">

<h2 class="report-title">

📆 Year-wise Meal Report -

<%= selectedYear %>

</h2>

<table class="report-table">

<thead>

<tr>

<th>Meal</th>

<th>Total Count</th>

</tr>

</thead>

<tbody>

<tr>

<td>Breakfast</td>

<td class="count">

<%= yearBreakfast %>

</td>

</tr>

<tr>

<td>Lunch</td>

<td class="count">

<%= yearLunch %>

</td>

</tr>

<tr>

<td>Dinner</td>

<td class="count">

<%= yearDinner %>

</td>

</tr>

</tbody>

</table>

</div>

<div class="report-card">

<h2 class="report-title">

🏢 Department-wise Report

</h2>

<table class="report-table">

<thead>

<tr>

<th>Department</th>

<th>Students</th>

<th>Total Bills</th>

<th>Paid Bills</th>

<th>Pending Bills</th>

</tr>

</thead>

<tbody>

<%

for(String dept : departments){

long deptStudents =
nz(studentService.getStudentsCountByDepartment(dept));

long deptBills =
nz(billService.getBillsCountByDepartment(dept));

long deptPaidBills =
nz(billService.getPaidBillsCountByDepartment(dept));

long deptPendingBills =
nz(billService.getPendingBillsCountByDepartment(dept));

%>

<tr>

<td>

<strong>

<%= dept %>

</strong>

</td>

<td class="count">

<%= deptStudents %>

</td>

<td class="count">

<%= deptBills %>

</td>

<td style="color:#16a34a;font-weight:700;">

<%= deptPaidBills %>

</td>

<td style="color:#dc2626;font-weight:700;">

<%= deptPendingBills %>

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

</div>

</body>

</html>
