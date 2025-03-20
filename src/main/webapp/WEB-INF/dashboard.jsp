<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        h1 {
            text-align: left;
            margin-bottom: 30px;
            color: #1c73ca;
        }

        .table-container {
            overflow-x: auto;
            background-color: white;
            border-radius: 11px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background-color: #142b3b;
            color: white;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        tbody tr:hover {
            background-color: #f1f1f1;
        }

        .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 90px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            box-shadow: none;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .confirm-btn {
            background-color: #2ecc71;
            color: white;
        }

        .confirm-btn:hover {
            background-color: #27ae60;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .confirm-btn:disabled {
            background-color: #95a5a6;
            transform: none;
        }

        .cancel-btn {
            background-color: #e74c3c;
            color: white;
        }

        .cancel-btn:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .status {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 500;
            display: inline-block;
        }

        .status-pending {
            background-color: #f39c12;
            color: white;
        }

        .status-confirmed {
            background-color: #2ecc71;
            color: white;
        }

        .status-cancelled {
            background-color: #e74c3c;
            color: white;
        }

        nav {
            background-color: #333;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand {
            color: white;
            font-family: Arial, sans-serif;
            font-size: 1.5rem;
            text-decoration: none;
            margin-left: 20px;
        }

        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        li a {
            color: white;
            text-decoration: none;
            font-family: Arial, sans-serif;
            padding: 10px 20px;
        }

        li a:hover {
            background-color: #555555;
            border-radius: 5px;
        }

        @media (max-width: 768px) {
            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <nav>
        <a href="#" class="brand">Megacitycab</a>
        <ul>
            <li><a href="<%= request.getContextPath() %>/dashboard">Booking</a></li>
            <li><a href="<%= request.getContextPath() %>/drivers">Drivers</a></li>
            <li><a href="<%= request.getContextPath() %>/vehicles">Vehicles</a></li>
            <li><a href="<%= request.getContextPath() %>/logout">Logout</a></li>
        </ul>
    </nav>
    <div class="container">
        <h1>Booking Management</h1>
        <div class="table-container">
            <table id="bookingsTable">
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Customer</th>
                        <th>Source</th>
                        <th>Destination</th>
                        <th>Vehicle</th>
                        <th>AC</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Table data will be populated by JavaScript -->
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const API_BASE_URL = '/MegaCity/dashboard';
        let allBookings = [];

        document.addEventListener('DOMContentLoaded', function() {
            populateBookingsTable();
            attachButtonListeners();
        });

        async function fetchBookings() {
            try {
                const response = await fetch(`${API_BASE_URL}/booking`, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                });

                if (!response.ok) {
                    throw new Error('Failed to fetch bookings');
                }

                return await response.json();
            } catch (error) {
                console.error('Error fetching bookings:', error);
                return [];
            }
        }

        async function populateBookingsTable() {
            const tableBody = document.querySelector('#bookingsTable tbody');
            tableBody.innerHTML = '<tr><td colspan="9">Loading...</td></tr>';

            if (allBookings.length === 0) {
                allBookings = await fetchBookings();
            }

            tableBody.innerHTML = '';
            allBookings.forEach(booking => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${booking.bookingID}</td>
                    <td>${booking.customer}</td>
                    <td>${booking.source}</td>
                    <td>${booking.destination}</td>
                    <td>${booking.vehicle}</td>
                    <td>${formatBinaryToYesNo(booking.needAC)}</td>
                    <td>Rs${parseFloat(booking.amount).toFixed(2)}</td>
                    <td><span class="status status-${booking.status.toLowerCase()}">${booking.status}</span></td>
                    <td>
                        <div class="action-buttons">
                            <button class="btn confirm-btn" data-id="${booking.bookingID}" ${booking.status !== 'Pending' ? 'disabled' : ''}>
                                Confirm
                            </button>
                            <button class="btn cancel-btn" data-id="${booking.bookingID}" ${booking.status !== 'Pending' ? 'disabled' : ''}>
                                Cancel
                            </button>
                        </div>
                    </td>
                `;
                tableBody.appendChild(row);
            });

            attachButtonListeners();
        }

        function attachButtonListeners() {
            document.querySelectorAll('.confirm-btn').forEach(button => {
                button.addEventListener('click', function() {
                    if (!this.disabled) {
                        const bookingID = this.getAttribute('data-id');
                        confirmBooking(bookingID);
                    }
                });
            });

            document.querySelectorAll('.cancel-btn').forEach(button => {
                button.addEventListener('click', function() {
                    if (!this.disabled) {
                        const bookingID = this.getAttribute('data-id');
                        cancelBooking(bookingID);
                    }
                });
            });
        }

        async function confirmBooking(bookingID) {
            try {
                const response = await fetch(`${API_BASE_URL}/bookings/confirm/${bookingID}`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    credentials: 'include'
                });

                if (!response.ok) {
                    throw new Error('Failed to confirm booking');
                }

                const bookingIndex = allBookings.findIndex(b => b.bookingID === bookingID);
                if (bookingIndex !== -1) {
                    allBookings[bookingIndex].status = 'Confirmed';
                }

                await populateBookingsTable();
                alert('Booking confirmed successfully!');
            } catch (error) {
                console.error('Error confirming booking:', error);
                alert('Failed to confirm booking. Please try again.');
            }
        }

        async function cancelBooking(bookingID) {
            try {
                const response = await fetch(`${API_BASE_URL}/bookings/cancel/${bookingID}`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    credentials: 'include'
                });

                if (!response.ok) {
                    throw new Error('Failed to cancel booking');
                }

                const bookingIndex = allBookings.findIndex(b => b.bookingID === bookingID);
                if (bookingIndex !== -1) {
                    allBookings[bookingIndex].status = 'Cancelled';
                }

                await populateBookingsTable();
                alert('Booking cancelled successfully!');
            } catch (error) {
                console.error('Error cancelling booking:', error);
                alert('Failed to cancel booking. Please try again.');
            }
        }

        function formatBinaryToYesNo(value) {
            return value === 1 ? "Yes" : "No";
        }
    </script>
</body>
</html>