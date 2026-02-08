<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Income - MoneyTrail</title>

    <jsp:include page="AdminCSS.jsp" />

    <style>
        body {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            min-height: 100vh;
        }

        .form-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            width: 100%;
            margin: 0 auto;
        }

        .form-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 20px;
            border-radius: 15px 15px 0 0;
            text-align: center;
        }

        .form-header i {
            font-size: 40px;
            margin-bottom: 10px;
        }

        .section-title {
            color: #28a745;
            font-weight: bold;
            margin-top: 20px;
            margin-bottom: 15px;
            padding-bottom: 5px;
            border-bottom: 2px solid #28a745;
        }
    </style>
</head>

<body>

<jsp:include page="AdminHeader.jsp" />

<jsp:include page="AdminSidebar.jsp" />

<div class="main-content">
    <div class="form-card">
        
        <!-- Form Header -->
        <div class="form-header">
            <i class="bi bi-arrow-up-circle"></i>
            <h3>Add Income</h3>
            <p class="mb-0">Record a new income transaction</p>
        </div>

        <!-- Form Body -->
        <div class="p-4">
            <form action="saveincome" method="post">

                <!-- Basic Information -->
                <h5 class="section-title">
                    <i class="bi bi-info-circle"></i> Basic Information
                </h5>

                <!-- Income Title -->
                <div class="mb-3">
                    <label class="form-label">
                        <i class="bi bi-pencil text-primary"></i> Income Title *
                    </label>
                    <input type="text" name="title" class="form-control" 
                           placeholder="Enter income title (e.g., Salary, Freelance Project, Bonus)" 
                           required>
                </div>

                <!-- Amount and Date Row -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="bi bi-currency-rupee text-success"></i> Amount *
                        </label>
                        <input type="number" name="amount" class="form-control" 
                               placeholder="Enter amount" 
                               step="0.01" min="0" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="bi bi-calendar text-info"></i> Date *
                        </label>
                        <input type="date" name="date" class="form-control" required>
                    </div>
                </div>

                <!-- Payment Information -->
                <h5 class="section-title">
                    <i class="bi bi-wallet2"></i> Payment Information
                </h5>

                <!-- Account -->
                <div class="mb-3">
                    <label class="form-label">
                        <i class="bi bi-credit-card text-info"></i> Account *
                    </label>
                    <select name="accountId" class="form-select" required>
                        <option value="" selected disabled>-- Select Account --</option>
                        <c:forEach items="${accounts}" var="account">
                            <option value="${account.accountId}">
                                ${account.title} - ₹${account.amount}
                            </option>
                        </c:forEach>
                    </select>
                    <small class="text-muted">Select the account where income will be credited</small>
                </div>

                <!-- Status -->
                <div class="mb-3">
                    <label class="form-label">
                        <i class="bi bi-check-circle text-success"></i> Payment Status *
                    </label>
                    <select name="statusId" class="form-select" required>
                        <option value="" selected disabled>-- Select Status --</option>
                        <c:forEach items="${statuses}" var="status">
                            <option value="${status.statusId}">${status.status}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Description -->
                <div class="mb-4">
                    <label class="form-label">
                        <i class="bi bi-card-text text-secondary"></i> Description
                    </label>
                    <textarea name="description" class="form-control" rows="3" 
                              placeholder="Add any additional notes or details (optional)"></textarea>
                </div>

                <!-- Buttons -->
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-success btn-lg">
                        <i class="bi bi-check-circle"></i> Add Income
                    </button>
                    <a href="listincome" class="btn btn-outline-secondary">
                        View All Incomes
                    </a>
                </div>

            </form>
        </div>

    </div>
</div>

<jsp:include page="AdminFooter.jsp" />

</body>
</html>
