<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Account List - MoneyTrail</title>

    <jsp:include page="AdminCSS.jsp" />
    
    <style>
        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            color: #667eea;
        }
        
        .category-table {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .table thead th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 15px;
            font-weight: 600;
        }
        
        .table tbody tr {
            transition: all 0.3s;
        }
        
        .table tbody tr:hover {
            background-color: #f8f9ff;
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
            color: #28a745;
            font-size: 16px;
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
                    <i class="bi bi-wallet2-fill"></i> Account Management
                </h2>
                <p class="mb-0 opacity-75">Manage all your payment accounts</p>
            </div>
            <div>
                <a href="addaccount" class="btn btn-light btn-lg">
                    <i class="bi bi-plus-circle"></i> Add New Account
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
                        <h6 class="text-muted mb-2">Total Accounts</h6>
                        <div class="number">
                            <c:choose>
                                <c:when test="${not empty accountList}">
                                    ${accountList.size()}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="icon-wrapper">
                        <i class="bi bi-wallet2" style="font-size: 40px; color: #667eea;"></i>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="stats-card">
                <div class="d-flex align-items-center">
                    <div class="flex-grow-1">
                        <h6 class="text-muted mb-2">Total Balance</h6>
                        <div class="number" style="color: #28a745;">
                            ₹<c:choose>
                                <c:when test="${not empty accountList}">
                                    <c:set var="total" value="0" />
                                    <c:forEach var="acc" items="${accountList}">
                                        <c:set var="total" value="${total + acc.amount}" />
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
                        <i class="bi bi-cash-stack" style="font-size: 40px; color: #28a745;"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Account Table -->
    <div class="category-table">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="mb-0">
                <i class="bi bi-list-ul"></i> All Accounts
            </h5>
            <div>
                <input type="text" class="form-control" placeholder="Search accounts..." 
                       id="searchInput" style="width: 250px;">
            </div>
        </div>

        <c:if test="${empty accountList}">
            <div class="empty-state">
                <i class="bi bi-inbox"></i>
                <h4 class="text-muted">No Accounts Found</h4>
                <p class="text-muted">Start by adding your first payment account</p>
                <a href="addaccount" class="btn btn-primary btn-lg mt-3">
                    <i class="bi bi-plus-circle"></i> Add First Account
                </a>
            </div>
        </c:if>

        <c:if test="${not empty accountList}">
            <div class="table-responsive">
                <table class="table table-hover" id="accountTable">
                    <thead>
                        <tr>
                            <th style="width: 80px;">#</th>
                            <th>Account Name</th>
                            <th>Balance</th>
                            <th>Default</th>
                            <th style="width: 200px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="account" items="${accountList}" varStatus="i">
                            <tr>
                                <td>
                                    <span class="badge bg-primary">${i.index + 1}</span>
                                </td>
                                <td>
                                    <i class="bi bi-credit-card text-info"></i>
                                    <strong>${account.title}</strong>
                                </td>
                                <td>
                                    <span class="amount-text">₹${account.amount}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${account.exDefault == true}">
                                            <span class="badge bg-success">
                                                <i class="bi bi-check-circle"></i> Yes
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">
                                                <i class="bi bi-x-circle"></i> No
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="editAccount?id=${account.accountId}" 
                                       class="btn btn-sm btn-warning btn-action">
                                        <i class="bi bi-pencil-fill"></i> Edit
                                    </a>
                                    <a href="deleteAccount?id=${account.accountId}"
                                       class="btn btn-sm btn-danger btn-action"
                                       onclick="return confirm('Are you sure you want to delete this account?')">
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
        const table = document.getElementById('accountTable');
        const rows = table?.getElementsByTagName('tr');
        
        if (rows) {
            for (let i = 1; i < rows.length; i++) {
                const accountName = rows[i].getElementsByTagName('td')[1];
                if (accountName) {
                    const textValue = accountName.textContent || accountName.innerText;
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
