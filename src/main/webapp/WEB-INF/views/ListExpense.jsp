<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Expense List - MoneyTrail</title>

    <jsp:include page="AdminCSS.jsp" />
    
    <style>
        .page-header {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .stats-card .number {
            font-size: 36px;
            font-weight: bold;
            color: #dc3545;
        }
        
        .category-table {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .table thead th {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            border: none;
            padding: 15px;
            font-weight: 600;
        }
        
        .table tbody tr {
            transition: all 0.3s;
        }
        
        .table tbody tr:hover {
            background-color: #fff5f5;
            transform: scale(1.01);
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }
        
        .empty-state i {
            font-size: 80px;
            color: #ddd;
            margin-bottom: 20px;
        }
        
        .btn-action {
            margin: 0 3px;
        }
        
        .amount-text {
            font-weight: bold;
            color: #dc3545;
            font-size: 16px;
        }
        
        .badge-custom {
            font-size: 11px;
            padding: 4px 8px;
        }
    </style>
</head>

<body>

<jsp:include page="AdminHeader.jsp" />

<jsp:include page="AdminSidebar.jsp" />

<div class="main-content">

    <!-- Page Header -->
    <div class="page-header">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h2 class="mb-2">
                    <i class="bi bi-arrow-down-circle-fill"></i> Expense Management
                </h2>
                <p class="mb-0 opacity-75">Track and manage all your expenses</p>
            </div>
            <div>
                <a href="addexpense" class="btn btn-light btn-lg">
                    <i class="bi bi-plus-circle"></i> Add New Expense
                </a>
            </div>
        </div>
    </div>

    <!-- Stats Card -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="stats-card">
                <div class="d-flex align-items-center">
                    <div class="flex-grow-1">
                        <h6 class="text-muted mb-2">Total Expenses</h6>
                        <div class="number">
                            <c:choose>
                                <c:when test="${not empty expenseList}">
                                    ${expenseList.size()}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="icon-wrapper">
                        <i class="bi bi-arrow-down-circle" style="font-size: 40px; color: #dc3545;"></i>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="stats-card">
                <div class="d-flex align-items-center">
                    <div class="flex-grow-1">
                        <h6 class="text-muted mb-2">Total Amount</h6>
                        <div class="number">
                            ₹<c:choose>
                                <c:when test="${not empty expenseList}">
                                    <c:set var="total" value="0" />
                                    <c:forEach var="exp" items="${expenseList}">
                                        <c:set var="total" value="${total + exp.amount}" />
                                    </c:forEach>
                                    ${total}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="icon-wrapper">
                        <i class="bi bi-cash-stack" style="font-size: 40px; color: #dc3545;"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Expense Table -->
    <div class="category-table">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="mb-0">
                <i class="bi bi-list-ul"></i> All Expenses
            </h5>
            <div>
                <input type="text" class="form-control" placeholder="Search expenses..." 
                       id="searchInput" style="width: 250px;">
            </div>
        </div>

        <c:if test="${empty expenseList}">
            <div class="empty-state">
                <i class="bi bi-inbox"></i>
                <h4 class="text-muted">No Expenses Found</h4>
                <p class="text-muted">Start by recording your first expense</p>
                <a href="addexpense" class="btn btn-danger btn-lg mt-3">
                    <i class="bi bi-plus-circle"></i> Add First Expense
                </a>
            </div>
        </c:if>

        <c:if test="${not empty expenseList}">
            <div class="table-responsive">
                <table class="table table-hover" id="expenseTable">
                    <thead>
                        <tr>
                            <th style="width: 60px;">#</th>
                            <th>Title</th>
                            <th>Amount</th>
                            <th>Date</th>
                            <th>Category</th>
                            <th>Vendor</th>
                            <th>Account</th>
                            <th style="width: 180px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="expense" items="${expenseList}" varStatus="i">
                            <tr>
                                <td>
                                    <span class="badge bg-danger">${i.index + 1}</span>
                                </td>
                                <td>
                                    <i class="bi bi-receipt text-danger"></i>
                                    <strong>${expense.title}</strong>
                                </td>
                                <td>
                                    <span class="amount-text">-₹${expense.amount}</span>
                                </td>
                                <td>${expense.date}</td>
                                <td>
                                    <c:forEach var="cat" items="${categories}">
                                        <c:if test="${expense.categoryId == cat.categoryId}">
                                            <span class="badge bg-primary badge-custom">
                                                ${cat.categoryName}
                                            </span>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:forEach var="ven" items="${vendors}">
                                        <c:if test="${expense.vendorId == ven.vendorId}">
                                            <span class="badge bg-secondary badge-custom">
                                                ${ven.vendorName}
                                            </span>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:forEach var="acc" items="${accounts}">
                                        <c:if test="${expense.accountId == acc.accountId}">
                                            <span class="badge bg-info badge-custom">
                                                ${acc.title}
                                            </span>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <a href="editExpense?id=${expense.expenseId}" 
                                       class="btn btn-sm btn-warning btn-action">
                                        <i class="bi bi-pencil-fill"></i> Edit
                                    </a>
                                    <a href="deleteexpense?expenseId=${expense.expenseId}"
                                       class="btn btn-sm btn-danger btn-action"
                                       onclick="return confirm('Are you sure you want to delete this expense?')">
                                        <i class="bi bi-trash-fill"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

    </div>

</div>

<jsp:include page="AdminFooter.jsp" />

<script>
    // Search functionality
    document.getElementById('searchInput')?.addEventListener('keyup', function() {
        const searchValue = this.value.toLowerCase();
        const table = document.getElementById('expenseTable');
        const rows = table?.getElementsByTagName('tr');
        
        if (rows) {
            for (let i = 1; i < rows.length; i++) {
                const title = rows[i].getElementsByTagName('td')[1];
                if (title) {
                    const textValue = title.textContent || title.innerText;
                    if (textValue.toLowerCase().indexOf(searchValue) > -1) {
                        rows[i].style.display = '';
                    } else {
                        rows[i].style.display = 'none';
                    }
                }
            }
        }
    });
</script>

</body>
</html>