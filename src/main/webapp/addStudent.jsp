<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Student</title>
</head>
<style>
body{
    font-family:'Poppins',sans-serif;
    background:linear-gradient(
        135deg,
        #dbeafe 0%,
        #bfdbfe 25%,
        #93c5fd 50%,
        #60a5fa 75%,
        #3b82f6 100%
    );
    min-height:100vh;
}
.page-header{
    background:
    linear-gradient(
    135deg,
    #1e3a8a,
    #2563eb,
    #3b82f6
    );

    color:white;

    display:flex;
    justify-content:space-between;
    align-items:center;

    padding:18px 30px;

    border-radius:0 0 25px 25px;

    box-shadow:
    0 8px 25px rgba(37,99,235,.25);

    margin-bottom:30px;
}

.header-left{
    display:flex;
    align-items:center;
    gap:18px;
}

.page-logo{
    width:70px;
    height:70px;

    border-radius:50%;

    background:white;

    padding:4px;

    object-fit:cover;
}

.header-left h2{
    margin:0;
    font-size:22px;
    font-weight:700;
}

.header-left p{
    margin:0;
    font-size:14px;
    opacity:.9;
}

.header-right{
    display:flex;
    gap:15px;
}

.dashboard-btn{
    background:white;
    color:#2563eb;

    padding:12px 24px;

    border-radius:14px;

    text-decoration:none;

    font-weight:700;

    transition:.3s;
}

.dashboard-btn:hover{
    transform:translateY(-2px);
}

.logout-btn{
    background:#ef4444;
    color:white;

    padding:12px 24px;

    border-radius:14px;

    text-decoration:none;

    font-weight:700;

    transition:.3s;
}

.logout-btn:hover{
    background:#dc2626;
    transform:translateY(-2px);
}
.form-container{
    max-width:1000px;
    margin:40px auto;
    position:relative;
}

.form-container::before{
    content:'';
    position:absolute;
    width:300px;
    height:300px;
    background:#60a5fa;
    border-radius:50%;
    filter:blur(120px);
    top:-100px;
    left:-100px;
    opacity:.25;
}

.form-card{
          background:rgba(255,255,255,0.95);
    backdrop-filter:blur(15px);
    padding:40px;
    border-radius:30px;
    box-shadow:
        0 20px 50px rgba(37,99,235,.25),
        0 5px 15px rgba(0,0,0,.08);
    border:1px solid rgba(255,255,255,.4);

}

.form-card h1{
    font-size:42px;
    margin-bottom:10px;
    font-weight:800;

    background:linear-gradient(
        90deg,
        #1e3a8a,
        #2563eb,
        #60a5fa
    );

    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}

.subtitle{
    color:#64748b;
    margin-top:8px;
    margin-bottom:30px;
}

.form-grid{
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:25px;
}

.form-group{
    display:flex;
    flex-direction:column;
}

.form-group label{
    margin-bottom:8px;
    font-weight:600;
    color:black	;
}

.form-group input,
.form-group select{
background:#f8fafc;

    border:2px solid #dbeafe;

    border-radius:16px;

    padding:15px 18px;

    font-size:15px;

    transition:.3s;}

.form-group input:focus,
.form-group select:focus{
    background:white;

    border-color:#2563eb;

    box-shadow:
        0 0 0 5px rgba(37,99,235,.15);

    transform:translateY(-2px);
}

.gender-group{
    display:flex;
    gap:20px;
    margin-top:10px;
}

.gender-group label{
    font-weight:500;
}

.error{
    color:#dc2626;
    font-size:13px;
    margin-top:5px;
}

.submit-area{
    grid-column:span 2;
    text-align:center;
    margin-top:15px;
}

.submit-btn{

    background:linear-gradient(
        135deg,
        #2563eb,
        #1d4ed8,
        #3b82f6
    );

    color:white;

    border:none;

    padding:16px 45px;

    border-radius:16px;

    font-size:18px;

    font-weight:700;

    cursor:pointer;

    transition:.3s;

    box-shadow:
        0 12px 25px rgba(37,99,235,.35);
}
.submit-btn:hover{

    transform:translateY(-4px);

    box-shadow:
        0 20px 35px rgba(37,99,235,.45);
}
</style>
<body>


<div class="page-header">

    <div class="header-left">

        <img src="<%=request.getContextPath()%>/images/Screenshot 2026-05-29 114949.png"
             class="page-logo">

        <div>
            <h2>Visionary Institute of Technology</h2>
            <p>Mess Billing Management System</p>
        </div>

    </div>

    <div class="header-right">

        <a href="dashboard.jsp" class="dashboard-btn">
            Dashboard
        </a>

        <a href="logout" class="logout-btn">
            Logout
        </a>

    </div>

</div>

<div class="form-container">

<div class="form-card">

<h1>🎓Add Student</h1>

<p class="subtitle">
Register New Hostel Student
</p>

<form action="addstudent" method="post">

<div class="form-grid">

<!-- Name -->
<div class="form-group">
<label>Name</label>
<input type="text" name="name">

<div class="error">
<%= request.getAttribute("nameError") != null ?
request.getAttribute("nameError") : "" %>
</div>
</div>

<!-- Roll No -->
<div class="form-group">
<label>Roll No</label>
<input type="text" name="rollNo">

<div class="error">
<%= request.getAttribute("rollNoError") != null ?
request.getAttribute("rollNoError") : "" %>
</div>
</div>

<!-- Email -->
<div class="form-group">
<label>Email</label>
<input type="email" name="email">

<div class="error">
<%= request.getAttribute("emailError") != null ?
request.getAttribute("emailError") : "" %>
</div>
</div>

<!-- Phone -->
<div class="form-group">
<label>Phone</label>
<input type="tel" name="phone">

<div class="error">
<%= request.getAttribute("phoneError") != null ?
request.getAttribute("phoneError") : "" %>
</div>
</div>

<!-- Parent Phone -->
<div class="form-group">
<label>Parent Phone</label>
<input type="tel" name="parentPhone">

<div class="error">
<%= request.getAttribute("parentPhoneError") != null ?
request.getAttribute("parentPhoneError") : "" %>
</div>
</div>

<!-- Department -->
<div class="form-group">
<label>Department</label>

<select name="department">
<option value="">Select Department</option>
<option value="CSE">CSE</option>
<option value="IT">IT</option>
<option value="ECE">ECE</option>
<option value="EEE">EEE</option>
<option value="MECH">MECH</option>
<option value="AI & DS">AI & DS</option>
<option value="CIVIL">CIVIL</option>
</select>

<div class="error">
<%= request.getAttribute("departmentError") != null ?
request.getAttribute("departmentError") : "" %>
</div>
</div>

<!-- Gender -->
<div class="form-group">
<label>Gender</label>

<div class="gender-group">
<label>
<input type="radio" name="gender" value="Male"> Male
</label>

<label>
<input type="radio" name="gender" value="Female"> Female
</label>

<label>
<input type="radio" name="gender" value="Other"> Others
</label>
</div>

<div class="error">
<%= request.getAttribute("genderError") != null ?
request.getAttribute("genderError") : "" %>
</div>
</div>

<!-- Year -->
<div class="form-group">
<label>Year</label>

<select name="year">
<option value="">Select Year</option>
<option value="1st Year">1st Year</option>
<option value="2nd Year">2nd Year</option>
<option value="3rd Year">3rd Year</option>
<option value="4th Year">4th Year</option>
</select>

<div class="error">
<%= request.getAttribute("yearError") != null ?
request.getAttribute("yearError") : "" %>
</div>
</div>

<!-- Hostel Room -->
<div class="form-group">
<label>Hostel Room No</label>

<input type="text" name="hostelRoomNo">

<div class="error">
<%= request.getAttribute("hostelRoomNoError") != null ?
request.getAttribute("hostelRoomNoError") : "" %>
</div>
</div>

<!-- Status -->
<div class="form-group">
<label>Status</label>

<select name="status">
<option value="Active">Active</option>
</select>

<div class="error">
<%= request.getAttribute("statusError") != null ?
request.getAttribute("statusError") : "" %>
</div>
</div>

<div class="submit-area">
<button type="submit" class="submit-btn">
Add Student
</button>
</div>

</div>

</form>

</div>

</div>	
</body>
</html>