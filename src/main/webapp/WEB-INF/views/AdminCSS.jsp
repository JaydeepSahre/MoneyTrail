<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* ================= SIDEBAR (FIXED SCROLLING) ================= */
    .sidebar {
        min-height: 100vh;
        height: 100vh;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        position: fixed;
        top: 0;
        left: 0;
        width: 250px;
        padding-top: 20px;
        padding-bottom: 20px;
        z-index: 1000;
        overflow-y: auto;
        overflow-x: hidden;
    }
    
    /* Custom Scrollbar for Sidebar */
    .sidebar::-webkit-scrollbar {
        width: 6px;
    }
    
    .sidebar::-webkit-scrollbar-track {
        background: rgba(255, 255, 255, 0.1);
    }
    
    .sidebar::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.3);
        border-radius: 10px;
    }
    
    .sidebar::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.5);
    }

    .sidebar .logo {
        text-align: center;
        padding: 20px 0;
        font-size: 24px;
        font-weight: bold;
        border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        margin-bottom: 20px;
    }

    .sidebar a {
        color: white;
        text-decoration: none;
        padding: 15px 20px;
        display: flex;
        align-items: center;
        transition: all 0.3s;
    }

    .sidebar a:hover {
        background: rgba(255, 255, 255, 0.1);
        padding-left: 30px;
    }

    .sidebar a i {
        margin-right: 10px;
    }

    .sidebar .menu-section {
        padding: 10px 20px;
        font-size: 12px;
        color: rgba(255, 255, 255, 0.6);
        text-transform: uppercase;
        margin-top: 20px;
    }

    /* ================= HEADER ================= */
    .header {
        position: fixed;
        left: 250px;
        right: 0;
        top: 0;
        height: 96px;
        background: #ffffff;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 30px;
        z-index: 900;
    }
    
    .profile-img{
	  width:40px;
	  height:40px;
	  border-radius:50%;
	  object-fit:cover;     /* prevents stretching */
	  flex:0 0 40px;        /* prevents shrinking/growing */
	  display:block;
	}

    /* ================= MAIN CONTENT ================= */
    .main-content {
        margin-left: 250px;
        margin-top: 96px;
        padding: 30px;
        background: #f8f9fa;
        min-height: calc(100vh - 120px);
    }

    /* ================= FOOTER ================= */
    .footer {
        margin-left: 250px;
        height: 50px;
        background: #ffffff;
        border-top: 1px solid #ddd;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        color: #666;
    }

    /* ================= DASHBOARD CARDS ================= */
    .dashboard-card {
        background: white;
        border-radius: 10px;
        padding: 25px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .dashboard-card .icon {
        width: 60px;
        height: 60px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 30px;
        color: white;
        margin-bottom: 15px;
    }

    .dashboard-card h3 {
        font-size: 32px;
        font-weight: bold;
        margin-bottom: 5px;
    }

    .dashboard-card p {
        color: #6c757d;
        margin-bottom: 0;
    }

    .card-income {
        border-left: 4px solid #28a745;
    }

    .card-income .icon {
        background: #28a745;
    }

    .card-expense {
        border-left: 4px solid #dc3545;
    }

    .card-expense .icon {
        background: #dc3545;
    }

    .card-balance {
        border-left: 4px solid #17a2b8;
    }

    .card-balance .icon {
        background: #17a2b8;
    }

    .card-transactions {
        border-left: 4px solid #ffc107;
    }

    .card-transactions .icon {
        background: #ffc107;
    }
</style>
