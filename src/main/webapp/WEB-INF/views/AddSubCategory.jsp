<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add SubCategory - MoneyTrail</title>

    <jsp:include page="AdminCSS.jsp" />
</head>

<body>

<jsp:include page="AdminHeader.jsp" />

<jsp:include page="AdminSidebar.jsp" />

<div class="main-content">
    <div class="row justify-content-center">
        <div class="col-12 col-sm-10 col-md-8 col-lg-6">

            <div class="card shadow">
                <div class="card-body p-4">

                    <h3 class="text-center mb-4">Add Sub Category</h3>

                    <form action="savesubcategory" method="post">

                        <!-- Select Category -->
                        <div class="mb-3">
                            <label class="form-label">
                                <i class="bi bi-tag text-primary"></i> Select Category
                            </label>
                            <select name="categoryId" class="form-select" required>
                                <option value="" selected disabled>-- Choose Category --</option>
                                
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.categoryId}">${category.categoryName}</option>
                                </c:forEach>
                            </select>
                            <small class="text-muted">Select the parent category</small>
                        </div>

                        <!-- SubCategory Name -->
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
                            <button type="submit" class="btn btn-primary">
                                Add Sub Category
                            </button>
                            <a href="listsubcategory" class="btn btn-outline-secondary">
                                View All SubCategories
                            </a>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="AdminFooter.jsp" />

</body>
</html>