<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mage City Cab Service</title>
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

        /* Main Content */
        .main-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 50px;
        }

        .text-content {
            max-width: 50%;
        }

        .text-content h1 {
            font-size: 48px;
            color: #01579b;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .text-content p {
            font-size: 16px;
            color: #333;
            line-height: 1.6;
            text-align: justify;
            margin-bottom: 30px;
        }

        .book-now {
            background-color: #0288d1;
            color: #fff;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            font-weight: 700;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .book-now:hover {
            background-color: #01579b;
        }

        /* Image and Discount Circle */
        .image-content {
            position: relative;
        }

        .car-driver {
            width: 400px;
            height: auto;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-content {
                flex-direction: column;
                text-align: center;
            }

            .text-content {
                max-width: 100%;
                margin-bottom: 30px;
            }

            .car-driver {
                width: 300px;
            }

        }
    </style>
</head>
<body>
    <div class="container">
        <nav class="navbar">
            <div class="logo">MAGE CITY CAB</div>
        </nav>

        <div class="main-content">
            <div class="text-content">
                <h1>Cab Service!</h1>
                <p>Welcome to <strong>Mage City Cab</strong>, your premier Cab service in the heart of the metropolis! Whether you're exploring the bustling streets or heading out for a business trip, we offer a wide range of vehicles to suit your needs. Book now and experience the best of city travel with Mage City Cab!</p>
                <a href="login"><button class="book-now">BOOK NOW</button></a>
            </div>
            <div class="image-content">
                <img src="https://backup.taximalaya.my/wp-content/uploads/2021/08/wfwqfqfdcew-1.png" alt="Car and Driver Illustration" class="car-driver">
            </div>
        </div>
    </div>

</body>
</html>