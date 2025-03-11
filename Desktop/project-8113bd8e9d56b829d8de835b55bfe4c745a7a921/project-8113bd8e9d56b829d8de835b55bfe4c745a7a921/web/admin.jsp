<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Animate.css -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <style>
            :root {
                --primary-color: #4e73df;
                --secondary-color: #858796;
                --success-color: #1cc88a;
                --info-color: #36b9cc;
                --warning-color: #f6c23e;
                --danger-color: #e74a3b;
            }

            body {
                background: #f8f9fc;
                font-family: 'Nunito', sans-serif;
            }

            /* Sidebar Styles */
            .sidebar {
                min-height: 100vh;
                background: linear-gradient(180deg, #4e73df 0%, #224abe 100%);
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                z-index: 1000;
            }

            .sidebar-brand {
                padding: 1.5rem;
                text-align: center;
                color: white;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            .sidebar-brand h2 {
                margin: 0;
                font-size: 1.75rem;
                font-weight: 800;
                letter-spacing: 1px;
                text-transform: uppercase;
            }

            .nav-item {
                margin: 0.5rem 1rem;
            }

            .nav-link {
                color: rgba(255, 255, 255, 0.8) !important;
                padding: 1rem !important;
                border-radius: 10px;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
            }

            .nav-link:hover {
                color: white !important;
                background: rgba(255, 255, 255, 0.1);
                transform: translateX(5px);
            }

            .nav-link.active {
                background: white;
                color: var(--primary-color) !important;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .nav-link i {
                margin-right: 0.75rem;
                font-size: 1.25rem;
            }

            /* Main Content Styles */
            .main-content {
                padding: 2rem;
                transition: all 0.3s ease;
            }

            .welcome-section {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
                margin-bottom: 2rem;
                border-left: 5px solid var(--primary-color);
            }

            /* Dashboard Cards */
            .dashboard-card {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
                border-left: 5px solid;
            }

            .dashboard-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            }

            .card-primary {
                border-left-color: var(--primary-color);
            }
            .card-success {
                border-left-color: var(--success-color);
            }
            .card-info {
                border-left-color: var(--info-color);
            }
            .card-warning {
                border-left-color: var(--warning-color);
            }

            .dashboard-card h3 {
                font-size: 1.75rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .dashboard-card p {
                color: var(--secondary-color);
                margin: 0;
            }

            /* Animations */
            .fade-in {
                animation: fadeIn 0.5s ease-in;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Custom Scrollbar */
            ::-webkit-scrollbar {
                width: 8px;
            }

            ::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            ::-webkit-scrollbar-thumb {
                background: var(--primary-color);
                border-radius: 4px;
            }

            /* Logout Button */
            .logout-btn {
                background: var(--danger-color);
                color: white !important;
                margin-top: 2rem;
                transition: all 0.3s ease !important;
            }

            .logout-btn:hover {
                background: #c82333 !important;
                transform: translateX(0) !important;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <nav class="col-md-2 sidebar">
                    <div class="sidebar-brand">
                        <h2 class="animate__animated animate__fadeIn">ADMIN</h2>
                    </div>
                    <div class="position-sticky">
                        <ul class="nav flex-column mt-4">
                            <li class="nav-item">
                                <a class="nav-link active animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin.jsp">
                                    <i class="bi bi-speedometer2"></i>
                                    Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin_categories">
                                    <i class="bi bi-grid-3x3-gap"></i>
                                    Danh mục
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin_products">
                                    <i class="bi bi-box-seam"></i>
                                    Sản phẩm
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin_orders">
                                    <i class="bi bi-cart-check"></i>
                                    Đơn hàng
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin_revenue">
                                    <i class="bi bi-graph-up"></i>
                                    Doanh thu
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin_users">
                                    <i class="bi bi-people"></i>
                                    Người dùng
                                </a>
                            </li>
                            
                            <li class="nav-item">
                                <a class="nav-link animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/">
                                    <i class="bi bi-house-door"></i>
                                    Về trang chủ
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link logout-btn animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/logout">
                                    <i class="bi bi-box-arrow-right"></i>
                                    Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>

                <!-- Main Content -->
                <main class="col-md-10 main-content">
                    <div class="welcome-section animate__animated animate__fadeIn">
                        <h2>Chào mừng trở lại, Admin!</h2>
                        <p>Hôm nay là ngày <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %></p>
                    </div>
                    <!-- Content Area -->
                    <div id="contentArea" class="mt-4">
                        <!-- Content will be loaded here -->
                    </div>
                </main>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </body>
</html>
