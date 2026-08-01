<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List" %>
<%@ page import="com.messbill.Entity.ActivityLog" %>
<%@ page import="com.messbill.Service.ActivityService" %>
<%@ page import="com.messbill.Service.StudentService" %>
<%@ page import="com.messbill.Service.BillService" %>
<%@ page import="com.messbill.Service.PaymentService" %>

<%
    String username = (String) session.getAttribute("username");

    if(username == null)
    {
        response.sendRedirect("login.jsp");
        return;
    }
    
    ActivityService activityService = new ActivityService();
    List<ActivityLog> activities = activityService.getLatestActivities();
    
   
    StudentService studentService = new StudentService();
    BillService billService = new BillService();
    PaymentService paymentService = new PaymentService();

    Long totalStudents = studentService.getTotalStudentsCount();
    Long activeStudents = studentService.getActiveStudentsCount();
    Long totalBills = billService.getTotalBillsCount();
    Long pendingBills = billService.getPendingBillsCount();
    Long paidBills = billService.getPaidBillsCount();
    Long totalPayments = paymentService.getTotalPaymentsCount();

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>

<style>

body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:#f1f5f9;
}


.sidebar{
    position:fixed;
    left:0;
    top:0;
    width:280px;
    height:100vh;
    background:linear-gradient(
180deg,
#020617,
#0f172a,
#111827
);;
    overflow-y:auto;
    box-shadow:4px 0 20px rgba(0,0,0,.15);
}

.sidebar-header{
    text-align:center;

    padding:30px 15px;

    background:
    linear-gradient(
    180deg,
    rgba(37,99,235,.15),
    transparent
    );

    border-bottom:
    1px solid rgba(255,255,255,.08);
}
.sidebar-logo{
    width:90px;
    height:90px;

    border-radius:50%;

    object-fit:cover;

    border:4px solid white;

    box-shadow:
    0 0 25px rgba(255,255,255,.25);
}

.sidebar-title{
    color:white;
    margin-top:10px;
    font-size:16px;
    font-weight:bold;
}

.sidebar-sub{
    color:#cbd5e1;
    font-size:12px;
}

.sidebar a{
    display:flex;
    align-items:center;
    gap:12px;

    margin:8px 12px;
    padding:14px 18px;

    color:#e2e8f0;
    text-decoration:none;

    border-radius:14px;

    transition:all .3s ease;
}

.sidebar a:hover{
    background:linear-gradient(
        90deg,
        #2563eb,
        #3b82f6
    );

    color:white;

    transform:translateX(8px);

    box-shadow:
    0 8px 20px rgba(37,99,235,.35);
}

.main{
    margin-left:260px;
    padding:25px;
}

.topbar{
    background:
    linear-gradient(
    135deg,
    #1e3a8a,
    #2563eb,
    #3b82f6
    );

    border-radius:20px;
    padding:25px 35px;

    display:flex;
    justify-content:space-between;
    align-items:center;

    color:white;

    box-shadow:
    0 15px 35px rgba(37,99,235,.30);

    margin-bottom:25px;
}

.topbar-title{
    display:flex;
    flex-direction:column;
}

.topbar-title h2{
    margin:0;
    font-size:34px;
    font-weight:700;
    color:white;
}

.topbar-title span{
    margin-top:5px;
    font-size:14px;
    opacity:.9;
}

.user-section{
    display:flex;
    align-items:center;
    justify-content:flex-end;
    gap:15px;
}

.logout-btn{
    background:white;
    color:#dc2626;
    padding:10px 18px;
    border-radius:10px;
    text-decoration:none;
    font-weight:bold;
    transition:.3s;
}

.logout-btn:hover{
    background:#dc2626;
    color:white;
}
.hero{
    background:
    linear-gradient(
    135deg,
    #1e3a8a,
    #2563eb,
    #3b82f6
    );

    color:white;
    padding:40px;
    border-radius:24px;

    box-shadow:
    0 20px 40px rgba(37,99,235,.35);

    margin-bottom:25px;
}

.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(230px,1fr));
    gap:20px;
    margin-bottom:30px;
}

.card{
  padding:25px;
    border-radius:22px;
    color:white;
    position:relative;
    overflow:hidden;
    transition:.3s;

    box-shadow:
    0 15px 30px rgba(0,0,0,.15);

    border:1px solid rgba(255,255,255,.15);
}

.card:hover{
    transform:translateY(-8px) scale(1.03);
}

.card h2{
    margin:0;
    font-size:40px;
    font-weight:800;
    color:#ffffff;

    text-shadow:
    0 2px 8px rgba(0,0,0,.25);
}

.card p{
  margin-top:12px;

    font-size:15px;

    font-weight:700;

    color:#ffffff;

    letter-spacing:.5px;

    text-shadow:
    0 2px 6px rgba(0,0,0,.20);
}

.card::after{
    content:'';
    position:absolute;
    width:120px;
    height:120px;
    border-radius:50%;
    background:rgba(255,255,255,.15);
    top:-30px;
    right:-30px;
}
.student-card{
    background:linear-gradient(135deg,#2563eb,#60a5fa);
}

.active-card{
    background:linear-gradient(135deg,#059669,#34d399);
}

.bill-card{
    background:linear-gradient(135deg,#7c3aed,#a78bfa);
}

.pending-card{
    background:linear-gradient(135deg,#dc2626,#f87171);
}

.paid-card{
    background:linear-gradient(135deg,#ea580c,#fb923c);
}

.payment-card{
    background:linear-gradient(135deg,#0891b2,#22d3ee);
}
.quick-actions{
    background:white;
    border-radius:20px;
    padding:25px;
    margin-bottom:25px;
    box-shadow:0 10px 25px rgba(0,0,0,.08);
}
.quick-actions h2{
    font-size:32px;
    font-weight:800;
    color:#1e3a8a;
    margin-bottom:25px;
}
.action-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:20px;
    margin-top:20px;
}
.action-card{
    text-decoration:none;
    color:white;

    border-radius:20px;

    padding:25px;

    text-align:center;

    transition:.35s;

    box-shadow:
    0 10px 25px rgba(0,0,0,.15);

    position:relative;

    overflow:hidden;
}

.action-card:hover{
    transform:translateY(-8px) scale(1.05);
}

.action-card::after{
    content:'';
    position:absolute;

    width:120px;
    height:120px;

    background:rgba(255,255,255,.15);

    border-radius:50%;

    top:-30px;
    right:-30px;
}
.action-icon{
    font-size:50px;
    margin-bottom:15px;
}
.action-card span{
    display:block;
    font-size:18px;
    font-weight:700;
    margin-top:10px;
}
.add-student{
    background:linear-gradient(135deg,#2563eb,#60a5fa);
}

.view-student{
    background:linear-gradient(135deg,#7c3aed,#a78bfa);
}

.attendance{
    background:linear-gradient(135deg,#059669,#34d399);
}

.bill{
    background:linear-gradient(135deg,#ea580c,#fb923c);
}

.view-bill{
    background:linear-gradient(135deg,#dc2626,#f87171);
}

.payment{
    background:linear-gradient(135deg,#0891b2,#22d3ee);
}

.report{
    background:linear-gradient(135deg,#9333ea,#c084fc);
}

.history{
    background:linear-gradient(135deg,#0f766e,#2dd4bf);
}


.main{
    margin-left:260px;
    padding:25px;
}

.hero h1{
    margin:0;
    font-size:32px;
}

.hero p{
    margin-top:10px;
    opacity:.95;
}
.activity{
    background:white;
    border-radius:25px;
    padding:30px;

    box-shadow:
    0 10px 25px rgba(0,0,0,.08);
}

.section-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
}

.section-header h2{
    margin:0;
    color:#2563eb;
    font-size:34px;
}

.section-header span{
    color:#64748b;
    font-weight:600;
}

.activity-list{
    display:flex;
    flex-direction:column;
    gap:18px;
}

.activity-item{

    display:flex;
    align-items:center;

    padding:18px;

    border-radius:18px;

    background:
    linear-gradient(
    90deg,
    #f8fafc,
    #ffffff
    );

    transition:.3s;

    border-left:5px solid #2563eb;
}

.activity-item:hover{
    transform:translateX(8px);

    box-shadow:
    0 8px 20px rgba(0,0,0,.08);
}

.activity-icon{
    width:55px;
    height:55px;

    border-radius:50%;

    background:
    linear-gradient(
    135deg,
    #2563eb,
    #60a5fa
    );

    display:flex;
    align-items:center;
    justify-content:center;

    color:white;
    font-size:22px;

    margin-right:18px;
}

.activity-content{
    flex:1;
}

.activity-content h4{
    margin:0;
    font-size:18px;
    color:#0f172a;
}

.activity-content p{
    margin-top:4px;
    color:#64748b;
}

.status-badge{

    background:
    linear-gradient(
    135deg,
    #059669,
    #34d399
    );

    color:white;

    padding:8px 16px;

    border-radius:30px;

    font-weight:bold;
}

.no-activity{
    text-align:center;
    padding:30px;
    color:#64748b;
}
.menu-title{
    color:#64748b;

    font-size:12px;

    font-weight:bold;

    letter-spacing:2px;

    padding:15px 20px 8px;
}


</style>

</head>

<body>

<!-- Header -->





    <!-- Sidebar -->

    <div class="sidebar">

    <div class="sidebar-header">

        <img src="<%=request.getContextPath()%>/images/Screenshot 2026-05-29 114949.png"
             class="sidebar-logo"
             alt="VIT Logo">

        <div class="sidebar-title">
            Visionary Institute of Technology
        </div>

        <div class="sidebar-sub">
            Mess Billing Management System
        </div>

    </div>
     <div class="menu-title">
        MAIN MENU
    </div>

    <a href="dashboard.jsp" class="active-menu">🏠 Dashboard</a>
    <a href="addStudent.jsp">➕ Add Student</a>
    <a href="viewStudents.jsp">👨‍🎓 Students</a>
    <a href="attendance.jsp">📝 Attendance</a>
    <a href="generateBill.jsp">💵 Generate Bill</a>
    <a href="viewBills">📄 Bills</a>
    <a href="viewPayments.jsp">💳 Payments</a>
    <a href="billHistory.jsp">📚 Bill History</a>
    <a href="reports.jsp">📈	 Reports</a>
    
   

</div>
    <!-- Main Content -->
    
    <div class="main">

    <!-- TOP BAR -->

 <div class="topbar">

    <div class="topbar-title">
        <h2>Dashboard</h2>
        <span>Visionary Institute of Technology</span>
    </div>

    <div class="user-section">

        <span>
            Welcome,
            <b><%= username %></b>
        </span>

        <a href="logout" class="logout-btn">
            Logout
        </a>

    </div>

</div>
 <!-- HERO -->

    <div class="hero">

        <h1>
            Welcome Back,
            <%= username %> 👋	
        </h1>

        <p>
            Manage Students, Attendance,
            Bills, Payments and Reports
            from one centralized dashboard.
        </p>

    </div>
    
    <!-- CARDS -->

    <div class="cards">

    <div class="card student-card">
        <h2><%= totalStudents %></h2>
        <p>👨‍🎓 Total Students</p>
    </div>

    <div class="card active-card">
        <h2><%= activeStudents %></h2>
        <p>✅ Active Students</p>
    </div>

    <div class="card bill-card">
        <h2><%= totalBills %></h2>
        <p>📄 Total Bills</p>
    </div>

    <div class="card pending-card">
        <h2><%= pendingBills %></h2>
        <p>⏳ Pending Bills</p>
    </div>

    <div class="card paid-card">
        <h2><%= paidBills %></h2>
        <p>💰 Paid Bills</p>
    </div>

    <div class="card payment-card">
        <h2><%= totalPayments %></h2>
        <p>💳 Total Payments</p>
    </div>

</div>
       <!-- QUICK ACTIONS -->

    <div class="quick-actions">

        <h2>Quick Actions</h2>

        	<div class="action-grid">

<a href="addStudent.jsp"
   class="action-card add-student">
    <div class="action-icon">👨‍🎓</div>
    <span>Add Student</span>
</a>

<a href="viewStudents.jsp"
   class="action-card view-student">
    <div class="action-icon">📋</div>
    <span>View Students</span>
</a>

<a href="attendance.jsp"
   class="action-card attendance">
    <div class="action-icon">📝</div>
    <span>Attendance</span>
</a>

<a href="generateBill.jsp"
   class="action-card bill">
    <div class="action-icon">💰</div>
    <span>Generate Bill</span>
</a>

<a href="viewBills"
   class="action-card view-bill">
    <div class="action-icon">📄</div>
    <span>View Bills</span>
</a>

<a href="viewPayments.jsp"
   class="action-card payment">
    <div class="action-icon">💳</div>
    <span>Payments</span>
</a>

<a href="reports.jsp"
   class="action-card report">
    <div class="action-icon">📊</div>
    <span>Reports</span>
</a>

<a href="billHistory.jsp"
   class="action-card history">
    <div class="action-icon">📚</div>
    <span>Bill History</span>
</a>

</div>
    </div>

    <!-- RECENT ACTIVITY -->

    <div class="activity">

    <div class="section-header">
        <h2>📈 Recent Activity</h2>
        <span>Latest System Updates</span>
    </div>

    <div class="activity-list">

    <%
        if(activities != null && !activities.isEmpty()){

            for(ActivityLog a : activities){
    %>

        <div class="activity-item">

            <div class="activity-icon">
                🔔
            </div>

            <div class="activity-content">

                <h4>
                    <%= a.getActivityName() %>
                </h4>

                <p>
                    <%= a.getActivityDate() %>
                </p>

            </div>

            <div class="status-badge">
                <%= a.getStatus() %>
            </div>

        </div>

    <%
            }
        }
        else{
    %>

        <div class="no-activity">
            No Recent Activity Found
        </div>

    <%
        }
    %>

    </div>

</div>
</div>

</body>
</html>