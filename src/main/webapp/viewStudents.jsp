<%@ page import="java.util.List" %>
<%@ page import="com.messbill.Entity.Student" %>
<%@ page import="com.messbill.Service.StudentService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   
String year = request.getParameter("year");
String department = request.getParameter("department");
String rollNo = request.getParameter("rollNo");
String name = request.getParameter("name");
String hostelRoomNo = request.getParameter("hostelRoomNo");

StudentService studentService = new StudentService();
List<Student> students = studentService.searchStudents(
        year, department, rollNo, name, hostelRoomNo);

    String msg =
            request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>
View Students
</title>

<style>

body{
    margin:0;
    padding:20px;
    font-family:'Poppins',sans-serif;
    background:linear-gradient(
        135deg,
        #dbeafe,
        #bfdbfe,
        #93c5fd
    );
}

/* TOP BAR */

.topbar{

    background:
    linear-gradient(
    135deg,
    #1e3a8a,
    #2563eb,
    #3b82f6
    );

    display:flex;
    justify-content:space-between;
    align-items:center;

    padding:18px 30px;

   border-radius:0 0 25px 25px;

    margin-bottom:25px;

    box-shadow:
    0 10px 30px rgba(37,99,235,.25);
}

.topbar-left{
    display:flex;
    align-items:center;
    gap:18px;
}

.logo{
    width:70px;
    height:70px;
    border-radius:50%;
    background:white;
    padding:4px;
    object-fit:cover;
}

.topbar-left h2{
    color:white;
    margin:0;
    font-size:20px;
}

.topbar-left p{
    color:white;
    margin:0;
    opacity:.9;
}

.topbar-right{
    display:flex;
    gap:12px;
}

.dashboard-btn{
    background:white;
    color:#2563eb;
    text-decoration:none;
    padding:12px 22px;
    border-radius:12px;
    font-weight:700;
}

.logout-btn{
    background:#ef4444;
    color:white;
    text-decoration:none;
    padding:12px 22px;
    border-radius:12px;
    font-weight:700;
}	

	.container{
	
	    max-width:1500px;
	
	    margin:auto;
	
	    background:
	    rgba(255,255,255,.96);
	
	    backdrop-filter:blur(12px);
	
	    border-radius:25px;
	
	    padding:30px;
	
	    box-shadow:
	    0 20px 40px rgba(37,99,235,.15);
	}
h2{
    margin-top:0;
}
.search-card{

    background:
    linear-gradient(
        135deg,
        #eff6ff,
        #dbeafe
    );

    padding:25px;

    border-radius:20px;

    margin-bottom:25px;
}

.search-card form{

    display:grid;

    grid-template-columns:
    repeat(auto-fit,minmax(200px,1fr));

    gap:15px;
}
input,
select{

    width:100%;

    padding:12px;

    border:2px solid #bfdbfe;

    border-radius:12px;

    background:white;
}

input:focus,
select:focus{

    outline:none;

    border-color:#2563eb;

    box-shadow:
    0 0 12px rgba(37,99,235,.2);
}
button{

    background:
    linear-gradient(
        135deg,
        #2563eb,
        #1d4ed8
    );

    color:white;

    border:none;

    border-radius:12px;

    padding:12px;

    font-weight:700;

    cursor:pointer;
}
table{

    width:100%;

    border-collapse:separate;

    border-spacing:0;

    overflow:hidden;

    border-radius:18px;

    background:white;
}

th{

    background:
    linear-gradient(
        135deg,
        #1e40af,
        #2563eb
    );

    color:white;

    padding:14px;
}

td{

    padding:12px;

    border-bottom:
    1px solid #e5e7eb;
}

tr:hover{

    background:#eff6ff;
}
.active-badge{

    background:#dcfce7;
    color:#166534;

    padding:6px 12px;

    border-radius:20px;

    font-weight:700;
}

.inactive-badge{

    background:#fee2e2;
    color:#991b1b;

    padding:6px 12px;

    border-radius:20px;

    font-weight:700;
   
}

.no-data{
    padding:15px;
    background:#fff3cd;
    color:#856404;
    border:1px solid #ffeeba;
    border-radius:6px;
    margin-top:15px;
}

.msg{
    background:#dcfce7;
    color:#166534;
    padding:12px;
    border-radius:6px;
    margin-bottom:15px;
    font-weight:bold;
}

.activate{
    background:#16a34a;
}

.deactivate{
    background:#dc2626;
}

.edit{
    background:#f59e0b;
}

.action-btn{

    border-radius:10px;

    padding:8px 14px;

    font-size:13px;

    transition:.3s;
    text-decoration: none;
    color:Black;
}

.action-btn:hover{

    transform:translateY(-2px);
}
.not-allowed{
    color:#6b7280;
    font-weight:bold;
}
.search-form{
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:25px 30px;
    align-items:end;
}

.search-group{
    display:flex;
    flex-direction:column;
}

.search-group label{
    margin-bottom:8px;
    font-size:15px;
    font-weight:700;
    color:#1e293b;
}

.search-group input,
.search-group select{
    width:100%;
    height:52px;
    padding:0 15px;
    border:2px solid #c7ddff;
    border-radius:12px;
    font-size:15px;
    background:#fff;
    box-sizing:border-box;
}

.search-btn-area{
    grid-column:1 / 5;
    display:flex;
    justify-content:center;
    margin-top:8px;
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
    box-shadow:0 12px 25px rgba(37,99,235,.30);
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

<h2>
Student List
</h2>

<%
if(msg != null){
%>

<div class="msg">
    <%= msg %>
</div>

<%
}
%>
<div class="search-card">

<h2 class="search-title">
🔍 Search Students
</h2>

<form class="search-form" method="get" action="viewStudents.jsp">

<div class="search-group">
<label>Year</label>

<select name="year">
<option value="">All Years</option>
<option value="1st Year">1st Year</option>
<option value="2nd Year">2nd Year</option>
<option value="3rd Year">3rd Year</option>
<option value="4th Year">4th Year</option>
</select>

</div>

<div class="search-group">

<label>Department</label>

<select name="department">
<option value="">All Departments</option>
<option value="CSE">CSE</option>
<option value="IT">IT</option>
<option value="ECE">ECE</option>
<option value="EEE">EEE</option>
<option value="MECH">MECH</option>
<option value="AI & DS">AI & DS</option>
<option value="CIVIL">CIVIL</option>
</select>

</div>

<div class="search-group">

<label>Roll No</label>

<input type="text"
name="rollNo"
value="<%=rollNo==null?"":rollNo%>"
placeholder="Enter Roll Number">

</div>

<div class="search-group">

<label>Name</label>

<input type="text"
name="name"
value="<%=name==null?"":name%>"
placeholder="Enter Student Name">

</div>

<div class="search-btn-area">

<button class="search-btn" type="submit">
🔎 Search Student
</button>

</div>

</form>

</div>
<%
if(students == null ||
   students.isEmpty()){
%>

<div class="no-data">
    No students found.
</div>

<%
} else {
%>

<table>

<tr>

<th>ID</th>
<th>Name</th>
<th>Roll No</th>
<th>Gender</th>
<th>Email</th>
<th>Phone</th>
<th>Parent Phone</th>
<th>Department</th>
<th>Year</th>
<th>Hostel Room No</th>
<th>Status</th>
<th>Action</th>
<th>Edit</th>

</tr>

<%
for(Student s : students){
%>

<tr>

<td>
<%= s.getStudentId() %>
</td>

<td>
<%= s.getName() %>
</td>

<td>
<%= s.getRollNo() %>
</td>

<td>
<%= s.getGender() %>
</td>

<td>
<%= s.getEmail() %>
</td>

<td>
<%= s.getPhone() %>
</td>

<td>
<%= s.getParentPhone() %>
</td>

<td>
<%= s.getDepartment() %>
</td>

<td>
<%= s.getYear() %>
</td>

<td>
<%= s.getHostelRoomNo() %>
</td>

<td>

<%
if("Active".equalsIgnoreCase(s.getStatus())){
%>

<span class="active-badge">
Active
</span>

<%
}else{
%>

<span class="inactive-badge">
Inactive
</span>

<%
}
%>

</td>

<td>

<%
if("Active".equalsIgnoreCase(
        s.getStatus())){
%>

<a class="action-btn deactivate"
   href="updateStudentStatus?studentId=<%= s.getStudentId() %>&status=Inactive">

   Deactivate


</a>

<%
} else {
%>

<a class="action-btn activate"
   href="updateStudentStatus?studentId=<%= s.getStudentId() %>&status=Active">

   Activate

</a>

<%
}
%>

</td>

<td>

<%
if("Active".equalsIgnoreCase(
        s.getStatus())){
%>

<a class="action-btn edit"
   href="editStudent?studentId=<%= s.getStudentId() %>">

   Edit

</a>

<%
} else {
%>

<span class="not-allowed">
    Not Allowed
</span>

<%
}
%>

</td>

</tr>

<%
}
%>

</table>

<%
}
%>

</div>

</body>
</html>