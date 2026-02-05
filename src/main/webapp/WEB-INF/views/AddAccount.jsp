<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Account - MoneyTrail</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            max-width: 500px;
            width: 100%;
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

        .back-link {
            color: white;
            text-decoration: none;
            position: absolute;
            top: 20px;
            left: 20px;
            font-size: 20px;
        }

        .back-link:hover {
            color: #ffc107;
        }

        .account-type-card {
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .account-type-card:hover {
            border-color: #667eea;
            background: #f8f9ff;
        }

        .account-type-card input[type="radio"]:checked + label {
            color: #667eea;
            font-weight: bold;
        }
    </style>
</head>

<body>

<a href="dashboard" class="back-link">
    <i class="bi bi-arrow-left-circle-fill"></i>
</a>

<div class="form-card">
    
    <!-- Form Header -->
    <div class="form-header">
        <i class="bi bi-wallet2"></i>
        <h3>Add Account</h3>
        <p class="mb-0">Add a new payment account</p>
    </div>

    <!-- Form Body -->
    <div class="p-4">
        <form action="saveaccount" method="post">

            <!-- Account Title (Type) -->
            <div class="mb-3">
                <label class="form-label">
                    <i class="bi bi-credit-card text-primary"></i> Account Type
                </label>
                
                <div class="row g-2">
                    <!-- Credit Card -->
                    <div class="col-4">
                        <div class="account-type-card text-center">
                            <input class="form-check-input" type="radio" name="title" 
                                   id="creditCard" value="Credit Card" required>
                            <label class="form-check-label d-block" for="creditCard">
                                <i class="bi bi-credit-card-2-front fs-3 d-block mb-1"></i>
                                Credit Card
                            </label>
                        </div>
                    </div>

                    <!-- Debit Card -->
                    <div class="col-4">
                        <div class="account-type-card text-center">
                            <input class="form-check-input" type="radio" name="title" 
                                   id="debitCard" value="Debit Card" required>
                            <label class="form-check-label d-block" for="debitCard">
                                <i class="bi bi-credit-card fs-3 d-block mb-1"></i>
                                Debit Card
                            </label>
                        </div>
                    </div>

                    <!-- Cash -->
                    <div class="col-4">
                        <div class="account-type-card text-center">
                            <input class="form-check-input" type="radio" name="title" 
                                   id="cash" value="Cash" required>
                            <label class="form-check-label d-block" for="cash">
                                <i class="bi bi-cash-stack fs-3 d-block mb-1"></i>
                                Cash
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Other Option -->
                <div class="mt-2">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="title" 
                               id="other" value="Other">
                        <label class="form-check-label" for="other">
                            Other (UPI, Wallet, etc.)
                        </label>
                    </div>
                </div>
            </div>

            <!-- Account Amount (Balance) -->
            <div class="mb-3">
                <label class="form-label">
                    <i class="bi bi-currency-rupee text-success"></i> Initial Balance
                </label>
                <input type="number" name="amount" class="form-control" 
                       placeholder="Enter initial balance (e.g., 5000)" 
                       step="0.01" min="0" required>
                <small class="text-muted">Enter the current balance in this account</small>
            </div>

            <!-- Set as Default -->
            <div class="mb-4">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="exDefault" 
                           id="setDefault" value="true">
                    <label class="form-check-label" for="setDefault">
                        <i class="bi bi-star text-warning"></i> Set as default account
                    </label>
                    <small class="d-block text-muted">Default account will be pre-selected when adding expenses</small>
                </div>
            </div>

            <!-- Buttons -->
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary btn-lg">
                    <i class="bi bi-check-circle"></i> Add Account
                </button>
                <a href="dashboard" class="btn btn-outline-secondary">
                    <i class="bi bi-x-circle"></i> Cancel
                </a>
            </div>

        </form>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>