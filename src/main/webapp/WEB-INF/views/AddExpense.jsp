<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Expense - MoneyTrail</title>

    <jsp:include page="AdminCSS.jsp" />

    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }

        .form-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            max-width: 700px;
            margin: 0 auto;
        }

        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            color: #667eea;
            font-weight: bold;
            margin-top: 20px;
            margin-bottom: 15px;
            padding-bottom: 5px;
            border-bottom: 2px solid #667eea;
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
            <i class="bi bi-arrow-down-circle"></i>
            <h3>Add Expense</h3>
            <p class="mb-0">Record a new expense transaction</p>
        </div>

        <!-- Form Body -->
        <div class="p-4">
            <form action="saveexpense" method="post">

                <!-- Basic Information -->
                <h5 class="section-title">
                    <i class="bi bi-info-circle"></i> Basic Information
                </h5>

                <!-- Expense Title -->
                <div class="mb-3">
                    <label class="form-label">
                        <i class="bi bi-pencil text-primary"></i> Expense Title *
                    </label>
                    <input type="text" name="title" class="form-control" 
                           placeholder="Enter expense title (e.g., Grocery Shopping, Electricity Bill)" 
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

                <!-- Category Information -->
                <h5 class="section-title">
                    <i class="bi bi-tag"></i> Category Information
                </h5>

                <!-- Category and SubCategory Row -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="bi bi-tag text-primary"></i> Category *
                        </label>
                        <select name="categoryId" class="form-select" required>
                            <option value="" selected disabled>-- Select Category --</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.categoryId}">${category.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="bi bi-tags text-success"></i> Sub Category *
                        </label>
                        <select name="subCategoryId" class="form-select" required>
                            <option value="" selected disabled>-- Select Sub Category --</option>
                            <c:forEach var="subCategory" items="${subCategories}">
                                <option value="${subCategory.subCategoryId}">${subCategory.subCategoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Payment Information -->
                <h5 class="section-title">
                    <i class="bi bi-wallet2"></i> Payment Information 
                </h5>

                <!-- Vendor and Account Row -->
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="bi bi-shop text-warning"></i> Vendor *
                        </label>
                        <select name="vendorId" class="form-select" required>
                            <option value="" selected disabled>-- Select Vendor --</option>
                            <c:forEach var="vendor" items="${vendors}">
                                <option value="${vendor.vendorId}">${vendor.vendorName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="bi bi-credit-card text-info"></i> Account *
                        </label>
                        <select name="accountId" class="form-select" required>
                            <option value="" selected disabled>-- Select Account --</option>
                            <c:forEach var="account" items="${accounts}">
                                <option value="${account.accountId}">${account.title} - ₹${account.amount}</option>
                            </c:forEach>
						</select>
                    </div>
                </div>

                <!-- Status -->
                <div class="mb-3">
                    <label class="form-label">
                        <i class="bi bi-check-circle text-success"></i> Payment Status *
                    </label>
                    <select name="statusId" class="form-select" required>
                        <option value="" selected disabled>-- Select Status --</option>
                        <c:forEach var="status" items="${statuses}">
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
                              placeholder="Additional details about the expense (optional)"></textarea>
                </div>

                <!-- Buttons -->
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="bi bi-check-circle"></i> Add Expense
                    </button>
                    <a href="dashboard" class="btn btn-outline-secondary">
                        <i class="bi bi-x-circle"></i> Cancel
                    </a>
                </div>

            </form>
        </div>

    </div>
</div>

<jsp:include page="AdminFooter.jsp" />

</body>
</html>