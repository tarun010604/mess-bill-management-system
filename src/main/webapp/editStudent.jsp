<%@ page import="com.messbill.Entity.Student" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    Student student = (Student) request.getAttribute("student");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Edit Student Details</title>

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

max-width:850px;

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

color:#64748b;

font-size:16px;

margin-bottom:35px;

}


/*=========================
FORM CARD
=========================*/

.form-card{

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

.form-group{

margin-bottom:20px;

}

.form-group label{

display:block;

font-weight:600;

color:#334155;

margin-bottom:8px;

}

.form-group input{

width:100%;

height:55px;

padding:0 18px;

border:2px solid #bfdbfe;

border-radius:14px;

font-size:15px;

transition:.3s;

}

.form-group input:focus{

outline:none;

border-color:#2563eb;

box-shadow:
0 0 0 5px rgba(37,99,235,.15);

}

.readonly{

background:#e2e8f0;

color:#475569;

cursor:not-allowed;

font-weight:600;

}

.update-btn{

width:100%;

height:58px;

border:none;

border-radius:14px;

background:
linear-gradient(
135deg,
#2563eb,
#1d4ed8);

color:white;

font-size:18px;

font-weight:700;

cursor:pointer;

margin-top:15px;

transition:.3s;

}

.update-btn:hover{

transform:translateY(-3px);

box-shadow:
0 15px 30px rgba(37,99,235,.25);

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

padding:22px;

}

.page-title{

font-size:30px;

text-align:center;

}

.subtitle{

text-align:center;

}

}

@media(max-width:480px){

.dashboard-btn,
.logout-btn{

width:100%;

text-align:center;

}

.page-title{

font-size:26px;

}

.form-card{

padding:20px;

}

.update-btn{

font-size:16px;

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

Edit Student

</h1>

<p class="subtitle">

Update the student's contact details.

</p>

<div class="form-card">

<form action="updateStudent" method="post">

<input
type="hidden"
name="studentId"
value="<%= student.getStudentId() %>">

<div class="form-group">

<label>Student Name</label>

<input
type="text"
value="<%= student.getName() %>"
readonly
class="readonly">

</div>


<div class="form-group">

<label>Roll Number</label>

<input
type="text"
value="<%= student.getRollNo() %>"
readonly
class="readonly">

</div>


<div class="form-group">

<label>Department</label>

<input
type="text"
value="<%= student.getDepartment() %>"
readonly
class="readonly">

</div>


<div class="form-group">

<label>Year</label>

<input
type="text"
value="<%= student.getYear() %>"
readonly
class="readonly">

</div>


<div class="form-group">

<label>Email Address</label>

<input
type="email"
name="email"
value="<%= student.getEmail() %>"
required>

</div>


<div class="form-group">

<label>Phone Number</label>

<input
type="text"
name="phone"
value="<%= student.getPhone() %>"
maxlength="10"
required>

</div>


<div class="form-group">

<label>Parent Phone Number</label>

<input
type="text"
name="parentPhone"
value="<%= student.getParentPhone() %>"
maxlength="10"
required>

</div>


<button
type="submit"
class="update-btn">

💾 Update Student Details

</button>

</form>

</div>

</div>


</body>

</html>