<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking - Mage City Cab Service</title>
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
            overflow-y: auto;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .booking-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            overflow-y: auto;
            padding: 20px 0;
        }
        .booking-form {
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
            max-height: 80vh;
            overflow-y: auto;
        }
        .booking-form h2 {
            font-size: 28px;
            color: #01579b;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
            position: relative;
        }
        .form-group label {
            display: block;
            font-size: 14px;
            color: #333;
            margin-bottom: 5px;
        }
        .form-group select, .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
            transition: border-color 0.3s ease;
        }
        .form-group input[type="checkbox"] {
            width: auto;
            margin-right: 10px;
        }
        .form-group select:focus, .form-group input:focus {
            border-color: #0288d1;
        }
        .ac-option {
            display: none;
        }
        .booking-btn {
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
        .booking-btn:hover {
            background-color: #01579b;
        }
        .bill-breakdown {
            margin-top: 20px;
            text-align: left;
            display: none;
        }
        .bill-breakdown p {
            font-size: 14px;
            color: #333;
            margin: 5px 0;
        }
        .bill-breakdown .total {
            font-weight: 700;
            color: #01579b;
        }
        .booking-container::-webkit-scrollbar,
        .booking-form::-webkit-scrollbar {
            width: 8px;
        }
        .booking-container::-webkit-scrollbar-track,
        .booking-form::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        .booking-container::-webkit-scrollbar-thumb,
        .booking-form::-webkit-scrollbar-thumb {
            background: #0288d1;
            border-radius: 4px;
        }
        .booking-container::-webkit-scrollbar-thumb:hover,
        .booking-form::-webkit-scrollbar-thumb:hover {
            background: #01579b;
        }
        .error {
            display: none;
            color: #d32f2f;
            font-size: 18px;
            margin-top: 5px;
            text-align: center;
        }
        .success {
            display: none;
            color: #10ef8a;
            font-size: 18px;
            margin-top: 5px;
            text-align: center;
        }
        @media (max-width: 768px) {
            .booking-form {
                padding: 20px;
                max-width: 90%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="booking-container">
            <div class="booking-form">
                <h2>Book a Ride</h2>
                <form id="bookingForm" onsubmit="return handleSubmit(event)">
                    <div class="form-group">
                        <label for="source">Source</label>
                        <input type="text" id="source" name="source" required oninput="fetchSuggestions('source')">
                        <div id="sourceSuggestions" style="position: absolute; background: white; border: 1px solid #ccc; max-height: 150px; overflow-y: auto; display: none; width: 100%; z-index: 10;"></div>
                    </div>
                    <div class="form-group">
                        <label for="destination">Destination</label>
                        <input type="text" id="destination" name="destination" required oninput="fetchSuggestions('destination')">
                        <div id="destinationSuggestions" style="position: absolute; background: white; border: 1px solid #ccc; max-height: 150px; overflow-y: auto; display: none; width: 100%; z-index: 10;"></div>
                    </div>
                    <div class="form-group">
                        <label for="vehicle">Vehicle</label>
                        <select id="vehicle" name="vehicle" required onchange="toggleACOption()">
                            <option value="">Select Vehicle</option>
                            <option value="threewheeler">Three Wheeler</option>
                            <option value="car">Car</option>
                            <option value="van">Van</option>
                        </select>
                    </div>
                    <div class="form-group ac-option" id="acOption">
                        <label>
                            <input type="checkbox" id="ac" name="ac"> Need AC
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="travel_date">Travel Date</label>
                        <input type="date" id="travel_date" name="travel_date" required>
                    </div>
                    <div class="form-group">
                        <label for="travel_time">Travel Time</label>
                        <select id="travel_time" name="travel_time" required></select>
                    </div>
                    <button type="submit" class="booking-btn">BOOK NOW</button>
                </form>
                <div class="bill-breakdown" id="billBreakdown">
                    <p>Base Price: <span id="basePrice">0</span> LKR</p>
                    <p>AC Price: <span id="acPrice">0</span> LKR</p>
                    <p>Distance Charge: <span id="distanceCharge">0</span> LKR</p>
                    <p class="total">Total Charge: <span id="totalCharge">0</span> LKR</p>
                </div>
                <div class="success" id="successMsg"></div>
                <div class="error" id="errorMsg"></div>
            </div>
        </div>
    </div>

    <script>
        // Populate time slots based on selected date
        function populateTimeSlots() {
            const select = document.getElementById('travel_time');
            const travelDate = document.getElementById('travel_date').value;
            const now = new Date();
            const today = now.toISOString().split('T')[0];

            select.innerHTML = '<option value="">Select Time</option>';

            let startTime = new Date();
            if (travelDate === today) {
                const currentMinute = now.getMinutes();
                const minutesToAdd = currentMinute > 30 ? (60 - currentMinute) : (30 - currentMinute);
                startTime.setMinutes(currentMinute + minutesToAdd);
                startTime.setSeconds(0);
                startTime.setMilliseconds(0);
            } else {
                startTime = new Date(travelDate);
                startTime.setHours(0, 0, 0, 0);
            }

            const endOfDay = new Date(startTime);
            endOfDay.setHours(23, 59, 59, 999);

            while (startTime <= endOfDay) {
                const timeStr = startTime.toLocaleTimeString([], {
                    hour: '2-digit',
                    minute: '2-digit',
                    hour12: false
                });
                const option = document.createElement('option');
                option.value = timeStr;
                option.textContent = timeStr;
                select.appendChild(option);
                startTime.setMinutes(startTime.getMinutes() + 30);
            }
        }

        // Fetch location suggestions from backend
        async function fetchSuggestions(fieldId) {
            const input = document.getElementById(fieldId);
            const suggestionsDiv = document.getElementById(fieldId + 'Suggestions');
            const query = input.value;

            if (query.length < 3) {
                suggestionsDiv.style.display = 'none';
                return;
            }

            try {
                const response = await fetch(`${window.location.contextPath || '/MegaCity'}/booking?q=${encodeURIComponent(query)}`, {
                    method: 'GET',
                    headers: { 'Content-Type': 'application/json' }
                });
                if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                const suggestions = await response.json();

                suggestionsDiv.innerHTML = '';
                suggestions.forEach(suggestion => {
                    const div = document.createElement('div');
                    div.textContent = suggestion;
                    div.style.padding = '5px';
                    div.style.cursor = 'pointer';
                    div.onmouseover = () => div.style.backgroundColor = '#f0f0f0';
                    div.onmouseout = () => div.style.backgroundColor = 'white';
                    div.onclick = () => {
                        input.value = suggestion;
                        suggestionsDiv.style.display = 'none';
                        calculateFare();
                    };
                    suggestionsDiv.appendChild(div);
                });
                suggestionsDiv.style.display = 'block';
            } catch (error) {
                console.error('Error fetching suggestions:', error);
                suggestionsDiv.style.display = 'none';
            }
        }

        // Toggle AC option
        function toggleACOption() {
            const vehicle = document.getElementById('vehicle').value;
            const acOption = document.getElementById('acOption');
            if (vehicle === 'car' || vehicle === 'van') {
                acOption.style.display = 'block';
            } else {
                acOption.style.display = 'none';
                document.getElementById('ac').checked = false;
            }
            calculateFare();
        }

        // Calculate fare by calling backend
        async function calculateFare() {
            const source = document.getElementById('source').value;
            const destination = document.getElementById('destination').value;
            const vehicle = document.getElementById('vehicle').value;
            const ac = document.getElementById('ac').checked;
            const travelDate = document.getElementById('travel_date').value;
            const travelTime = document.getElementById('travel_time').value;
            const billBreakdown = document.getElementById('billBreakdown');

            if (!source || !destination || !vehicle || !travelDate || !travelTime) {
                billBreakdown.style.display = 'none';
                return;
            }

            const data = { source, destination, vehicle, needAC: ac, travelDate, travelTime };
            try {
                const response = await fetch(`${window.location.contextPath || '/MegaCity'}/booking`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(data)
                });
                if (!response.ok) {
                    const text = await response.text();
                    throw new Error(`HTTP error! status: ${response.status}, response: ${text}`);
                }
                const fare = await response.json();

                document.getElementById('basePrice').textContent = fare.base.toFixed(2);
                document.getElementById('acPrice').textContent = fare.acCharge.toFixed(2);
                document.getElementById('distanceCharge').textContent = fare.distanceCharge.toFixed(2);
                document.getElementById('totalCharge').textContent = fare.total.toFixed(2);
                billBreakdown.style.display = 'block';
            } catch (error) {
                console.error('Error calculating fare:', error);
                billBreakdown.style.display = 'none';
            }
        }

        // Handle form submission
        async function handleSubmit(event) {
            event.preventDefault();
            await calculateFare();

            const source = document.getElementById('source').value;
            const destination = document.getElementById('destination').value;
            const vehicle = document.getElementById('vehicle').value;
            const needAC = document.getElementById('ac').checked;
            const travelDate = document.getElementById('travel_date').value;
            const travelTime = document.getElementById('travel_time').value;
            const totalCharge = document.getElementById('totalCharge').textContent;
            const successMsg = document.getElementById('successMsg');
            const errorMsg = document.getElementById('errorMsg');

            // Reset messages
            successMsg.style.display = 'none';
            errorMsg.style.display = 'none';

            const bookingData = {
                source: source,
                destination: destination,
                vehicle: vehicle,
                needAC: needAC,
                travelDate: travelDate,
                travelTime: travelTime,
                totalFare: parseFloat(totalCharge)
            };

            try {
                const response = await fetch(`${window.location.contextPath || '/MegaCity'}/bookride`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(bookingData)
                });

                if (!response.ok) {
                    throw new Error(`Booking failed! status: ${response.status}`);
                }

                const result = await response.json();
                if (result.success) {
                    successMsg.textContent = result.message; // "Booking is stored Confirmation will be by Email"
                    successMsg.style.display = 'block';
                    document.getElementById('bookingForm').reset();
                    document.getElementById('billBreakdown').style.display = 'none';

                    // Redirect to index page after 5 seconds
                    setTimeout(() => {
                        window.location.href = `${window.location.contextPath || '/MegaCity'}/index.jsp`;
                    }, 5000);
                } else {
                    throw new Error(result.message); // "Error confirming booking. Please try again."
                }
            } catch (error) {
                console.error('Error submitting booking:', error);
                errorMsg.textContent = error.message || 'Error submitting booking. Please try again.';
                errorMsg.style.display = 'block';
            }

            return false;
        }

        // Initialize page
        document.addEventListener('DOMContentLoaded', () => {
            const travelDateInput = document.getElementById('travel_date');
            const today = new Date().toISOString().split('T')[0];

            travelDateInput.setAttribute('min', today);
            travelDateInput.value = today;

            populateTimeSlots();

            travelDateInput.addEventListener('change', () => {
                populateTimeSlots();
                calculateFare();
            });
            document.getElementById('source').addEventListener('input', calculateFare);
            document.getElementById('destination').addEventListener('input', calculateFare);
            document.getElementById('vehicle').addEventListener('change', calculateFare);
            document.getElementById('ac').addEventListener('change', calculateFare);
            document.getElementById('travel_time').addEventListener('change', calculateFare);
        });

        // Hide suggestions when clicking outside
        document.addEventListener('click', (e) => {
            const sourceSuggestions = document.getElementById('sourceSuggestions');
            const destSuggestions = document.getElementById('destinationSuggestions');
            if (!e.target.closest('#source') && !e.target.closest('#sourceSuggestions')) {
                sourceSuggestions.style.display = 'none';
            }
            if (!e.target.closest('#destination') && !e.target.closest('#destinationSuggestions')) {
                destSuggestions.style.display = 'none';
            }
        });
    </script>
</body>
</html>