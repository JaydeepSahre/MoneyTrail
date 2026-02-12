<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Vendor List - MoneyTrail</title>

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
                    <i class="bi bi-shop-window"></i> Vendor Management
                </h2>
                <p class="mb-0 opacity-75">Manage all your vendors and merchants</p>
            </div>
            <div>
                <a href="addvendor" class="btn btn-light btn-lg">
                    <i class="bi bi-plus-circle"></i> Add New Vendor
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
                        <h6 class="text-muted mb-2">Total Vendors</h6>
                        <div class="number">
                            <c:choose>
                                <c:when test="${not empty vendorList}">
                                    ${vendorList.size()}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="icon-wrapper">
                        <i class="bi bi-shop" style="font-size: 40px; color: #667eea;"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Vendor Table -->
    <div class="category-table">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="mb-0">
                <i class="bi bi-list-ul"></i> All Vendors
            </h5>
            <div>
                <input type="text" class="form-control" placeholder="Search vendors..." 
                       id="searchInput" style="width: 250px;">
            </div>
        </div>

        <c:if test="${empty vendorList}">
            <div class="empty-state">
                <i class="bi bi-inbox"></i>
                <h4 class="text-muted">No Vendors Found</h4>
                <p class="text-muted">Start by adding your first vendor</p>
                <a href="addvendor" class="btn btn-primary btn-lg mt-3">
                    <i class="bi bi-plus-circle"></i> Add First Vendor
                </a>
            </div>
        </c:if>

        <c:if test="${not empty vendorList}">
            <div class="table-responsive">
                <table class="table table-hover" id="vendorTable">
                    <thead>
                        <tr>
                            <th style="width: 80px;">#</th>
                            <th>Vendor Name</th>
                            <th style="width: 200px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="vendor" items="${vendorList}" varStatus="i">
                            <tr>
                                <td>
                                    <span class="badge bg-primary">${i.index + 1}</span>
                                </td>
                                <td>
                                    <i class="bi bi-shop text-warning"></i>
                                    <strong>${vendor.vendorName}</strong>
                                </td>
                                <td>
                                    <a href="editVendor?id=${vendor.vendorId}" 
                                       class="btn btn-sm btn-warning btn-action">
                                        <i class="bi bi-pencil-fill"></i> Edit
                                    </a>
                                    <a href="deletevendor?vendorId=${vendor.vendorId}"
                                       class="btn btn-sm btn-danger btn-action"
                                       onclick="return confirm('Are you sure you want to delete this vendor?')">
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
        const table = document.getElementById('vendorTable');
        const rows = table?.getElementsByTagName('tr');
        
        if (rows) {
            for (let i = 1; i < rows.length; i++) {
                const vendorName = rows[i].getElementsByTagName('td')[1];
                if (vendorName) {
                    const textValue = vendorName.textContent || vendorName.innerText;
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
