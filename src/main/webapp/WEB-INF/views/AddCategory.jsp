<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Category - MoneyTrail</title>

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

                    <h3 class="text-center mb-4">Add Category</h3>

                    <form action="savecategory" method="post">

                        <div class="mb-3">
                            <label class="form-label">Category Name</label>
                            <input type="text" name="categoryName" class="form-control" 
                                   placeholder="Enter category name (e.g., Food, Transport)" 
                                   required>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                Add Category
                            </button>
                            <a href="listcategory" class="btn btn-outline-secondary">
                                View All Categories
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
