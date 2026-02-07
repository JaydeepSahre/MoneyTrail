<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.grownited.entity.CategoryEntity" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Sub Category - MoneyTrail</title>

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
        <i class="bi bi-tags-fill"></i>
        <h3>Add Sub Category</h3>
        <p class="mb-0">Add a new subcategory under existing category</p>
    </div>

    <!-- Form Body -->
    <div class="p-4">
        <form action="savesubcategory" method="post">

            <!-- Select Category (Parent) -->
            <div class="mb-3">
                <label class="form-label">
                    <i class="bi bi-tag text-primary"></i> Select Category
                </label>
                <select name="categoryId" class="form-select" required>
    				<option value="" selected disabled>-- Choose Category --</option>
    					<%
        					List<CategoryEntity> categories = (List<CategoryEntity>) request.getAttribute("categories");
        					if (categories != null) {
            					for (CategoryEntity category : categories) {
    						%>
                			<option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
    						<%
           			 			}
        			        }
    					%>
				</select>
                <small class="text-muted">Select the parent category</small>
            </div>

            <!-- Sub Category Name -->
            <div class="mb-4">
                <label class="form-label">
                    <i class="bi bi-tags text-success"></i> Sub Category Name
                </label>
                <input type="text" name="subCategoryName" class="form-control" 
                       placeholder="Enter subcategory name (e.g., Fast Food, Vegetables)" 
                       required>
                <small class="text-muted">Example: If category is "Food", subcategory can be "Fast Food", "Groceries"</small>
            </div>

            <!-- Buttons -->
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary btn-lg">
                    <i class="bi bi-check-circle"></i> Add Sub Category
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