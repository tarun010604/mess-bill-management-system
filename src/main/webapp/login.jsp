<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String msg = (String) request.getAttribute("msg");
    if (msg == null) {
        msg = request.getParameter("msg");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIT Admin Login</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }

    body {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        background: linear-gradient(135deg, #0f172a, #1e293b, #2563eb);
        padding: 20px;
    }

    .login-wrapper {
        width: 100%;
        max-width: 980px;
        display: grid;
        grid-template-columns: 1fr 1fr;
        background: rgba(255, 255, 255, 0.96);
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 18px 50px rgba(0, 0, 0, 0.28);
    }

    .left-panel {
        background: linear-gradient(160deg, #0f172a, #111827);
        color: white;
        padding: 50px 40px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
    }

   .logo {
    width: 160px;
    height: 160px;
    border-radius: 50%;
    object-fit: cover;
    overflow: hidden;
    border: 4px solid white;
    box-shadow: 0 0 25px rgba(255,255,255,0.3);
    margin-bottom: 20px;
}

    .left-panel h1 {
        font-size: 32px;
        line-height: 1.25;
        margin-bottom: 10px;
        color: #ffffff;
    }

    .system-name {
        font-size: 18px;
        font-weight: 600;
        color: #60a5fa;
        margin-bottom: 18px;
    }

    .left-panel p {
        font-size: 15px;
        line-height: 1.8;
        color: #d1d5db;
        max-width: 360px;
    }

    .right-panel {
        padding: 45px 38px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        background: #ffffff;
    }

    .form-title {
        font-size: 28px;
        font-weight: 700;
        color: #111827;
        margin-bottom: 8px;
    }

    .form-subtitle {
        font-size: 14px;
        color: #6b7280;
        margin-bottom: 24px;
    }

    .msg {
        background: #fee2e2;
        color: #b91c1c;
        border: 1px solid #fecaca;
        padding: 12px 14px;
        border-radius: 10px;
        margin-bottom: 18px;
        font-size: 14px;
        font-weight: 500;
    }

    .input-group {
        margin-bottom: 18px;
    }

    .input-group label {
        display: block;
        font-size: 14px;
        font-weight: 600;
        color: #374151;
        margin-bottom: 8px;
    }

    .input-group input {
        width: 100%;
        padding: 13px 15px;
        border: 1px solid #d1d5db;
        border-radius: 12px;
        outline: none;
        font-size: 14px;
        transition: 0.2s ease;
        background: #f9fafb;
    }

    .input-group input:focus {
        border-color: #2563eb;
        background: #fff;
        box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.12);
    }

    .password-wrap {
        position: relative;
    }

    .toggle {
        position: absolute;
        right: 14px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        font-size: 13px;
        color: #2563eb;
        font-weight: 600;
        user-select: none;
    }

    .login-btn {
        width: 100%;
        border: none;
        outline: none;
        padding: 14px;
        border-radius: 12px;
        background: linear-gradient(90deg, #2563eb, #1d4ed8);
        color: white;
        font-size: 15px;
        font-weight: 700;
        cursor: pointer;
        transition: 0.25s ease;
        margin-top: 8px;
        box-shadow: 0 10px 20px rgba(37, 99, 235, 0.25);
    }

    .login-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 14px 24px rgba(37, 99, 235, 0.30);
    }

    .login-btn:active {
        transform: translateY(0);
    }

    .footer-note {
        margin-top: 18px;
        text-align: center;
        font-size: 13px;
        color: #6b7280;
    }

    @media (max-width: 850px) {
        .login-wrapper {
            grid-template-columns: 1fr;
        }

        .left-panel {
            padding: 34px 24px;
        }

        .right-panel {
            padding: 34px 24px;
        }

        .left-panel h1 {
            font-size: 26px;
        }

        .system-name {
            font-size: 16px;
        }

        .logo {
            width: 110px;
            height: 110px;
        }
    }
</style>

<script>
    function togglePassword() {
        const pwd = document.getElementById("password");
        const toggle = document.getElementById("toggleText");

        if (pwd.type === "password") {
            pwd.type = "text";
            toggle.innerText = "Hide";
        } else {
            pwd.type = "password";
            toggle.innerText = "Show";
        }
    }
</script>
</head>
<body>

<div class="login-wrapper">
    <div class="left-panel">
        <img src="<%=request.getContextPath()%>/images/Screenshot 2026-05-29 114949.png" alt="VIT Logo" class="logo">

        <h1>Visionary Institute of Technology</h1>
        <div class="system-name">Mess Billing Management System</div>

        <p>
            Secure administration portal for managing students, attendance,
            billing, payments, reminders, and reports.
        </p>
    </div>

    <div class="right-panel">
        <div class="form-title">Admin Login</div>
        <div class="form-subtitle">Enter your credentials to continue</div>

        <% if (msg != null && !msg.trim().isEmpty()) { %>
            <div class="msg"><%= msg %></div>
        <% } %>

        <form action="login" method="post">
            <div class="input-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter username" required>
            </div>

            <div class="input-group">
                <label>Password</label>
                <div class="password-wrap">
                    <input type="password" name="password" id="password" placeholder="Enter password" required>
                    <span class="toggle" id="toggleText" onclick="togglePassword()">Show</span>
                </div>
            </div>

            <button type="submit" class="login-btn">Login</button>
        </form>

        <div class="footer-note">
            Secure access for college administration
        </div>
    </div>
</div>

</body>
</html>