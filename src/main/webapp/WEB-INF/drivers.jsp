<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Management System</title>
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

        .btn-icon {
            margin-right: 0.5rem;
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

        .status-active {
            background-color: #dcfce7;
            color: #166534;
        }

        .status-on-leave {
            background-color: #fefcbf;
            color: #92400e;
        }

        .status-half-day {
            background-color: #fecaca;
            color: #991b1b;
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
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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

            #addDriverBtn {
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
            <h1 class="card-title">Driver Details</h1>
            <div class="search-container">
                <input type="text" id="searchInput" placeholder="Search drivers..." class="form-control" style="max-width: 250px;">
            </div>
            <div class="header-actions">
                <button id="addDriverBtn" class="btn btn-primary">
                    <i class="fas fa-plus btn-icon"></i> Add Driver
                </button>
            </div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Driver ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>NIC Number</th>
                        <th>License Number</th>
                        <th>Phone Number</th>
                        <th>Email</th>
                        <th>Gender</th>
                        <th>Date of Birth</th>
                        <th>Address</th>
                        <th>Appointment Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="driverTableBody">
                    <!-- Driver data will be populated here -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Driver Form Modal -->
    <div id="driverFormModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle" class="modal-title">Add New Driver</h2>
                <button id="closeModal" class="modal-close">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <form id="driverForm">
                <input type="hidden" id="driverId" value="">

                <div class="form-grid">
                    <div class="form-group">
                        <label for="first_name" class="form-label">First Name</label>
                        <input type="text" id="first_name" name="first_name" required class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="last_name" class="form-label">Last Name</label>
                        <input type="text" id="last_name" name="last_name" required class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="nic_number" class="form-label">NIC Number</label>
                        <input type="text" id="nic_number" name="nic_number" required class="form-control" maxlength="12">
                    </div>

                    <div class="form-group">
                        <label for="license_number" class="form-label">License Number</label>
                        <input type="text" id="license_number" name="license_number" required class="form-control" maxlength="15">
                    </div>

                    <div class="form-group">
                        <label for="phone_number" class="form-label">Phone Number</label>
                        <input type="tel" id="phone_number" name="phone_number" required class="form-control" maxlength="10">
                    </div>

                    <div class="form-group">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" id="email" name="email" required class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="gender" class="form-label">Gender</label>
                        <select id="gender" name="gender" required class="form-control">
                            <option value="">Select Gender</option>
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="date_of_birth" class="form-label">Date of Birth</label>
                        <input type="date" id="date_of_birth" name="date_of_birth" required class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="address" class="form-label">Address</label>
                        <textarea id="address" name="address" required class="form-control" rows="3"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="appointment_date" class="form-label">Appointment Date</label>
                        <input type="datetime-local" id="appointment_date" name="appointment_date" required class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="current_status" class="form-label">Status</label>
                        <select id="current_status" name="current_status" required class="form-control">
                            <option value="">Select Status</option>
                            <option value="Active">Active</option>
                            <option value="On Leave">On Leave</option>
                            <option value="half day">Half Day</option>
                        </select>
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
        const driverTableBody = document.getElementById('driverTableBody');
        const addDriverBtn = document.getElementById('addDriverBtn');
        const driverFormModal = document.getElementById('driverFormModal');
        const closeModal = document.getElementById('closeModal');
        const cancelBtn = document.getElementById('cancelBtn');
        const driverForm = document.getElementById('driverForm');
        const modalTitle = document.getElementById('modalTitle');
        const driverIdInput = document.getElementById('driverId');
        const loadingIndicator = document.getElementById('loadingIndicator');
        const dateOfBirthInput = document.getElementById('date_of_birth');
        const appointmentDateInput = document.getElementById('appointment_date');

        // Hardcoded API URL
        const ACTIVE_DRIVERS_API_URL = '/MegaCity/drivers/activedrivers';

        // Loading state counter
        let loadingCount = 0;

        // Fetch active drivers from API
        async function fetchActiveDrivers() {
            showLoading();
            try {
                const response = await fetch(ACTIVE_DRIVERS_API_URL, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                });
                if (!response.ok) {
                    throw new Error(`Failed to fetch drivers: ${response.statusText}`);
                }
                const data = await response.json();
                renderDriverTable(data);
            } catch (error) {
                console.error('Error fetching drivers:', error);
            } finally {
                hideLoading();
            }
        }

        // Search functionality
        function setupSearch() {
            const searchInput = document.getElementById('searchInput');

            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase().trim();
                const drivers = document.querySelectorAll('#driverTableBody tr:not(.empty-message)');
                let found = false;

                drivers.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    const match = text.includes(searchTerm);
                    row.style.display = match ? '' : 'none';
                    if (match) found = true;
                });

                let emptyMessage = driverTableBody.querySelector('.empty-search-message');
                if (!found && drivers.length > 0) {
                    if (!emptyMessage) {
                        emptyMessage = document.createElement('tr');
                        emptyMessage.className = 'empty-search-message';
                        emptyMessage.innerHTML = '<td colspan="13" class="empty-message">No matching drivers found</td>';
                        driverTableBody.appendChild(emptyMessage);
                    } else {
                        emptyMessage.style.display = '';
                    }
                } else if (emptyMessage) {
                    emptyMessage.style.display = 'none';
                }
            });
        }

        // Render driver table
        function renderDriverTable(drivers) {
            driverTableBody.innerHTML = '';

            if (!drivers || drivers.length === 0) {
                driverTableBody.innerHTML = '<tr><td colspan="13" class="empty-message">No drivers found</td></tr>';
                return;
            }

            drivers.forEach(driver => {
                const row = document.createElement('tr');
                let statusClass;
                switch (driver.currentStatus) {
                    case 'Active': statusClass = 'status-active'; break;
                    case 'On Leave': statusClass = 'status-on-leave'; break;
                    case 'half day': statusClass = 'status-half-day'; break;
                    default: statusClass = 'status-half-day';
                }

                row.innerHTML = `
                    <td>${driver.driverId}</td>
                    <td>${driver.firstName}</td>
                    <td>${driver.lastName}</td>
                    <td>${driver.nicNumber}</td>
                    <td>${driver.licenseNumber}</td>
                    <td>${driver.phoneNumber}</td>
                    <td>${driver.email}</td>
                    <td>${driver.gender}</td>
                    <td>${formatDate(driver.dateOfBirth)}</td>
                    <td>${driver.address}</td>
                    <td>${formatDateTime(driver.appointmentDate)}</td>
                    <td><span class="status-badge ${statusClass}">${driver.currentStatus}</span></td>
                    <td>
                        <div class="action-buttons">
                            <button class="edit-btn" data-driver-id="${driver.driverId}">Edit</button>
                            <button class="delete-btn" data-driver-id="${driver.driverId}">Delete</button>
                        </div>
                    </td>
                `;
                driverTableBody.appendChild(row);
            });

            // Add event listeners
            document.querySelectorAll('.edit-btn').forEach(btn => {
                btn.addEventListener('click', () => editDriver(btn.getAttribute('data-driver-id')));
            });
            document.querySelectorAll('.delete-btn').forEach(btn => {
                btn.addEventListener('click', () => deleteDriver(btn.getAttribute('data-driver-id')));
            });
        }

        // Format date
        function formatDate(dateString) {
            if (!dateString) return 'N/A';
            return new Date(dateString).toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: 'numeric' });
        }

        // Format datetime
        function formatDateTime(dateTimeString) {
            if (!dateTimeString) return 'N/A';
            return new Date(dateTimeString).toLocaleString(undefined, {
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
        }

        // Set max dates
        function setMaxDates() {
            const today = new Date().toISOString().split('T')[0];
            dateOfBirthInput.setAttribute('max', today);
            appointmentDateInput.setAttribute('max', new Date().toISOString().slice(0, 16));
        }

        // Show add driver modal
        function showAddDriverModal() {
            modalTitle.textContent = 'Add New Driver';
            driverIdInput.value = '';
            driverForm.reset();
            setMaxDates();
            appointmentDateInput.value = new Date().toISOString().slice(0, 16);
            driverFormModal.style.display = 'block';
        }

        // Edit driver
        async function editDriver(driverId) {
            modalTitle.textContent = 'Edit Driver';
            driverIdInput.value = driverId;

            showLoading();
            try {
                const response = await fetch(`${ACTIVE_DRIVERS_API_URL}/${driverId}`, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                });
                const rawText = await response.text();

                if (!response.ok) {
                    if (response.status === 404) {
                        throw new Error(`Driver with ID ${driverId} not found`);
                    }
                    throw new Error(`Failed to fetch driver: ${response.status} - ${response.statusText}`);
                }

                if (!rawText) {
                    throw new Error('No data returned from server');
                }
                const driver = JSON.parse(rawText);

                document.getElementById('first_name').value = driver.firstName || '';
                document.getElementById('last_name').value = driver.lastName || '';
                document.getElementById('nic_number').value = driver.nicNumber || '';
                document.getElementById('license_number').value = driver.licenseNumber || '';
                document.getElementById('phone_number').value = driver.phoneNumber || '';
                document.getElementById('email').value = driver.email || '';
                document.getElementById('gender').value = driver.gender || '';
                document.getElementById('date_of_birth').value = driver.dateOfBirth ? driver.dateOfBirth.split('T')[0] : '';
                document.getElementById('address').value = driver.address || '';
                document.getElementById('appointment_date').value = driver.appointmentDate ? driver.appointmentDate.slice(0, 16) : '';
                document.getElementById('current_status').value = driver.currentStatus || '';
                setMaxDates();

                driverFormModal.style.display = 'block';
            } catch (error) {
                console.error('Error fetching driver:', error);
            } finally {
                hideLoading();
            }
        }

        // Delete driver
        async function deleteDriver(driverId) {
            if (!confirm('Are you sure you want to delete this driver?')) return;

            showLoading();
            try {
                const response = await fetch(`${ACTIVE_DRIVERS_API_URL}/${driverId}`, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                });
                const data = await response.json();
                if (response.ok) {
                    fetchActiveDrivers();
                } else {
                    throw new Error(data.message || 'Failed to delete driver');
                }
            } catch (error) {
                console.error('Error deleting driver:', error);
            } finally {
                hideLoading();
            }
        }

        // Validate form data
        function validateFormData(formData) {
            if (!formData.first_name.trim()) return 'First Name is required.';
            if (!formData.last_name.trim()) return 'Last Name is required.';
            if (!formData.nic_number.trim() || formData.nic_number.length > 12) return 'Valid NIC Number is required (max 12 characters).';
            if (!formData.license_number.trim() || formData.license_number.length > 15) return 'Valid License Number is required (max 15 characters).';
            if (!formData.phone_number.trim() || !/^\d{10}$/.test(formData.phone_number)) return 'Valid 10-digit Phone Number is required.';
            if (!formData.email.trim() || !/\S+@\S+\.\S+/.test(formData.email)) return 'Valid Email is required.';
            if (!formData.gender) return 'Gender is required.';
            if (!formData.date_of_birth) return 'Date of Birth is required.';
            if (!formData.address.trim()) return 'Address is required.';
            if (!formData.appointment_date) return 'Appointment Date is required.';
            if (!formData.current_status) return 'Status is required.';
            return null;
        }

        // Handle form submission
        async function handleFormSubmit(event) {
            event.preventDefault();

            const driverId = driverIdInput.value;
            const isEditing = !!driverId;

            const formData = {
                driver_id: driverId || undefined,
                first_name: document.getElementById('first_name').value,
                last_name: document.getElementById('last_name').value,
                nic_number: document.getElementById('nic_number').value,
                license_number: document.getElementById('license_number').value,
                phone_number: document.getElementById('phone_number').value,
                email: document.getElementById('email').value,
                gender: document.getElementById('gender').value,
                date_of_birth: document.getElementById('date_of_birth').value,
                address: document.getElementById('address').value,
                appointment_date: document.getElementById('appointment_date').value,
                current_status: document.getElementById('current_status').value
            };

            const validationError = validateFormData(formData);
            if (validationError) {
                console.error(validationError);
                return;
            }

            showLoading();
            try {
                const url = isEditing ? `${ACTIVE_DRIVERS_API_URL}/${driverId}` : ACTIVE_DRIVERS_API_URL;
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
                    closeDriverModal();
                    fetchActiveDrivers();
                } else {
                    throw new Error(data.message || 'Failed to save driver');
                }
            } catch (error) {
                console.error('Error saving driver:', error);
            } finally {
                hideLoading();
            }
        }

        // Close modal
        function closeDriverModal() {
            driverFormModal.style.display = 'none';
            driverForm.reset();
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
        addDriverBtn.addEventListener('click', showAddDriverModal);
        closeModal.addEventListener('click', closeDriverModal);
        cancelBtn.addEventListener('click', closeDriverModal);
        driverForm.addEventListener('submit', handleFormSubmit);
        window.addEventListener('click', (event) => {
            if (event.target === driverFormModal) closeDriverModal();
        });
        setMaxDates();

        // Initialize
        fetchActiveDrivers();
        setupSearch();
    });
    </script>
</body>
</html>