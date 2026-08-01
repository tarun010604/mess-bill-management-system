<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.messbill.Entity.Student" %>
<%@ page import="com.messbill.Service.StudentService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String filterYear = request.getParameter("filterYear");
    String filterDepartment = request.getParameter("filterDepartment");
    String filterRollNo = request.getParameter("filterRollNo");
    String filterName = request.getParameter("filterName");
    String filterHostelRoomNo = request.getParameter("filterHostelRoomNo");

    String msg = request.getParameter("msg");

    StudentService studentService = new StudentService();
    List<Student> students;

    boolean searchRequested =
            (filterYear != null && !filterYear.trim().isEmpty()) ||
            (filterDepartment != null && !filterDepartment.trim().isEmpty()) ||
            (filterRollNo != null && !filterRollNo.trim().isEmpty()) ||
            (filterName != null && !filterName.trim().isEmpty()) ||
            (filterHostelRoomNo != null && !filterHostelRoomNo.trim().isEmpty());

    if (searchRequested) {
        students = studentService.searchActiveStudents(
                filterYear,
                filterDepartment,
                filterRollNo,
                filterName,
                filterHostelRoomNo
        );
    } else {
        students = studentService.getActiveStudents();
    }
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Meal Attendance</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{

background:linear-gradient(
135deg,
#dbeafe,
#bfdbfe,
#93c5fd,
#60a5fa);

padding:25px;

}


/*==========================
TOP BAR
===========================*/

.topbar{

background:linear-gradient(
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

border-radius:50%;

background:white;

padding:4px;

object-fit:cover;

}

.topbar-left h2{

color:white;

font-size:20px;

font-weight:700;

}

.topbar-left p{

color:white;

opacity:.9;

font-size:14px;

}

.topbar-right{

display:flex;

gap:15px;

}

.dashboard-btn{

background:white;

color:#2563eb;

padding:13px 24px;

border-radius:14px;

text-decoration:none;

font-weight:700;

transition:.3s;

}

.dashboard-btn:hover{

transform:translateY(-3px);

box-shadow:0 12px 20px rgba(255,255,255,.25);

}

.logout-btn{

background:#ef4444;

color:white;

padding:13px 24px;

border-radius:14px;

text-decoration:none;

font-weight:700;

transition:.3s;

}

.logout-btn:hover{

background:#dc2626;

transform:translateY(-3px);

}



/*==========================
MAIN CONTAINER
===========================*/

.container{

max-width:1600px;

margin:auto;

background:rgba(255,255,255,.95);

backdrop-filter:blur(18px);

border-radius:30px;

padding:35px;

box-shadow:

0 18px 45px rgba(37,99,235,.18);

}

.page-title{

font-size:42px;

font-weight:800;

background:linear-gradient(
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

margin-bottom:35px;

font-size:16px;

}



/*==========================
SUCCESS MESSAGE
===========================*/

.msg{

padding:16px;

background:#dcfce7;

border-left:6px solid #22c55e;

border-radius:12px;

color:#166534;

margin-bottom:20px;

font-weight:600;

}

.error{

padding:16px;

background:#fee2e2;

border-left:6px solid #ef4444;

border-radius:12px;

color:#991b1b;

margin-bottom:20px;

font-weight:600;

}



/*==========================
SEARCH CARD
===========================*/

.search-card{

background:linear-gradient(
135deg,
#eff6ff,
#dbeafe);

padding:30px;

border-radius:25px;

margin-bottom:30px;

box-shadow:
0 12px 30px rgba(37,99,235,.10);

}

.search-title{

font-size:34px;

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

height:54px;

padding:0 18px;

border:2px solid #bfdbfe;

border-radius:14px;

background:white;

font-size:15px;

transition:.3s;

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
0 14px 30px rgba(37,99,235,.30);

}

/*==========================
ATTENDANCE CARD
===========================*/

.attendance-card{

background:white;

border-radius:25px;

padding:30px;

margin-bottom:30px;

box-shadow:
0 12px 30px rgba(0,0,0,.08);

}

.attendance-title{

font-size:30px;

color:#2563eb;

font-weight:700;

margin-bottom:25px;

}

.attendance-grid{

display:grid;

grid-template-columns:repeat(2,1fr);

gap:30px;

}

.field{

display:flex;

flex-direction:column;

}

.field label{

font-size:15px;

font-weight:700;

margin-bottom:10px;

color:#334155;

}

.field input,
.field select{

height:55px;

padding:0 18px;

font-size:15px;

border-radius:14px;

border:2px solid #bfdbfe;

background:white;

}

.field input:focus,
.field select:focus{

outline:none;

border-color:#2563eb;

box-shadow:
0 0 0 5px rgba(37,99,235,.15);

}

.save-area{

margin-top:30px;

text-align:center;

}

.save-btn{
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 10px;

    min-width: 280px;
    height: 58px;
    padding: 0 30px;

    background: linear-gradient(135deg, #2563eb, #1d4ed8);

    color: #fff;
    font-size: 18px;
    font-weight: 600;

    border: none;
    border-radius: 14px;

    cursor: pointer;
    transition: all .3s ease;

    box-shadow: 0 12px 24px rgba(37,99,235,.25);
}

.save-btn:hover{
    transform: translateY(-3px);
    box-shadow: 0 16px 30px rgba(37,99,235,.35);
}

.save-btn:active{
    transform: scale(.98);
}

/*==========================
ATTENDANCE TABLE
===========================*/

.table-card{

background:white;

border-radius:25px;

padding:30px;

margin-top:30px;

box-shadow:0 15px 35px rgba(0,0,0,.08);

overflow:hidden;

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

table thead{

background:linear-gradient(
135deg,
#1e3a8a,
#2563eb);

color:white;

}

table th{

padding:18px;

font-size:15px;

font-weight:600;

text-align:center;

}

table td{

padding:16px;

text-align:center;

border-bottom:1px solid #e5e7eb;

font-size:15px;

}

table tbody tr:nth-child(even){

background:#f8fbff;

}

table tbody tr:hover{

background:#dbeafe;

transition:.3s;

}


/*==========================
STATUS BADGE
===========================*/

.status-active{

background:#dcfce7;

color:#166534;

padding:8px 15px;

border-radius:30px;

font-size:13px;

font-weight:700;

display:inline-block;

}

.status-inactive{

background:#fee2e2;

color:#991b1b;

padding:8px 15px;

border-radius:30px;

font-size:13px;

font-weight:700;

display:inline-block;

}


/*==========================
CUSTOM CHECKBOX
===========================*/

.checkbox-wrapper{

display:flex;

justify-content:center;

align-items:center;

}

.checkbox-wrapper input{

width:22px;

height:22px;

cursor:pointer;

accent-color:#2563eb;

transform:scale(1.2);

}


/*==========================
SAVE BUTTON
===========================*/

.save-area{

text-align:center;

margin-top:35px;

}

.save-btn{

background:linear-gradient(
135deg,
#2563eb,
#1d4ed8);

color:white;

font-size:18px;

font-weight:700;

padding:15px 60px;

border:none;

border-radius:15px;

cursor:pointer;

transition:.3s;

box-shadow:0 15px 30px rgba(37,99,235,.30);

}

.save-btn:hover{

transform:translateY(-4px);

box-shadow:0 20px 40px rgba(37,99,235,.35);

}

/*==========================
RESPONSIVE DESIGN
===========================*/

@media(max-width:1200px){

.search-form{

grid-template-columns:repeat(2,1fr);

}

.attendance-grid{

grid-template-columns:1fr;

}

}

@media(max-width:768px){

body{

padding:12px;

}

.topbar{

flex-direction:column;

align-items:flex-start;

gap:20px;

}

.topbar-right{

width:100%;

justify-content:space-between;

}

.search-form{

grid-template-columns:1fr;

}

.page-title{

font-size:30px;

}

.search-title,
.attendance-title,
.table-title{

font-size:24px;

}

.container{

padding:20px;

}

.dashboard-btn,
.logout-btn{

padding:10px 18px;

font-size:14px;

}

.save-btn{

width:100%;

}

table{

min-width:850px;

}

}

@media(max-width:500px){

.logo{

width:55px;

height:55px;

}

.topbar-left h2{

font-size:16px;

}

.topbar-left p{

font-size:12px;

}

.page-title{

font-size:26px;

}

.subtitle{

font-size:14px;

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

<a href="dashboard.jsp"
class="dashboard-btn">
Dashboard
</a>

<a href="logout"
class="logout-btn">
Logout
</a>

</div>

</div>

<div class="container">

<h1 class="page-title">
Meal Attendance
</h1>

<p class="subtitle">
Mark Daily Student Meal Attendance
</p>

<% if (msg != null && !msg.trim().isEmpty()) { %>

<div class="<%= msg.toLowerCase().contains("success") ? "msg" : "error" %>">

<%= msg %>

</div>

<% } %>

<div class="search-card">

<h2 class="search-title">

🔍 Search Student

</h2>

<form class="search-form" method="get" action="attendance.jsp">

    <div class="search-group">
        <label>Year</label>
        <select name="filterYear">
            <option value="">All Years</option>
            <option value="1st Year" <%= "1st Year".equals(filterYear)?"selected":"" %>>1st Year</option>
            <option value="2nd Year" <%= "2nd Year".equals(filterYear)?"selected":"" %>>2nd Year</option>
            <option value="3rd Year" <%= "3rd Year".equals(filterYear)?"selected":"" %>>3rd Year</option>
            <option value="4th Year" <%= "4th Year".equals(filterYear)?"selected":"" %>>4th Year</option>
        </select>
    </div>

    <div class="search-group">
        <label>Department</label>
        <select name="filterDepartment">
            <option value="">All Departments</option>
            <option value="CSE" <%= "CSE".equals(filterDepartment)?"selected":"" %>>CSE</option>
            <option value="IT" <%= "IT".equals(filterDepartment)?"selected":"" %>>IT</option>
            <option value="ECE" <%= "ECE".equals(filterDepartment)?"selected":"" %>>ECE</option>
            <option value="EEE" <%= "EEE".equals(filterDepartment)?"selected":"" %>>EEE</option>
            <option value="MECH" <%= "MECH".equals(filterDepartment)?"selected":"" %>>MECH</option>
            <option value="AI & DS" <%= "AI & DS".equals(filterDepartment)?"selected":"" %>>AI & DS</option>
            <option value="CIVIL" <%= "CIVIL".equals(filterDepartment)?"selected":"" %>>CIVIL</option>
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
<form action="saveAttendance" method="post">

<div class="attendance-card">

<h2 class="attendance-title">

📅 Attendance Information

</h2>

<div class="attendance-grid">

<div class="field">

<label>Attendance Date</label>

<input
type="date"
name="date"
value="<%=LocalDate.now()%>"
required>

</div>

<div class="field">

<label>Meal Type</label>

<select name="mealType" required>

<option value="">Select Meal</option>

<option value="Breakfast">
Breakfast
</option>

<option value="Lunch">
Lunch
</option>

<option value="Dinner">
Dinner
</option>

</select>

</div>

</div>

<div class="table-card">

<h2 class="table-title">

📋 Student Attendance

</h2>

<div class="table-responsive">

<table>

<thead>

<tr>

<th>S.No</th>

<th>Roll No</th>

<th>Student Name</th>

<th>Department</th>

<th>Year</th>

<th>Room</th>

<th>Status</th>

<th>Present</th>

</tr>

</thead>

<tbody>

<%
int sno = 1;

if(students != null && !students.isEmpty()){

for(Student s : students){
%>

<tr>

<td><%= sno++ %></td>

<td><%= s.getRollNo() %></td>

<td><%= s.getName() %></td>

<td><%= s.getDepartment() %></td>

<td><%= s.getYear() %></td>

<td><%= s.getHostelRoomNo() %></td>

<td>

<%
if("Active".equalsIgnoreCase(s.getStatus())){
%>

<span class="status-active">Active</span>

<%
}else{
%>

<span class="status-inactive">Inactive</span>

<%
}
%>

</td>

<td>

<div class="checkbox-wrapper">

<input
type="hidden"
name="studentId"
value="<%= s.getStudentId() %>">

<input
type="checkbox"
name="present_<%= s.getStudentId() %>"
value="true">

</div>

</td>

</tr>

<%
}

}else{
%>

<tr>

<td colspan="8">

No active students found

</td>

</tr>

<%
}
%>

</tbody>
</table>

</div>

<div class="save-area">

<button
class="save-btn"
type="submit">

💾 Save Attendance

</button>

</div>

</div>
</form>

</div>

</body>

</html>

