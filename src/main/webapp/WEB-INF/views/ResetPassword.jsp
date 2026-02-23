<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">
        <div class="col-12 col-sm-10 col-md-6 col-lg-4">

            <div class="card shadow-lg">
                <div class="card-body p-4">

                    <h4 class="text-center mb-3">Reset Password</h4>
                    <p class="text-center text-muted mb-4">
                        Set your new password
                    </p>

                    <!-- Reset Password Form -->
                    <form action="reset" method="post">

                        <!-- Hidden Email -->
                        <input type="hidden" name="email" value="${email}"/>

                        <!-- New Password -->
                        <div class="mb-3">
                            <label class="form-label">New Password</label>
                            <input type="password" name="password"
                                   class="form-control"
                                   placeholder="Enter new password"
                                   required>
                        </div>

                        <!-- Submit -->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">
                                Reset Password
                            </button>
                        </div>

                    </form>

                    <div class="text-center mt-3">
                        <a href="login">Back to Login</a>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>