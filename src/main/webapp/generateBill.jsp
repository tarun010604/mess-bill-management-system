<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.messbill.Entity.Student" %>
<%@ page import="com.messbill.Service.StudentService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String msg = (String) request.getAttribute("msg");
    if (msg == null) {
        msg = request.getParameter("msg");
    }

    String filterYear = request.getParameter("filterYear");
    String filterDepartment = request.getParameter("filterDepartment");
    String filterRollNo = request.getParameter("filterRollNo");
    String filterName = request.getParameter("filterName");
    String filterHostelRoomNo = request.getParameter("filterHostelRoomNo");

    boolean searchRequested =
            (filterYear != null && !filterYear.trim().isEmpty()) ||
            (filterDepartment != null && !filterDepartment.trim().isEmpty()) ||
            (filterRollNo != null && !filterRollNo.trim().isEmpty()) ||
            (filterName != null && !filterName.trim().isEmpty()) ||
            (filterHostelRoomNo != null && !filterHostelRoomNo.trim().isEmpty());

    StudentService studentService = new StudentService();
    List<Student> students = Collections.emptyList();

    if (searchRequested) {
        students = studentService.searchActiveStudents(
                filterYear, filterDepartment, filterRollNo, filterName, filterHostelRoomNo);
    } else {
        students = studentService.getActiveStudents();
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Generate Bill</title>

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


/*==============================
TOPBAR
===============================*/

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


/*==============================
MAIN CONTAINER
===============================*/

.container{

max-width:1600px;

margin:auto;

background:rgba(255,255,255,.96);

backdrop-filter:blur(18px);

border-radius:30px;

padding:35px;

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

margin-bottom:10px;

}

.subtitle{

color:#64748b;

font-size:16px;

margin-bottom:35px;

}

.msg{

padding:15px;

background:#dcfce7;

border-left:6px solid #16a34a;

border-radius:12px;

margin-bottom:25px;

font-weight:600;

color:#166534;

}

.error{

padding:15px;

background:#fee2e2;

border-left:6px solid #ef4444;

border-radius:12px;

margin-bottom:25px;

font-weight:600;

color:#991b1b;

}


/*==============================
SEARCH CARD
===============================*/

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

font-size:32px;

font-weight:700;

color:#2563eb;

margin-bottom:30px;

}

.search-form{

display:grid;

grid-template-columns:
repeat(5,minmax(180px,1fr));

gap:22px;

align-items:end;

}

.search-group{

display:flex;

flex-direction:column;

}

.search-group label{

font-weight:600;

margin-bottom:8px;

color:#334155;

}

.search-group input,
.search-group select{

height:55px;

padding:0 18px;

border-radius:14px;

border:2px solid #bfdbfe;

font-size:15px;

transition:.3s;

background:white;

}

.search-group input:focus,
.search-group select:focus{

outline:none;

border-color:#2563eb;

box-shadow:
0 0 0 5px rgba(37,99,235,.15);

}

.search-btn{

 width:260px;
    height:52px;
    border:none;
    border-radius:14px;
    background:linear-gradient(135deg,#2563eb,#1d4ed8);
    color:#fff;
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

margin-bottom:35px;

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

border-collapse:collapse;

min-width:1100px;

}

thead{

background:linear-gradient(
135deg,
#1e3a8a,
#2563eb);

color:white;

}

th{

padding:18px;

font-size:15px;

font-weight:600;

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

.radio{

width:22px;

height:22px;

accent-color:#2563eb;

cursor:pointer;

}

.status-active{

background:#dcfce7;

color:#166534;

padding:7px 15px;

border-radius:30px;

font-size:13px;

font-weight:700;

display:inline-block;

}

.status-inactive{

background:#fee2e2;

color:#991b1b;

padding:7px 15px;

border-radius:30px;

font-size:13px;

font-weight:700;

display:inline-block;

}


.bill-card{

background:linear-gradient(135deg,#f8fbff,#eff6ff);

padding:35px;

border-radius:25px;

box-shadow:0 15px 35px rgba(0,0,0,.08);

}

.bill-title{

font-size:30px;

font-weight:700;

color:#2563eb;

margin-bottom:30px;

}

.bill-form{

display:grid;

grid-template-columns:repeat(2,minmax(250px,1fr));

gap:25px;

}

.form-group{

display:flex;

flex-direction:column;

}

.form-group label{

font-weight:600;

margin-bottom:10px;

color:#334155;

}

.form-group input,

.form-group select{

height:55px;

padding:0 18px;

border-radius:14px;

border:2px solid #bfdbfe;

font-size:15px;

background:#fff;

transition:.3s;

}

.form-group input:focus,

.form-group select:focus{

outline:none;

border-color:#2563eb;

box-shadow:0 0 0 5px rgba(37,99,235,.15);

}

.selected-card{

grid-column:1/-1;

background:#ffffff;

border-left:6px solid #2563eb;

padding:20px;

border-radius:16px;

font-size:17px;

font-weight:600;

color:#1e293b;

}

.selected-card span{

color:#2563eb;

font-weight:700;

}

.info-card{

grid-column:1/-1;

background:#dbeafe;

border-radius:15px;

padding:18px;

color:#1e3a8a;

font-size:15px;

line-height:1.8;

}

.action-area{

grid-column:1/-1;

display:flex;

justify-content:center;

margin-top:15px;

}

.generate-btn{

display:inline-flex;

align-items:center;

justify-content:center;

gap:10px;

padding:16px 40px;

min-width:280px;

height:60px;

border:none;

border-radius:15px;

background:linear-gradient(135deg,#16a34a,#15803d);

color:#fff;

font-size:18px;

font-weight:700;

cursor:pointer;

transition:.3s;

box-shadow:0 15px 30px rgba(22,163,74,.25);

}

.generate-btn:hover{

transform:translateY(-3px);

box-shadow:0 20px 35px rgba(22,163,74,.35);

}

@media(max-width:1200px){

.search-form{

grid-template-columns:repeat(2,1fr);

}

.bill-form{

grid-template-columns:1fr;

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

min-width:900px;

}

.search-btn,

.generate-btn{

width:100%;

min-width:unset;

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

.table-title,

.bill-title{

font-size:24px;

}

.dashboard-btn,

.logout-btn{

width:100%;

text-align:center;

}

}


</style>

<script>

function selectStudent(id,label){

document.getElementById("studentId").value=id;

document.getElementById("selectedStudentText").innerHTML=label;

}

</script>

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

Generate Bill

</h1>

<p class="subtitle">

Generate Monthly Mess Bill for Students

</p>

<% if(msg!=null){ %>

<div class="<%=msg.toLowerCase().contains("success")?"msg":"error"%>">

<%=msg%>

</div>

<% } %>

<div class="search-card">

<h2 class="search-title">

🔍 Search Student

</h2>

<form method="get"

action="generateBill.jsp"

class="search-form">
<div class="search-group">

<label>Year</label>

<select name="filterYear">

<option value="">All Years</option>

<option value="1st Year"
<%= "1st Year".equalsIgnoreCase(filterYear)?"selected":"" %>>

1st Year

</option>

<option value="2nd Year"
<%= "2nd Year".equalsIgnoreCase(filterYear)?"selected":"" %>>

2nd Year

</option>

<option value="3rd Year"
<%= "3rd Year".equalsIgnoreCase(filterYear)?"selected":"" %>>

3rd Year

</option>

<option value="4th Year"
<%= "4th Year".equalsIgnoreCase(filterYear)?"selected":"" %>>

4th Year

</option>

</select>

</div>


<div class="search-group">

<label>Department</label>

<select name="filterDepartment">

<option value="">All Departments</option>

<option value="CSE"
<%= "CSE".equalsIgnoreCase(filterDepartment)?"selected":"" %>>
CSE
</option>

<option value="IT"
<%= "IT".equalsIgnoreCase(filterDepartment)?"selected":"" %>>
IT
</option>

<option value="ECE"
<%= "ECE".equalsIgnoreCase(filterDepartment)?"selected":"" %>>
ECE
</option>

<option value="EEE"
<%= "EEE".equalsIgnoreCase(filterDepartment)?"selected":"" %>>
EEE
</option>

<option value="MECH"
<%= "MECH".equalsIgnoreCase(filterDepartment)?"selected":"" %>>
MECH
</option>

<option value="AI & DS"
<%= "AI & DS".equalsIgnoreCase(filterDepartment)?"selected":"" %>>
AI & DS
</option>

<option value="CIVIL"
<%= "CIVIL".equalsIgnoreCase(filterDepartment)?"selected":"" %>>
CIVIL
</option>

</select>

</div>


<div class="search-group">

<label>Roll Number</label>

<input
type="text"
name="filterRollNo"
value="<%=filterRollNo==null?"":filterRollNo%>"
placeholder="Enter Roll Number">

</div>


<div class="search-group">

<label>Student Name</label>

<input
type="text"
name="filterName"
value="<%=filterName==null?"":filterName%>"
placeholder="Enter Student Name">

</div>


<div class="search-group">

<label>Hostel Room</label>

<input
type="text"
name="filterHostelRoomNo"
value="<%=filterHostelRoomNo==null?"":filterHostelRoomNo%>"
placeholder="Room Number">

</div>


<div style="grid-column:1/-1;text-align:center;">

<button
class="search-btn"
type="submit">

🔍 Search Student

</button>

</div>

</form>

</div>

<div class="table-card">

<h2 class="table-title">

📋 Search Result

</h2>

<div class="table-responsive">

<table>

<thead>

<tr>

<th>Select</th>

<th>Name</th>

<th>Roll No</th>

<th>Department</th>

<th>Year</th>

<th>Room</th>

<th>Status</th>

</tr>

</thead>

<tbody>

<%

if(students!=null && !students.isEmpty()){

for(Student s:students){

%>

<tr>

<td>

<input
class="radio"
type="radio"
name="pickStudent"

onclick="selectStudent('<%=s.getStudentId()%>',
'<%=s.getName()%> - <%=s.getRollNo()%>')">

</td>

<td><%=s.getName()%></td>

<td><%=s.getRollNo()%></td>

<td><%=s.getDepartment()%></td>

<td><%=s.getYear()%></td>

<td><%=s.getHostelRoomNo()%></td>

<td>

<%

if("Active".equalsIgnoreCase(s.getStatus())){

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

</tr>

<%

}

}else{

%>

<tr>

<td colspan="7">

No Active Students Found

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

</div>

<form action="generateBill" method="post">

<input
type="hidden"
name="studentId"
id="studentId">

<div class="bill-card">

<h2 class="bill-title">

💳 Generate Monthly Bill

</h2>

<div class="bill-form">

<div class="selected-card">

Selected Student :

<span id="selectedStudentText">

Please select a student from the table above

</span>

</div>

<div class="form-group">

<label>Billing Month</label>

<select name="month" required>

<option value="">Select Month</option>

<option value="January">January</option>

<option value="February">February</option>

<option value="March">March</option>

<option value="April">April</option>

<option value="May">May</option>

<option value="June">June</option>

<option value="July">July</option>

<option value="August">August</option>

<option value="September">September</option>

<option value="October">October</option>

<option value="November">November</option>

<option value="December">December</option>

</select>

</div>

<div class="form-group">

<label>Billing Year</label>

<input
type="number"
name="billYear"
required
value="<%=java.time.Year.now().getValue()%>">

</div>

<div class="info-card">

<strong>Note:</strong><br>

• A bill will be generated only for the selected student.<br>

• Existing attendance records will be used for calculation.<br>

• If a bill already exists for the selected month and year, it may be updated depending on your servlet logic.<br>

• Verify the selected student before generating the bill.


<p style="margin-top:12px;">
    Due date will be generated automatically as the
    <b>5<sup>th</sup> of the next month</b>.
</p>

</div>

<div class="action-area">

<button
type="submit"
class="generate-btn">

💳 Generate Bill

</button>

</div>

</div>

</div>

</form>
</div>

</body>

</html>
