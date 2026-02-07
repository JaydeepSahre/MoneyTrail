<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Vendor - MoneyTrail</title>

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
            max-width: 500px;
            width: 100%;
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

    </style>
</head>

<body>

<jsp:include page="AdminHeader.jsp" />

<jsp:include page="AdminSidebar.jsp" />

<div class="main-content">
	<div class="form-card">
    
    <!-- Form Header -->
    <div class="form-header">
        <i class="bi bi-shop"></i>
        <h3>Add Vendor</h3>
        <p class="mb-0">Add a new vendor/merchant</p>
    </div>

    <!-- Form Body -->
    <div class="p-4">
        <form action="savevendor" method="post">

            <!-- Vendor Name -->
            <div class="mb-4">
                <label class="form-label">
                    <i class="bi bi-shop text-primary"></i> Vendor Name
                </label>
                <input type="text" name="vendorName" class="form-control" 
                       placeholder="Enter vendor name (e.g., DMart, Starbucks, Amazon)" 
                       required>
                <small class="text-muted">Enter the name of the shop, merchant, or service provider</small>
            </div>

            <!-- Buttons -->
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary btn-lg">
                    <i class="bi bi-check-circle"></i> Add Vendor
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