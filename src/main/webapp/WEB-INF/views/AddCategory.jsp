<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Category - MoneyTrail</title>

    <jsp:include page="AdminCSS.jsp" />
</head>

<body class="bg-light">

<jsp:include page="AdminHeader.jsp" />

<jsp:include page="AdminSidebar.jsp" />

<div class="main-content">
    <div class="row justify-content-center align-items-center" style="min-height: 70vh;">
        <div class="col-12 col-sm-10 col-md-6 col-lg-5">

            <div class="card shadow-lg">
                <div class="card-body p-4">

                    <h3 class="text-center mb-4">Add Category</h3>

                    <!-- Add Category Form -->
                    <form action="savecategory" method="post">

                        <!-- Category Name -->
                        <div class="mb-3">
                            <label class="form-label">Category Name</label>
                            <input type="text" name="categoryName" class="form-control" 
                                   placeholder="Enter category name (e.g., Food, Transport, Entertainment)" 
                                   required>
                        </div>

                        <!-- Submit Button -->
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                Add Category
                            </button>
                            <a href="dashboard" class="btn btn-secondary">
                                Cancel
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
