<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List - MoneyTrail</title>

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
        
        .user-table {
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
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        
        .badge-custom {
            font-size: 11px;
            padding: 5px 10px;
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
                    <i class="bi bi-people-fill"></i> User Management
                </h2>
                <p class="mb-0 opacity-75">Manage all registered users</p>
            </div>
            <div>
                <a href="adduser" class="btn btn-light btn-lg">
                    <i class="bi bi-plus-circle"></i> Add New User
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
                        <h6 class="text-muted mb-2">Total Users</h6>
                        <div class="number">
                            <c:choose>
                                <c:when test="${not empty userList}">
                                    ${userList.size()}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="icon-wrapper">
                        <i class="bi bi-people" style="font-size: 40px; color: #667eea;"></i>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="stats-card">
                <div class="d-flex align-items-center">
                    <div class="flex-grow-1">
                        <h6 class="text-muted mb-2">Active Users</h6>
                        <div class="number">
                            <c:set var="activeCount" value="0" />
                            <c:forEach var="user" items="${userList}">
                                <c:if test="${user.active}">
                                    <c:set var="activeCount" value="${activeCount + 1}" />
                                </c:if>
                            </c:forEach>
                            ${activeCount}
                        </div>
                    </div>
                    <div class="icon-wrapper">
                        <i class="bi bi-person-check" style="font-size: 40px; color: #28a745;"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- User Table -->
    <div class="user-table">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="mb-0">
                <i class="bi bi-list-ul"></i> All Users
            </h5>
            <div>
                <input type="text" class="form-control" placeholder="Search users..." 
                       id="searchInput" style="width: 250px;">
            </div>
        </div>

        <c:if test="${empty userList}">
            <div class="empty-state">
                <i class="bi bi-inbox"></i>
                <h4 class="text-muted">No Users Found</h4>
                <p class="text-muted">Start by adding your first user</p>
                <a href="adduser" class="btn btn-primary btn-lg mt-3">
                    <i class="bi bi-plus-circle"></i> Add First User
                </a>
            </div>
        </c:if>

        <c:if test="${not empty userList}">
            <div class="table-responsive">
                <table class="table table-hover" id="userTable">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Contact</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Joined</th>
                            <th style="width: 140px; text-align: center;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${userList}" varStatus="i">
                            <tr>
                                <td>
                                    <span class="badge bg-primary">${i.index + 1}</span>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <c:choose>
                                            <c:when test="${not empty user.profilePicURL}">
                                                <img src="${user.profilePicURL}" class="user-avatar me-2" alt="Profile">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="user-avatar me-2 bg-secondary d-flex align-items-center justify-content-center text-white">
                                                    ${user.firstName.substring(0,1)}${user.lastName.substring(0,1)}
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div>
                                            <strong>${user.firstName} ${user.lastName}</strong>
                                            <br>
                                            <small class="text-muted">
                                                <c:if test="${not empty user.gender}">
                                                    <i class="bi bi-gender-${user.gender.toLowerCase()}"></i> ${user.gender}
                                                </c:if>
                                            </small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <i class="bi bi-envelope text-primary"></i>
                                    ${user.email}
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty user.contactNum}">
                                            <i class="bi bi-telephone text-success"></i>
                                            ${user.contactNum}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">-</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.role == 'Admin'}">
                                            <span class="badge bg-danger badge-custom">
                                                <i class="bi bi-shield-fill"></i> ${user.role}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-info badge-custom">
                                                <i class="bi bi-person"></i> ${user.role}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.active}">
                                            <span class="badge bg-success badge-custom">
                                                <i class="bi bi-check-circle"></i> Active
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary badge-custom">
                                                <i class="bi bi-x-circle"></i> Inactive
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <small class="text-muted">
                                        <i class="bi bi-calendar"></i>
                                        ${user.creatAtDate}
                                    </small>
                                </td>
                                <td>
								    <div class="d-flex gap-1 justify-content-center">
								        <a href="viewuser?userId=${user.userId}"
								           class="btn btn-sm btn-info"
								           title="View">
								            <i class="bi bi-eye-fill"></i>
								        </a>
								        <a href="edituser?userId=${user.userId}"
								           class="btn btn-sm btn-warning"
								           title="Edit">
								            <i class="bi bi-pencil-fill"></i>
								        </a>
								        <a href="deleteuser?userId=${user.userId}"
								           class="btn btn-sm btn-danger"
								           onclick="return confirm('Delete ${user.firstName} ${user.lastName}?')"
								           title="Delete">
								            <i class="bi bi-trash-fill"></i>
								        </a>
								    </div>
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
        const table = document.getElementById('userTable');
        const rows = table?.getElementsByTagName('tr');
        
        if (rows) {
            for (let i = 1; i < rows.length; i++) {
                const row = rows[i];
                const name = row.getElementsByTagName('td')[1]?.textContent || '';
                const email = row.getElementsByTagName('td')[2]?.textContent || '';
                const contact = row.getElementsByTagName('td')[3]?.textContent || '';
                
                if (name.toLowerCase().indexOf(searchValue) > -1 || 
                    email.toLowerCase().indexOf(searchValue) > -1 ||
                    contact.toLowerCase().indexOf(searchValue) > -1) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        }
    });
</script>

</body>
</html>