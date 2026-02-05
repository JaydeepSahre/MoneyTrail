<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Signup</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">
        <div class="col-12 col-sm-10 col-md-6 col-lg-5">

            <div class="card shadow-lg">
                <div class="card-body p-4">

                    <h3 class="text-center mb-4">Create Account</h3>

                    <form action="register" method="post">

                        <!-- Name Row -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">First Name</label>
                                <input type="text" name="firstName" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Last Name</label>
                                <input type="text" name="lastName" class="form-control" required>
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>

                        <!-- Contact + Birth Year -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Contact Number</label>
                                <input type="tel" name="contactNum" class="form-control"
                                       pattern="[0-9]{10}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Birth Year</label>
                                <input type="number" name="birthYear" class="form-control"
                                       min="1900" max="2026" required>
                            </div>
                        </div>

                        <!-- Gender -->
                        <div class="mb-3">
                            <label class="form-label d-block">Gender</label>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" value="Male" required>
                                <label class="form-check-label">Male</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" value="Female">
                                <label class="form-check-label">Female</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" value="Other">
                                <label class="form-check-label">Other</label>
                            </div>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>

                        <!-- Profile Picture -->
                        <div class="mb-3">
                            <label class="form-label">Profile Picture</label>
                            <input type="file" name="profilePicURL" class="form-control" accept="image/*">
                        </div>

                        <!-- Submit -->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">
                                Sign Up
                            </button>
                        </div>

                    </form>

                    <p class="text-center mt-3">
                        Already have an account?
                        <a href="login">Login</a>
                    </p>

                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
