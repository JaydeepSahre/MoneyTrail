<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - MoneyTrail</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Sidebar Styling */
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            padding-top: 20px;
            z-index: 1000;
        }

        .sidebar .logo {
            text-align: center;
            padding: 20px 0;
            font-size: 24px;
            font-weight: bold;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 20px;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 15px 20px;
            display: flex;
            align-items: center;
            transition: all 0.3s;
        }

        .sidebar a:hover {
            background: rgba(255, 255, 255, 0.1);
            padding-left: 30px;
        }

        .sidebar a i {
            margin-right: 10px;
            font-size: 18px;
        }

        .sidebar .menu-section {
            padding: 10px 20px;
            font-size: 12px;
            color: rgba(255, 255, 255, 0.6);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 20px;
        }

        /* Main Content Area */
        .main-content {
            margin-left: 250px;
            padding: 30px;
            background: #f8f9fa;
            min-height: 100vh;
        }

        /* Top Navbar */
        .top-navbar {
            background: white;
            padding: 15px 30px;
            margin: -30px -30px 30px -30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-navbar h4 {
            margin: 0;
            color: #333;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        /* Dashboard Cards */
        .dashboard-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .dashboard-card .icon {
            width: 60px;
            height: 60px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 15px;
        }

        .card-income .icon {
            background: #d4edda;
            color: #28a745;
        }

        .card-expense .icon {
            background: #f8d7da;
            color: #dc3545;
        }

        .card-balance .icon {
            background: #d1ecf1;
            color: #17a2b8;
        }

        .card-transactions .icon {
            background: #fff3cd;
            color: #ffc107;
        }

        .dashboard-card h3 {
            font-size: 32px;
            font-weight: bold;
            margin: 10px 0;
        }

        .dashboard-card p {
            color: #6c757d;
            margin: 0;
        }

        /* Welcome Section */
        .welcome-section {
            background: white;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .welcome-section h2 {
            color: #667eea;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="logo">
        <i class="bi bi-cash-coin"></i> MoneyTrail
    </div>

    <a href="dashboard">
        <i class="bi bi-speedometer2"></i>
        Dashboard
    </a>

    <div class="menu-section">Master Data</div>

    <a href="addcategory">
        <i class="bi bi-tag"></i>
        Add Category
    </a>

    <a href="addsubcategory">
        <i class="bi bi-tags"></i>
        Add Sub Category
    </a>

    <a href="addvendor">
        <i class="bi bi-shop"></i>
        Add Vendor
    </a>

    <a href="addaccount">
        <i class="bi bi-wallet2"></i>
        Add Account
    </a>

    <div class="menu-section">Transactions</div>

    <a href="addexpense">
        <i class="bi bi-arrow-down-circle"></i>
        Add Expense
    </a>

    <a href="addincome">
        <i class="bi bi-arrow-up-circle"></i>
        Add Income
    </a>

    <div class="menu-section">Account</div>

    <a href="login">
        <i class="bi bi-box-arrow-right"></i>
        Logout
    </a>
</div>

<!-- Main Content -->
<div class="main-content">

    <!-- Top Navbar -->
    <div class="top-navbar">
        <h4>Dashboard Overview</h4>
        <div class="user-info">
            <span>Welcome, <strong>John Doe</strong></span>
            <img src="https://via.placeholder.com/40" alt="User">
        </div>
    </div>

    <!-- Welcome Section -->
    <div class="welcome-section">
        <h2>Welcome to MoneyTrail! 💰</h2>
        <p>Track your expenses, manage your income, and take control of your finances.</p>
    </div>

    <!-- Dashboard Summary Cards -->
    <div class="row g-4 mb-4">
        
        <!-- Total Income Card -->
        <div class="col-md-3">
            <div class="dashboard-card card-income">
                <div class="icon">
                    <i class="bi bi-arrow-up-circle-fill"></i>
                </div>
                <h3>₹45,000</h3>
                <p>Total Income</p>
            </div>
        </div>

        <!-- Total Expense Card -->
        <div class="col-md-3">
            <div class="dashboard-card card-expense">
                <div class="icon">
                    <i class="bi bi-arrow-down-circle-fill"></i>
                </div>
                <h3>₹28,500</h3>
                <p>Total Expense</p>
            </div>
        </div>

        <!-- Balance Card -->
        <div class="col-md-3">
            <div class="dashboard-card card-balance">
                <div class="icon">
                    <i class="bi bi-wallet-fill"></i>
                </div>
                <h3>₹16,500</h3>
                <p>Current Balance</p>
            </div>
        </div>

        <!-- Transactions Card -->
        <div class="col-md-3">
            <div class="dashboard-card card-transactions">
                <div class="icon">
                    <i class="bi bi-list-check"></i>
                </div>
                <h3>156</h3>
                <p>Total Transactions</p>
            </div>
        </div>

    </div>

    <!-- Recent Transactions Section -->
    <div class="row">
        <div class="col-md-12">
            <div class="dashboard-card">
                <h5 class="mb-3">Recent Transactions</h5>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Title</th>
                            <th>Category</th>
                            <th>Amount</th>
                            <th>Type</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>2026-02-04</td>
                            <td>Grocery Shopping</td>
                            <td>Food</td>
                            <td class="text-danger">-₹2,500</td>
                            <td><span class="badge bg-danger">Expense</span></td>
                            <td><span class="badge bg-success">Paid</span></td>
                        </tr>
                        <tr>
                            <td>2026-02-03</td>
                            <td>Salary Credit</td>
                            <td>-</td>
                            <td class="text-success">+₹45,000</td>
                            <td><span class="badge bg-success">Income</span></td>
                            <td><span class="badge bg-success">Paid</span></td>
                        </tr>
                        <tr>
                            <td>2026-02-02</td>
                            <td>Electricity Bill</td>
                            <td>Utilities</td>
                            <td class="text-danger">-₹1,200</td>
                            <td><span class="badge bg-danger">Expense</span></td>
                            <td><span class="badge bg-warning">Unpaid</span></td>
                        </tr>
                        <tr>
                            <td>2026-02-01</td>
                            <td>Freelance Project</td>
                            <td>-</td>
                            <td class="text-success">+₹12,000</td>
                            <td><span class="badge bg-success">Income</span></td>
                            <td><span class="badge bg-success">Paid</span></td>
                        </tr>
                        <tr>
                            <td>2026-01-31</td>
                            <td>Coffee Shop</td>
                            <td>Food</td>
                            <td class="text-danger">-₹350</td>
                            <td><span class="badge bg-danger">Expense</span></td>
                            <td><span class="badge bg-success">Paid</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
