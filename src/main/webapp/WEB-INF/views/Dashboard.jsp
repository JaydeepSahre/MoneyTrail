<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - MoneyTrail</title>

    <jsp:include page="AdminCSS.jsp" />
</head>

<body>

<jsp:include page="AdminHeader.jsp" />

<jsp:include page="AdminSidebar.jsp" />

<!-- ================= MAIN CONTENT ================= -->
<div class="main-content">

    <div class="mb-4">
        <h2 class="text-primary">Welcome to MoneyTrail</h2>
        <p class="text-muted">Track income, manage expenses, and stay financially disciplined.</p>
    </div>

    <!-- Cards -->
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="dashboard-card card-income">
                <div class="icon"><i class="bi bi-arrow-up-circle-fill"></i></div>
                <h3>₹45,000</h3>
                <p>Total Income</p>
            </div>
        </div>

        <div class="col-md-3">
            <div class="dashboard-card card-expense">
                <div class="icon"><i class="bi bi-arrow-down-circle-fill"></i></div>
                <h3>₹28,500</h3>
                <p>Total Expense</p>
            </div>
        </div>

        <div class="col-md-3">
            <div class="dashboard-card card-balance">
                <div class="icon"><i class="bi bi-wallet-fill"></i></div>
                <h3>₹16,500</h3>
                <p>Current Balance</p>
            </div>
        </div>

        <div class="col-md-3">
            <div class="dashboard-card card-transactions">
                <div class="icon"><i class="bi bi-list-check"></i></div>
                <h3>156</h3>
                <p>Total Transactions</p>
            </div>
        </div>
    </div>
</div>

	<jsp:include page="AdminFooter.jsp" />
</body>
</html>
