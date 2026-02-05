<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">
        <div class="col-12 col-sm-10 col-md-6 col-lg-4">

            <div class="card shadow-lg">
                <div class="card-body p-4">

                    <h4 class="text-center mb-3">Forgot Password</h4>
                    <p class="text-center text-muted mb-4">
                        Enter your registered email
                    </p>

                    <!-- Forgot Password Form -->
                    <form action="ForgetPasswordServlet" method="post">

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control"
                                   placeholder="Enter your email" required>
                        </div>

                        <!-- Submit -->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">
                                Send Reset Link
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
