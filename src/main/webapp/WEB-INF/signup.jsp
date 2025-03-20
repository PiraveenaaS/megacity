<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Mage City Cab Service</title>
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
        .logo {
            margin-left: 25px;
            margin-bottom: 28px;
            font-size: 26px;
            font-weight: 700;
            color: #0288d1;
        }


        /* Sign-Up Form with Scrollbar */
        .signup-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 80vh;
        }

        .signup-form {
            background-color: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            text-align: center;
            max-height: 80vh;
            overflow-y: auto;
        }

        .signup-form h2 {
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
            top: 65%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 14px;
            color: #0288d1;
        }

        .signup-btn {
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

        .signup-btn:hover {
            background-color: #01579b;
        }

        .signin-link {
            margin-top: 20px;
            font-size: 14px;
            color: #333;
        }

        .signin-link a {
            color: #0288d1;
            text-decoration: none;
        }

        .signin-link a:hover {
            text-decoration: underline;
        }

        /* Validation Error Message */
        .error {
            display: none;
            color: #d32f2f;
            font-size: 18px;
            margin-top: 5px;
            text-align: center;
        }

        /* Custom Scrollbar Styling (Optional) */
        .signup-form::-webkit-scrollbar {
            width: 8px;
        }

        .signup-form::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 5px;
        }

        .signup-form::-webkit-scrollbar-thumb {
            background: #0288d1;
            border-radius: 5px;
        }

        .signup-form::-webkit-scrollbar-thumb:hover {
            background: #01579b;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .logo{
                margin-bottom: 40px;
            }
            .signup-form {
                padding: 20px;
                max-width: 90%;
                max-height: 90vh; /* Adjust for smaller screens */
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Navigation Bar -->
        <nav class="navbar">
            <div class="logo">MAGE CITY CAB</div>

        </nav>

        <!-- Sign-Up Form -->
        <div class="signup-container">
            <div class="signup-form">
                <h2>Sign Up</h2>
                <form id="signupForm" action="signup" method="post" onsubmit="return validateForm()">
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName" placeholder="Enter your first name" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName" placeholder="Enter your last name" required>
                    </div>
                    <div class="form-group">
                        <label for="nic">NIC (National Identity Card)</label>
                        <input type="text" id="nic" name="nic" placeholder="Enter your NIC" required maxlength = "12">
                        <div class="error" id="nicError">Check Your NIC Again...</div>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" placeholder="Enter your address" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" placeholder="Enter your phone (07xxxxxxxx)" required maxlength = "10">
                        <div class="error" id="phoneError">Phone must be 10 digits and start with 07.</div>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" placeholder="Enter your email" required>
                    </div>
                    <div class="form-group password-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required minlength="8">
                        <span class="toggle-password" onclick="togglePassword('password')">Show</span>
                    </div>
                    <div class="form-group password-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required minlength="8">
                        <span class="toggle-password" onclick="togglePassword('confirmPassword')">Show</span>
                        <div class="error" id="passwordError">Passwords do not match.</div>
                    </div>
                    <button type="submit" class="signup-btn">SIGN UP</button>

                </form>
                <div class="signin-link">
                    Already have an account? <a href="login">Sign In</a>
                </div>
                <div class="error" id="signupfail">SignUp Failed... !</div>
            </div>
        </div>
    </div>

    <script>
        function togglePassword(fieldId) {
            const passwordInput = document.getElementById(fieldId);
            const toggleText = passwordInput.nextElementSibling;
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleText.textContent = 'Hide';
            }
            else {
                passwordInput.type = 'password';
                toggleText.textContent = 'Show';
            }
        }

        // Form Validation
        function validateForm() {
            let isValid = true;

            // Phone Number Validation (10 digits, starts with 07)
            const phone = document.getElementById('phone').value;
            const phoneRegex = /^07\d{8}$/;
            if (!phoneRegex.test(phone)) {
                document.getElementById('phoneError').style.display = 'block';
                isValid = false;
            }
            else {
                document.getElementById('phoneError').style.display = 'none';
            }

            // NIC Validation
            const nic = document.getElementById('nic').value;
            const nicRegexNew = /^\d{12}$/;
            const nicRegexOld = /^\d{9}[Vv]$/;

            if (!(nicRegexNew.test(nic) || nicRegexOld.test(nic))) {
                document.getElementById('nicError').style.display = 'block';
                isValid = false;
            }
            else {
                document.getElementById('nicError').style.display = 'none';
            }


            // Password Match Validation
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            if (password !== confirmPassword) {
                document.getElementById('passwordError').style.display = 'block';
                isValid = false;
            }
            else {
                document.getElementById('passwordError').style.display = 'none';
            }

            return isValid;
        }

        function signupFail(){
            document.getElementById('signupfail').style.display = 'none';
        }
    </script>


    <!-- Jsp Login Error -->
     <%
         String status = (String) request.getAttribute("type");
         if (status != null && status.equals("fail")) {
     %>
         <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.getElementById('signupfail').style.display = 'block';
            });
         </script>
     <%
         }
     %>

</body>
</html>