<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            background-color: #f9fafb;
            min-height: 100vh;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #333;
            line-height: 1.5;
        }

        nav {
            background-color: #333;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
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
            margin-right: 20px;
        }

        li a {
            color: white;
            text-decoration: none;
            font-family: Arial, sans-serif;
            padding: 10px 20px;
            display: block;
        }

        li a:hover {
            background-color: #555555;
            border-radius: 5px;
        }

        .container {
            width: 100%;
            max-width: 1280px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            width: 100%;
        }

        .card-title {
            font-size: 2.75rem;
            font-weight: 700;
            color: #0b65e4;
            flex: 1;
        }

        .header-actions {
            display: flex;
            align-items: center;
            flex: 1;
            justify-content: flex-end;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
            font-weight: 500;
            border-radius: 0.375rem;
            cursor: pointer;
            transition: background-color 0.2s, color 0.2s;
            border: none;
            outline: none;
        }

        .btn-primary {
            background-color: #10b981;
            color: white;
        }

        .btn-primary:hover {
            background-color: #059669;
        }

        .btn-secondary {
            background-color: #6b7280;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #4b5563;
        }

        .table-container {
            overflow-x: auto;
            margin-bottom: 2rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: transparent;
        }

        thead {
            background-color: #091b3e;
            border-bottom: 2px solid #d1d5db;
        }

        th {
            padding: 1rem;
            text-align: left;
            font-size: 0.875rem;
            font-weight: 600;
            color: #eff0f3;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid #3f66b2;
            vertical-align: middle;
        }

        tr {
            transition: background-color 0.2s;
        }

        tr:hover {
            background-color: #f3f4f6;
        }

        .empty-message {
            padding: 1rem;
            text-align: center;
            color: #6b7280;
        }

        .status-badge {
            padding: 0.25rem 0.75rem;
            font-size: 0.75rem;
            font-weight: 500;
            border-radius: 0.25rem;
            display: inline-block;
        }

        .status-available {
            background-color: #dcfce7;
            color: #166534;
        }

        .status-in-use {
            background-color: #dbeafe;
            color: #1e40af;
        }

        .status-repair {
            background-color: #fef9c3;
            color: #854d0e;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .edit-btn {
            background-color: #2563eb;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            cursor: pointer;
            border: none;
            font-weight: 500;
            transition: background-color 0.2s;
        }

        .edit-btn:hover {
            background-color: #1d4ed8;
        }

        .delete-btn {
            background-color: #dc2626;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            cursor: pointer;
            border: none;
            font-weight: 500;
            transition: background-color 0.2s;
        }

        .delete-btn:hover {
            background-color: #b91c1c;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-size: 0.875rem;
            font-weight: 500;
            color: #374151;
            margin-bottom: 0.25rem;
        }

        .form-control {
            width: 100%;
            padding: 0.5rem 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
            font-size: 1rem;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: #10b981;
            box-shadow: 0 0 0 2px rgba(16, 185, 129, 0.3);
        }

        .form-grid {
            display: grid;
            gap: 1.5rem;
        }

        .form-actions {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            margin-top: 1.5rem;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 50;
            animation: fadeIn 0.3s;
        }

        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 20px;
            border-radius: 8px;
            width: 95%;
            max-width: 800px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            animation: slideDown 0.3s;
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .modal-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1f2937;
        }

        .modal-close {
            color: #6b7280;
            cursor: pointer;
            background: none;
            border: none;
        }

        .modal-close:hover {
            color: #374151;
        }

        .loading {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 100;
        }

        .spinner {
            border: 4px solid rgba(0, 0, 0, 0.1);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            border-left-color: #10b981;
            animation: spin 1s linear infinite;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideDown {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @media (min-width: 769px) {
            .search-container {
                position: absolute;
                left: 50%;
                transform: translateX(-50%);
                width: 250px;
            }
        }

        @media (max-width: 768px) {
            .card-header {
                flex-direction: column;
                align-items: stretch;
                gap: 1rem;
                position: relative;
            }

            .search-container {
                position: static;
                transform: none;
                width: 100%;
            }

            #searchInput {
                width: 100% !important;
            }

            .header-actions {
                flex-direction: column;
                width: 100%;
            }

            #addVehicleBtn {
                width: 100%;
            }

            nav {
                flex-direction: column;
                gap: 1rem;
            }

            ul {
                flex-direction: column;
                width: 100%;
                margin-right: 0;
            }

            li a {
                width: 100%;
                text-align: center;
            }
        }

        .search-container {
            display: flex;
            justify-content: center;
        }

        @media (min-width: 640px) {
            .form-actions {
                flex-direction: row;
                justify-content: flex-end;
            }

            .btn-cancel {
                order: 1;
            }

            .btn-submit {
                order: 2;
            }
        }

        @media (max-width: 640px) {
            .modal-content {
                padding: 15px;
                margin: 2% auto;
                width: 98%;
            }

            .btn-full {
                width: 100%;
            }

            .btn-submit {
                order: 1;
            }

            .btn-cancel {
                order: 2;
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

    <div class="loading" id="loadingIndicator">
        <div class="spinner"></div>
    </div>

    <div class="container">
        <div class="card-header">
            <h1 class="card-title">Vehicle Details</h1>
            <div class="search-container">
                <input type="text" id="searchInput" placeholder="Search vehicles..." class="form-control" style="max-width: 250px;">
            </div>
            <div class="header-actions">
                <button id="addVehicleBtn" class="btn btn-primary">
                    <i class="fas fa-plus btn-icon"></i> Add Vehicle
                </button>
            </div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>License Plate Number</th>
                        <th>Vehicle Category</th>
                        <th>Seat Capacity</th>
                        <th>Fuel Type</th>
                        <th>Model</th>
                        <th>Status</th>
                        <th>Buy On</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="vehicleTableBody">
                    <!-- Vehicle data will be populated here -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Vehicle Form Modal -->
    <div id="vehicleFormModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle" class="modal-title">Add New Vehicle</h2>
                <button id="closeModal" class="modal-close">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <form id="vehicleForm">
                <input type="hidden" id="vehicleId" value="">

                <div class="form-grid">
                    <div class="form-group">
                        <label for="license_plate_number" class="form-label">License Plate Number</label>
                        <input type="text" id="license_plate_number" name="license_plate_number" required class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="vehicle_category" class="form-label">Vehicle Category</label>
                        <select id="vehicle_category" name="vehicle_category" required class="form-control">
                            <option value="">Select Vehicle Category</option>
                            <option value="Three Wheeler">Three Wheeler</option>
                            <option value="Car">Car</option>
                            <option value="Van">Van</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="seat_capacity" class="form-label">Seat Capacity</label>
                        <input type="number" id="seat_capacity" name="seat_capacity" required min="1" class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="fuel_type" class="form-label">Fuel Type</label>
                        <select id="fuel_type" name="fuel_type" required class="form-control">
                            <option value="">Select Fuel Type</option>
                            <option value="Petrol">Petrol</option>
                            <option value="Diesel">Diesel</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="model" class="form-label">Model</label>
                        <input type="text" id="model" name="model" required class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="status" class="form-label">Status</label>
                        <select id="status" name="status" required class="form-control">
                            <option value="">Select Status</option>
                            <option value="Available">Available</option>
                            <option value="In Use">In Use</option>
                            <option value="Repair">Repair</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="buy_on" class="form-label">Buy On</label>
                        <input type="date" id="buy_on" name="buy_on" required class="form-control">
                    </div>
                </div>

                <div class="form-actions">
                    <button type="button" id="cancelBtn" class="btn btn-secondary btn-full btn-cancel">
                        Cancel
                    </button>
                    <button type="submit" class="btn btn-primary btn-full btn-submit">
                        Submit
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // DOM Elements
        const vehicleTableBody = document.getElementById('vehicleTableBody');
        const addVehicleBtn = document.getElementById('addVehicleBtn');
        const vehicleFormModal = document.getElementById('vehicleFormModal');
        const closeModal = document.getElementById('closeModal');
        const cancelBtn = document.getElementById('cancelBtn');
        const vehicleForm = document.getElementById('vehicleForm');
        const modalTitle = document.getElementById('modalTitle');
        const vehicleIdInput = document.getElementById('vehicleId');
        const loadingIndicator = document.getElementById('loadingIndicator');
        const buyOnInput = document.getElementById('buy_on');

        // Hardcoded API URL
        const API_URL = '/MegaCity/vehicles/newvehicle';

        // Loading state counter
        let loadingCount = 0;

        // Fetch vehicles from API
        async function fetchVehicles() {
            showLoading();
            try {
                const response = await fetch(API_URL, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                });
                if (!response.ok) {
                    throw new Error(`Failed to fetch vehicles: ${response.statusText}`);
                }
                const data = await response.json();
                renderVehicleTable(data);
            } catch (error) {
                console.error('Error fetching vehicles:', error);
            } finally {
                hideLoading();
            }
        }

        // Search functionality
        function setupSearch() {
            const searchInput = document.getElementById('searchInput');

            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase().trim();
                const vehicles = document.querySelectorAll('#vehicleTableBody tr:not(.empty-message)');
                let found = false;

                vehicles.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    const match = text.includes(searchTerm);
                    row.style.display = match ? '' : 'none';
                    if (match) found = true;
                });

                let emptyMessage = vehicleTableBody.querySelector('.empty-search-message');
                if (!found && vehicles.length > 0) {
                    if (!emptyMessage) {
                        emptyMessage = document.createElement('tr');
                        emptyMessage.className = 'empty-search-message';
                        emptyMessage.innerHTML = '<td colspan="8" class="empty-message">No matching vehicles found</td>';
                        vehicleTableBody.appendChild(emptyMessage);
                    } else {
                        emptyMessage.style.display = '';
                    }
                } else if (emptyMessage) {
                    emptyMessage.style.display = 'none';
                }
            });
        }

        // Render vehicle table
        function renderVehicleTable(vehicles) {
            vehicleTableBody.innerHTML = '';

            if (!vehicles || vehicles.length === 0) {
                vehicleTableBody.innerHTML = '<tr><td colspan="8" class="empty-message">No vehicles found</td></tr>';
                return;
            }

            vehicles.forEach(vehicle => {
                const row = document.createElement('tr');
                let statusClass = '';
                switch (vehicle.status) {
                    case 'Available': statusClass = 'status-available'; break;
                    case 'In Use': statusClass = 'status-in-use'; break;
                    case 'Repair': statusClass = 'status-repair'; break;
                }

                row.innerHTML = `
                    <td>${vehicle.licensePlate}</td>
                    <td>${vehicle.vehicleCategory}</td>
                    <td>${vehicle.seatCapacity}</td>
                    <td>${vehicle.fuelType}</td>
                    <td>${vehicle.model}</td>
                    <td><span class="status-badge ${statusClass}">${vehicle.status}</span></td>
                    <td>${formatDate(vehicle.buyOn)}</td>
                    <td>
                        <div class="action-buttons">
                            <button class="edit-btn" data-license-plate="${vehicle.licensePlate}">Edit</button>
                            <button class="delete-btn" data-license-plate="${vehicle.licensePlate}">Delete</button>
                        </div>
                    </td>
                `;
                vehicleTableBody.appendChild(row);
            });

            // Add event listeners
            document.querySelectorAll('.edit-btn').forEach(btn => {
                btn.addEventListener('click', () => editVehicle(btn.getAttribute('data-license-plate')));
            });
            document.querySelectorAll('.delete-btn').forEach(btn => {
                btn.addEventListener('click', () => deleteVehicle(btn.getAttribute('data-license-plate')));
            });
        }

        // Format date
        function formatDate(dateString) {
            if (!dateString) return 'N/A';
            return new Date(dateString).toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: 'numeric' });
        }

        // Set max date to today
        function setMaxDateToToday() {
            const today = new Date().toISOString().split('T')[0];
            buyOnInput.setAttribute('max', today);
        }

        // Show add vehicle modal
        function showAddVehicleModal() {
            modalTitle.textContent = 'Add New Vehicle';
            vehicleIdInput.value = '';
            vehicleForm.reset();
            setMaxDateToToday();
            document.getElementById('buy_on').value = new Date().toISOString().split('T')[0];
            vehicleFormModal.style.display = 'block';
        }

        // Edit vehicle
        async function editVehicle(licensePlateNumber) {
            modalTitle.textContent = 'Edit Vehicle';
            vehicleIdInput.value = licensePlateNumber;

            showLoading();
            try {
                const response = await fetch(`${API_URL}/${licensePlateNumber}`, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                });
                const rawText = await response.text();

                if (!response.ok) {
                    if (response.status === 404) {
                        throw new Error(`Vehicle with license plate ${licensePlateNumber} not found`);
                    }
                    else {
                        throw new Error(`Failed to fetch vehicle: ${response.status} - ${response.statusText}`);
                    }
                }

                if (!rawText) {
                    throw new Error('No data returned from server');
                }
                const vehicle = JSON.parse(rawText);
                // Populate form fields
                document.getElementById('license_plate_number').value = vehicle.license_plate_number || '';
                document.getElementById('vehicle_category').value = vehicle.vehicle_category || '';
                document.getElementById('seat_capacity').value = vehicle.seat_capacity || '';
                document.getElementById('fuel_type').value = vehicle.fuel_type || '';
                document.getElementById('model').value = vehicle.model || '';
                document.getElementById('status').value = vehicle.status || '';
                document.getElementById('buy_on').value = vehicle.buy_on ? vehicle.buy_on.split('T')[0] : '';
                setMaxDateToToday();

                if (vehicle.status === "error") {
                    throw new Error(vehicle.message);
                }

                vehicleFormModal.style.display = 'block';
            }
            catch (error) {
                console.error('Error fetching vehicle:', error);
            }
            finally {
                hideLoading();
            }
        }

        // Delete vehicle
        async function deleteVehicle(licensePlateNumber) {
            if (!confirm('Are you sure you want to delete this vehicle?')) return;

            showLoading();
            try {
                const response = await fetch(`${API_URL}/${licensePlateNumber}`, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                });
                const data = await response.json();
                if (response.ok) {
                    fetchVehicles();
                } else {
                    throw new Error(data.message || 'Failed to delete vehicle');
                }
            } catch (error) {
                console.error('Error deleting vehicle:', error);
            } finally {
                hideLoading();
            }
        }

        // Validate form data
        function validateFormData(formData) {
            if (!formData.license_plate_number.trim()) return 'License Plate Number is required.';
            if (!formData.vehicle_category) return 'Vehicle Category is required.';
            if (!formData.seat_capacity || formData.seat_capacity < 1) return 'Seat Capacity must be a positive number.';
            if (!formData.fuel_type) return 'Fuel Type is required.';
            if (!formData.model.trim()) return 'Model is required.';
            if (!formData.status) return 'Status is required.';
            if (!formData.buy_on) return 'Buy On date is required.';
            return null;
        }

        // Handle form submission
        async function handleFormSubmit(event) {
            event.preventDefault();

            const licensePlateNumber = vehicleIdInput.value;
            const isEditing = !!licensePlateNumber;

            const formData = {
                license_plate_number: document.getElementById('license_plate_number').value,
                vehicle_category: document.getElementById('vehicle_category').value,
                seat_capacity: parseInt(document.getElementById('seat_capacity').value),
                fuel_type: document.getElementById('fuel_type').value,
                model: document.getElementById('model').value,
                status: document.getElementById('status').value,
                buy_on: document.getElementById('buy_on').value
            };

            const validationError = validateFormData(formData);
            if (validationError) {
                console.error(validationError);
                return;
            }

            showLoading();
            try {
                const url = isEditing ? `${API_URL}/${licensePlateNumber}` : API_URL;
                const method = isEditing ? 'PUT' : 'POST';
                const response = await fetch(url, {
                    method: method,
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(formData)
                });
                const data = await response.json();

                if (response.ok) {
                    closeVehicleModal();
                    fetchVehicles();
                } else {
                    throw new Error(data.message || 'Failed to save vehicle');
                }
            } catch (error) {
                console.error('Error saving vehicle:', error);
            } finally {
                hideLoading();
            }
        }

        // Close modal
        function closeVehicleModal() {
            vehicleFormModal.style.display = 'none';
            vehicleForm.reset();
        }

        // Show/hide loading
        function showLoading() {
            loadingCount++;
            loadingIndicator.style.display = 'flex';
        }

        function hideLoading() {
            loadingCount--;
            if (loadingCount <= 0) {
                loadingIndicator.style.display = 'none';
                loadingCount = 0;
            }
        }

        // Event Listeners
        addVehicleBtn.addEventListener('click', showAddVehicleModal);
        closeModal.addEventListener('click', closeVehicleModal);
        cancelBtn.addEventListener('click', closeVehicleModal);
        vehicleForm.addEventListener('submit', handleFormSubmit);
        window.addEventListener('click', (event) => {
            if (event.target === vehicleFormModal) closeVehicleModal();
        });
        setMaxDateToToday();

        // Initialize
        fetchVehicles();
        setupSearch();
    });
    </script>
</body>
</html>