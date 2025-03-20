<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - Mage City Cab Service</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #e0f7fa 0%, #b3e5fc 100%);
            min-height: 100vh;
            overflow: hidden;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: #0288d1;
        }


        /* Sign-In Form */
        .signin-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 80vh;
        }

        .signin-form {
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .loginfail{
            display: none;
            color: #e01111;
            text-align: center;

        }

        .signin-form h2 {
            font-size: 28px;
            color: #01579b;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            color: #333;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus {
            border-color: #0288d1;
        }

        .password-group {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            right: 10px;
            top: 67%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 14px;
            color: #0288d1;
        }

        .signin-btn {
            background-color: #0288d1;
            color: #fff;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 700;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        .signin-btn:hover {
            background-color: #01579b;
        }

        .signup-link {
            margin-top: 20px;
            font-size: 14px;
            color: #333;
        }

        .signup-link a {
            color: #0288d1;
            text-decoration: none;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .signin-form {
                padding: 20px;
                max-width: 90%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <nav class="navbar">
            <div class="logo">MAGE CITY CAB</div>
        </nav>

        <!-- Sign-In Form -->
        <div class="signin-container">
            <div class="signin-form">
                <h2>Sign In</h2>
                <form id="signinForm" action="adminlogin" method="post">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" placeholder="Enter your email" required>
                    </div>
                    <div class="form-group password-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                        <span class="toggle-password" onclick="togglePassword()">Show</span>
                    </div>
                    <button type="submit" class="signin-btn">SIGN IN</button>
                </form>
                <div class="signup-link">

                </div>
                <br>
                <div class = 'loginfail'>Login Failed Please Try Again... !</div>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleText = document.querySelector('.toggle-password');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleText.textContent = 'Hide';
            } else {
                passwordInput.type = 'password';
                toggleText.textContent = 'Show';
            }
        }

        function showfail(){
            const failMessage = document.querySelector('.loginfail');
            setTimeout(() => {
                failMessage.style.display = 'none';
            }, 5000);
        }
    </script>

     <!-- login form issue JSP -->
     <%
         String status = (String) request.getAttribute("type");
         if (status != null && status.equals("fail")) {
     %>
         <script>
             document.addEventListener("DOMContentLoaded", function () {
                 const failMessage = document.querySelector('.loginfail');
                 failMessage.style.display = 'block';
                 setTimeout(() => {
                     failMessage.style.display = 'none';
                 }, 5000);
             });
         </script>
     <%
         }
     %>

</body>
</html>