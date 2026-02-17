<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View User - MoneyTrail</title>
    <jsp:include page="AdminCSS.jsp" />
    
    <style>
        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            border-radius: 10px;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 5px solid white;
            margin-bottom: 15px;
        }
        
        .info-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .info-row {
            display: flex;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #666;
            width: 200px;
        }
        
        .info-value {
            color: #333;
            flex: 1;
        }
    </style>
</head>
<body>

<jsp:include page="AdminHeader.jsp" />
<jsp:include page="AdminSidebar.jsp" />

<div class="main-content">
    
    <!-- Profile Header -->
    <div class="profile-header">
        <c:choose>
            <c:when test="${not empty user.profilePicURL}">
                <img src="${user.profilePicURL}" class="profile-avatar" alt="Profile">
            </c:when>
            <c:otherwise>
                <div class="profile-avatar bg-secondary d-inline-flex align-items-center justify-content-center text-white" 
                     style="font-size: 40px; margin: 0 auto;">
                    ${user.firstName.substring(0,1)}${user.lastName.substring(0,1)}
                </div>
            </c:otherwise>
        </c:choose>
        <h2>${user.firstName} ${user.lastName}</h2>
        <p class="mb-0">${user.email}</p>
    </div>

    <!-- User Details -->
    <div class="info-card">
        <h4 class="mb-4"><i class="bi bi-person-circle"></i> Personal Information</h4>
        
        <div class="info-row">
            <div class="info-label"><i class="bi bi-person"></i> First Name</div>
            <div class="info-value">${user.firstName}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label"><i class="bi bi-person"></i> Last Name</div>
            <div class="info-value">${user.lastName}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label"><i class="bi bi-envelope"></i> Email</div>
            <div class="info-value">${user.email}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label"><i class="bi bi-telephone"></i> Contact Number</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${not empty user.contactNum}">
                        ${user.contactNum}
                    </c:when>
                    <c:otherwise>
                        <span class="text-muted">Not provided</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="info-row">
            <div class="info-label"><i class="bi bi-gender-ambiguous"></i> Gender</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${not empty user.gender}">
                        ${user.gender}
                    </c:when>
                    <c:otherwise>
                        <span class="text-muted">Not specified</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="info-row">
            <div class="info-label"><i class="bi bi-calendar"></i> Birth Year</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${not empty user.birthYear}">
                        ${user.birthYear}
                    </c:when>
                    <c:otherwise>
                        <span class="text-muted">Not provided</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Account Information -->
    <div class="info-card">
        <h4 class="mb-4"><i class="bi bi-shield-check"></i> Account Information</h4>
        
        <div class="info-row">
            <div class="info-label"><i class="bi bi-person-badge"></i> User ID</div>
            <div class="info-value">${user.userId}</div>
        </div>
        
        <div class="info-row">
            <div class="info-label"><i class="bi bi-shield"></i> Role</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${user.role == 'Admin'}">
                        <span class="badge bg-danger">
                            <i class="bi bi-shield-fill"></i> ${user.role}
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-info">
                            <i class="bi bi-person"></i> ${user.role}
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="info-row">
            <div class="info-label"><i class="bi bi-check-circle"></i> Status</div>
            <div class="info-value">
                <c:choose>
                    <c:when test="${user.active}">
                        <span class="badge bg-success">
                            <i class="bi bi-check-circle"></i> Active
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-secondary">
                            <i class="bi bi-x-circle"></i> Inactive
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="info-row">
            <div class="info-label"><i class="bi bi-calendar-plus"></i> Created Date</div>
            <div class="info-value">${user.creatAtDate}</div>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="text-center mt-4">
        <a href="edituser?userId=${user.userId}" class="btn btn-warning btn-lg me-2">
            <i class="bi bi-pencil-fill"></i> Edit User
        </a>
        <a href="listuser" class="btn btn-secondary btn-lg">
            <i class="bi bi-arrow-left"></i> Back to List
        </a>
    </div>

</div>

<jsp:include page="AdminFooter.jsp" />

</body>
</html>