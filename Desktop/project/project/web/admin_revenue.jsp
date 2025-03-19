<%-- 
    Author     : DAT, MINH
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thống kê doanh thu - Admin</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                font-family: Arial, sans-serif;
            }

            /* Sidebar Styles */
            .sidebar {
                min-height: 100vh;
                background: linear-gradient(180deg, #4e73df 0%, #224abe 100%);
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                z-index: 1000;
                position: fixed;
                width: inherit;
                max-width: inherit;
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
                transition: all 0.3s ease;
                margin-left: 16.666667%; /* Corresponds to col-md-2 */
            }

            /* Card Styles */
            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                margin-bottom: 20px;
            }

            .card-header {
                background: linear-gradient(45deg, #4e73df, #224abe);
                color: white;
                border-radius: 15px 15px 0 0 !important;
                padding: 1rem 1.5rem;
                font-weight: 600;
            }

            .card-body {
                padding: 1.5rem;
            }

            /* Stats Cards */
            .stat-card {
                border-left: 5px solid;
                border-radius: 10px;
                padding: 1.5rem;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                margin-bottom: 20px;
                background-color: white;
            }

            .stat-card h4 {
                color: #5a5c69;
                font-size: 0.7rem;
                text-transform: uppercase;
                margin: 0;
                font-weight: 700;
            }

            .stat-card .stat-value {
                color: #5a5c69;
                font-size: 1.5rem;
                font-weight: 700;
                margin: 0.5rem 0;
            }

            .stat-card.revenue {
                border-left-color: var(--primary-color);
            }

            .stat-card.orders {
                border-left-color: var(--success-color);
            }

            .stat-card.avg-order {
                border-left-color: var(--info-color);
            }

            .stat-card.conversion {
                border-left-color: var(--warning-color);
            }

            /* Tables */
            .table thead th {
                font-weight: 600;
                background-color: #f8f9fc;
            }

            /* Period Selector */
            .period-selector {
                margin-bottom: 1.5rem;
            }

            .period-selector .btn {
                border-radius: 10px;
                margin-right: 0.5rem;
                padding: 0.4rem 1rem;
                font-weight: 600;
            }

            .period-selector .btn.active {
                background-color: var(--primary-color);
                color: white;
            }

            /* Chart Containers */
            .chart-container {
                position: relative;
                height: 300px;
                width: 100%;
            }

            /* Responsive Adjustments */
            @media (max-width: 768px) {
                .sidebar {
                    position: static;
                    min-height: auto;
                }
                .main-content {
                    margin-left: 0;
                }
            }

            /* Table improvements */
            .table-hover tbody tr:hover {
                background-color: rgba(78, 115, 223, 0.05);
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: rgba(0, 0, 0, 0.02);
            }

            .text-right {
                text-align: right;
            }
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
                                <a class="nav-link animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin.jsp">
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
                                <a class="nav-link active animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin_revenue">
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
                    <div class="container-fluid px-4 py-4">
                        <h1 class="h3 mb-0 text-gray-800">Thống kê doanh thu</h1>
                        <p class="mb-4">Xem báo cáo và phân tích doanh thu của cửa hàng</p>

                        <!-- Period Selector -->
                        <div class="period-selector">
                            <div class="btn-group" role="group">
                                <a href="${pageContext.request.contextPath}/admin_revenue?period=week" class="btn ${selectedPeriod == 'week' ? 'active' : ''} btn-outline-primary">7 ngày</a>
                                <a href="${pageContext.request.contextPath}/admin_revenue?period=month" class="btn ${selectedPeriod == 'month' ? 'active' : ''} btn-outline-primary">30 ngày</a>
                                <a href="${pageContext.request.contextPath}/admin_revenue?period=quarter" class="btn ${selectedPeriod == 'quarter' ? 'active' : ''} btn-outline-primary">3 tháng</a>
                                <a href="${pageContext.request.contextPath}/admin_revenue?period=year" class="btn ${selectedPeriod == 'year' ? 'active' : ''} btn-outline-primary">1 năm</a>
                            </div>
                        </div>

                        <!-- Statistics Cards Row -->
                        <div class="row">
                            <div class="col-xl-3 col-md-6">
                                <div class="stat-card revenue animate__animated animate__fadeInUp">
                                    <h4>Tổng doanh thu</h4>
                                    <div class="stat-value">
                                        <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </div>
                                    <p class="text-muted">Tất cả các đơn hàng đã hoàn thành</p>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="stat-card orders animate__animated animate__fadeInUp" style="animation-delay: 0.1s">
                                    <h4>Đơn hàng thành công</h4>
                                    <div class="stat-value">
                                        <c:out value="${orderStatusStats['Delivered'] != null ? orderStatusStats['Delivered'] : 0}"/>
                                    </div>
                                    <p class="text-muted">Tổng số đơn hàng đã giao</p>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="stat-card avg-order animate__animated animate__fadeInUp" style="animation-delay: 0.2s">
                                    <h4>Giá trị trung bình</h4>
                                    <div class="stat-value">
                                        <fmt:formatNumber value="${totalRevenue / (orderStatusStats['Delivered'] > 0 ? orderStatusStats['Delivered'] : 1)}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </div>
                                    <p class="text-muted">Giá trị trung bình mỗi đơn hàng</p>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="stat-card conversion animate__animated animate__fadeInUp" style="animation-delay: 0.3s">
                                    <h4>Tỷ lệ hoàn thành</h4>
                                    <div class="stat-value">
                                        <c:set var="totalOrders" value="0" />
                                        <c:forEach items="${orderStatusStats}" var="status">
                                            <c:set var="totalOrders" value="${totalOrders + status.value}" />
                                        </c:forEach>
                                        <fmt:formatNumber value="${(orderStatusStats['Delivered'] / (totalOrders > 0 ? totalOrders : 1)) * 100}" type="number" maxFractionDigits="1"/>%
                                    </div>
                                    <p class="text-muted">Tỷ lệ đơn hàng hoàn thành</p>
                                </div>
                            </div>
                        </div>

                        <!-- Revenue Chart -->
                        <div class="row">
                            <div class="col-xl-12">
                                <div class="card shadow mb-4 animate__animated animate__fadeIn" style="animation-delay: 0.4s">
                                    <div class="card-header">
                                        <h6 class="m-0 font-weight-bold">Biểu đồ doanh thu hàng ngày</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="chart-container">
                                            <canvas id="revenueChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!-- Monthly Revenue Chart -->
                        <div class="row">
                            <div class="col-xl-12">
                                <div class="card shadow mb-4 animate__animated animate__fadeIn" style="animation-delay: 0.6s">
                                    <div class="card-header">
                                        <h6 class="m-0 font-weight-bold">Doanh thu theo tháng (${currentYear})</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="chart-container">
                                            <canvas id="monthlyRevenueChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Doanh thu theo danh mục -->
                        <div class="card shadow mb-4 animate__animated animate__fadeIn" style="animation-delay: 0.7s">
                            <div class="card-header">
                                <h6 class="m-0 font-weight-bold">Doanh thu theo danh mục</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <!-- Bảng doanh thu theo danh mục (bên trái) -->
                                    <div class="col-md-6">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-hover table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>ID Danh Mục</th>
                                                        <th>Tên Danh Mục</th>
                                                        <th class="text-center">Số Lượng</th>
                                                        <th class="text-right">Doanh Thu</th>
                                                        <th class="text-right">Tỷ Lệ</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:set var="totalCategoryRevenue" value="0" />
                                                    <c:forEach items="${revenueByCategory}" var="category">
                                                        <c:set var="totalCategoryRevenue" value="${totalCategoryRevenue + category.totalRevenue}" />
                                                    </c:forEach>

                                                    <c:forEach items="${revenueByCategory}" var="category">
                                                        <tr>
                                                            <td>${category.categoryId}</td>
                                                            <td>
                                                                <span class="fw-bold">${category.categoryName}</span>
                                                            </td>
                                                            <td class="text-center">${category.totalQuantity}</td>
                                                            <td class="text-right">
                                                                <fmt:formatNumber value="${category.totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                            </td>
                                                            <td class="text-right">
                                                                <div class="d-flex align-items-center justify-content-end">
                                                                    <div class="me-2">
                                                                        <fmt:formatNumber value="${(category.totalRevenue / totalCategoryRevenue) * 100}" type="number" maxFractionDigits="1"/>%
                                                                    </div>
                                                                    <div class="progress" style="width: 60px; height: 6px;">
                                                                        <div class="progress-bar bg-success" role="progressbar" 
                                                                             style="width: <fmt:formatNumber value="${(category.totalRevenue / totalCategoryRevenue) * 100}" type="number" maxFractionDigits="1"/>%"></div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty revenueByCategory}">
                                                        <tr>
                                                            <td colspan="5" class="text-center">Chưa có dữ liệu</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <!-- Biểu đồ doanh thu theo danh mục (bên phải) -->
                                    <div class="col-md-6">
                                        <div class="chart-container">
                                            <canvas id="categoryChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <!-- Trạng thái đơn hàng -->
                        <div class="card shadow mb-4 animate__animated animate__fadeIn" style="animation-delay: 0.8s">
                            <div class="card-header">
                                <h6 class="m-0 font-weight-bold">Trạng thái đơn hàng</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-hover table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Trạng thái</th>
                                                        <th class="text-center">Số lượng</th>
                                                        <th class="text-right">Tỷ lệ</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:set var="totalOrderCount" value="0" />
                                                    <c:forEach items="${orderStatusStats}" var="status">
                                                        <c:set var="totalOrderCount" value="${totalOrderCount + status.value}" />
                                                    </c:forEach>

                                                    <c:forEach items="${orderStatusStats}" var="status">
                                                        <tr>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${status.key == 'Delivered'}">
                                                                        <span class="badge bg-success">${status.key}</span>
                                                                    </c:when>
                                                                    <c:when test="${status.key == 'Processing'}">
                                                                        <span class="badge bg-info">${status.key}</span>
                                                                    </c:when>
                                                                    <c:when test="${status.key == 'Pending'}">
                                                                        <span class="badge bg-warning">${status.key}</span>
                                                                    </c:when>
                                                                    <c:when test="${status.key == 'Cancelled'}">
                                                                        <span class="badge bg-danger">${status.key}</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-secondary">${status.key}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="text-center">${status.value}</td>
                                                            <td class="text-right">
                                                                <div class="d-flex align-items-center justify-content-end">
                                                                    <div class="me-2">
                                                                        <fmt:formatNumber value="${(status.value / totalOrderCount) * 100}" type="number" maxFractionDigits="1"/>%
                                                                    </div>
                                                                    <div class="progress" style="width: 60px; height: 6px;">
                                                                        <div class="progress-bar
                                                                             <c:choose>
                                                                                 <c:when test="${status.key == 'Delivered'}">bg-success</c:when>
                                                                                 <c:when test="${status.key == 'Processing'}">bg-info</c:when>
                                                                                 <c:when test="${status.key == 'Pending'}">bg-warning</c:when>
                                                                                 <c:when test="${status.key == 'Cancelled'}">bg-danger</c:when>
                                                                                 <c:otherwise>bg-secondary</c:otherwise>
                                                                             </c:choose>
                                                                             " role="progressbar" 
                                                                             style="width: <fmt:formatNumber value="${(status.value / totalOrderCount) * 100}" type="number" maxFractionDigits="1"/>%"></div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty orderStatusStats}">
                                                        <tr>
                                                            <td colspan="3" class="text-center">Chưa có dữ liệu</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="chart-container">
                                            <canvas id="orderStatusChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Top Products -->
                        <div class="row">
                            <div class="col-xl-12">
                                <div class="card shadow mb-4 animate__animated animate__fadeIn" style="animation-delay: 0.9s">
                                    <div class="card-header">
                                        <h6 class="m-0 font-weight-bold">Top 10 sản phẩm bán chạy</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-hover table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Tên sản phẩm</th>
                                                        <th class="text-center">Số lượng</th>
                                                        <th class="text-right">Doanh thu</th>
                                                        <th class="text-right">Tỷ lệ doanh thu</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:set var="totalProductRevenue" value="0" />
                                                    <c:forEach items="${topProducts}" var="product">
                                                        <c:set var="totalProductRevenue" value="${totalProductRevenue + product.totalRevenue}" />
                                                    </c:forEach>

                                                    <c:forEach items="${topProducts}" var="product" varStatus="loop">
                                                        <tr>
                                                            <td>${product.productId}</td>
                                                            <td>
                                                                <c:if test="${loop.index < 3}">
                                                                    <span class="badge bg-${loop.index == 0 ? 'warning' : loop.index == 1 ? 'secondary' : 'danger'} me-2">#${loop.index + 1}</span>
                                                                </c:if>
                                                                ${product.productName}
                                                            </td>
                                                            <td class="text-center">${product.totalQuantity}</td>
                                                            <td class="text-right">
                                                                <fmt:formatNumber value="${product.totalRevenue}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                            </td>
                                                            <td class="text-right">
                                                                <div class="d-flex align-items-center justify-content-end">
                                                                    <div class="me-2">
                                                                        <fmt:formatNumber value="${(product.totalRevenue / totalProductRevenue) * 100}" type="number" maxFractionDigits="1"/>%
                                                                    </div>
                                                                    <div class="progress" style="width: 60px; height: 6px;">
                                                                        <div class="progress-bar bg-primary" role="progressbar" 
                                                                             style="width: <fmt:formatNumber value="${(product.totalRevenue / totalProductRevenue) * 100}" type="number" maxFractionDigits="1"/>%"></div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty topProducts}">
                                                        <tr>
                                                            <td colspan="5" class="text-center">Chưa có dữ liệu</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>




                        <!-- Scripts -->
                        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                // Biểu đồ doanh thu theo ngày
                                const revenueChartCtx = document.getElementById('revenueChart').getContext('2d');

                                // Chuẩn bị dữ liệu cho biểu đồ doanh thu theo ngày
                                const revenueLabels = [
                            <c:forEach items="${revenueByDate}" var="item" varStatus="status">
                                    '<fmt:formatDate value="${item.date}" pattern="dd/MM" />',
                            </c:forEach>
                                ];

                                const revenueData = [
                            <c:forEach items="${revenueByDate}" var="item" varStatus="status">
                                ${item.revenue},
                            </c:forEach>
                                ];

                                new Chart(revenueChartCtx, {
                                    type: 'line',
                                    data: {
                                        labels: revenueLabels.length > 0 ? revenueLabels : ['Không có dữ liệu'],
                                        datasets: [{
                                                label: 'Doanh thu',
                                                data: revenueData.length > 0 ? revenueData : [0],
                                                backgroundColor: 'rgba(78, 115, 223, 0.2)',
                                                borderColor: 'rgba(78, 115, 223, 1)',
                                                borderWidth: 2,
                                                pointBackgroundColor: 'rgba(78, 115, 223, 1)',
                                                pointBorderColor: '#fff',
                                                pointBackgroundColor: 'rgba(78, 115, 223, 1)',
                                                pointBorderColor: '#fff',
                                                pointHoverBackgroundColor: '#fff',
                                                pointHoverBorderColor: 'rgba(78, 115, 223, 1)',
                                                tension: 0.3
                                            }]
                                    },
                                    options: {
                                        responsive: true,
                                        maintainAspectRatio: false,
                                        scales: {
                                            y: {
                                                beginAtZero: true,
                                                ticks: {
                                                    callback: function (value) {
                                                        return value.toLocaleString('vi-VN') + '₫';
                                                    }
                                                },
                                                grid: {
                                                    drawBorder: false,
                                                    color: 'rgba(0, 0, 0, 0.05)'
                                                }
                                            },
                                            x: {
                                                grid: {
                                                    display: false
                                                }
                                            }
                                        },
                                        plugins: {
                                            tooltip: {
                                                backgroundColor: 'rgba(255, 255, 255, 0.9)',
                                                titleColor: '#333',
                                                bodyColor: '#333',
                                                borderColor: 'rgba(78, 115, 223, 0.3)',
                                                borderWidth: 1,
                                                callbacks: {
                                                    label: function (context) {
                                                        return 'Doanh thu: ' + context.parsed.y.toLocaleString('vi-VN') + '₫';
                                                    }
                                                }
                                            },
                                            legend: {
                                                display: false
                                            }
                                        },
                                        interaction: {
                                            intersect: false,
                                            mode: 'index'
                                        }
                                    }
                                });

                                // Biểu đồ doanh thu theo tháng
                                const monthlyRevenueChartCtx = document.getElementById('monthlyRevenueChart').getContext('2d');

                                // Khởi tạo mảng dữ liệu với 12 tháng và giá trị 0
                                const monthlyData = Array(12).fill(0);

                                // Cập nhật dữ liệu từ kết quả truy vấn
                            <c:forEach items="${monthlyRevenue}" var="item">
                                monthlyData[${item.month - 1}] = ${item.revenue};
                            </c:forEach>

                                new Chart(monthlyRevenueChartCtx, {
                                    type: 'bar',
                                    data: {
                                        labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6',
                                            'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                                        datasets: [{
                                                label: 'Doanh thu',
                                                data: monthlyData,
                                                backgroundColor: function (context) {
                                                    const index = context.dataIndex;
                                                    const value = context.dataset.data[index];
                                                    const maxValue = Math.max(...context.dataset.data);

                                                    // Gradient color based on value
                                                    const alpha = value / maxValue * 0.8 + 0.2; // Min alpha is 0.2
                                                    return `rgba(28, 200, 138, ${alpha})`;
                                                },
                                                borderColor: 'rgba(28, 200, 138, 1)',
                                                borderWidth: 1,
                                                borderRadius: 5,
                                                maxBarThickness: 50
                                            }]
                                    },
                                    options: {
                                        responsive: true,
                                        maintainAspectRatio: false,
                                        scales: {
                                            y: {
                                                beginAtZero: true,
                                                ticks: {
                                                    callback: function (value) {
                                                        return value.toLocaleString('vi-VN') + '₫';
                                                    }
                                                },
                                                grid: {
                                                    drawBorder: false,
                                                    color: 'rgba(0, 0, 0, 0.05)'
                                                }
                                            },
                                            x: {
                                                grid: {
                                                    display: false
                                                }
                                            }
                                        },
                                        plugins: {
                                            tooltip: {
                                                backgroundColor: 'rgba(255, 255, 255, 0.9)',
                                                titleColor: '#333',
                                                bodyColor: '#333',
                                                borderColor: 'rgba(28, 200, 138, 0.3)',
                                                borderWidth: 1,
                                                callbacks: {
                                                    label: function (context) {
                                                        return 'Doanh thu: ' + context.parsed.y.toLocaleString('vi-VN') + '₫';
                                                    }
                                                }
                                            },
                                            legend: {
                                                display: false
                                            }
                                        }
                                    }
                                });

                                // Biểu đồ doanh thu theo danh mục
                                const categoryChartCtx = document.getElementById('categoryChart').getContext('2d');

                                const categoryLabels = [
                            <c:forEach items="${revenueByCategory}" var="cat" varStatus="status">
                                '${cat.categoryName}'${!status.last ? ',' : ''}
                            </c:forEach>
                                ];

                                const categoryData = [
                            <c:forEach items="${revenueByCategory}" var="cat" varStatus="status">
                                ${cat.totalRevenue}${!status.last ? ',' : ''}
                            </c:forEach>
                                ];

                                new Chart(categoryChartCtx, {
                                    type: 'doughnut',
                                    data: {
                                        labels: categoryLabels.length > 0 ? categoryLabels : ['Không có dữ liệu'],
                                        datasets: [{
                                                data: categoryData.length > 0 ? categoryData : [1],
                                                backgroundColor: [
                                                    'rgba(78, 115, 223, 0.8)', // Xanh lam
                                                    'rgba(28, 200, 138, 0.8)', // Xanh lá
                                                    'rgba(54, 185, 204, 0.8)', // Xanh dương nhạt
                                                    'rgba(246, 194, 62, 0.8)', // Vàng
                                                    'rgba(231, 74, 59, 0.8)', // Đỏ
                                                    'rgba(116, 88, 188, 0.8)'   // Tím
                                                ],
                                                borderWidth: 2,
                                                borderColor: 'white'
                                            }]
                                    },
                                    options: {
                                        responsive: true,
                                        maintainAspectRatio: false,
                                        plugins: {
                                            legend: {
                                                position: 'right',
                                                labels: {
                                                    boxWidth: 12,
                                                    padding: 15
                                                }
                                            },
                                            tooltip: {
                                                callbacks: {
                                                    label: function (context) {
                                                        const value = context.raw;
                                                        const total = context.dataset.data.reduce((acc, val) => acc + val, 0);
                                                        const percentage = ((value / total) * 100).toFixed(1);
                                                        return `${context.label}: ${value.toLocaleString('vi-VN')}₫ (${percentage}%)`;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                });

                                // Biểu đồ trạng thái đơn hàng
                                const orderStatusChartCtx = document.getElementById('orderStatusChart').getContext('2d');

                                // Chuẩn bị dữ liệu cho biểu đồ trạng thái đơn hàng
                                const statusLabels = [];
                                const statusData = [];
                                const statusColors = {
                                    'Delivered': 'rgba(28, 200, 138, 0.8)', // Đã giao - xanh lá
                                    'Processing': 'rgba(54, 185, 204, 0.8)', // Đang xử lý - xanh dương
                                    'Shipping': 'rgba(78, 115, 223, 0.8)', // Đang giao - xanh dương đậm
                                    'Pending': 'rgba(246, 194, 62, 0.8)', // Chờ xác nhận - vàng
                                    'Cancelled': 'rgba(231, 74, 59, 0.8)'    // Đã hủy - đỏ
                                };

                                const colorArray = [];

                            <c:forEach items="${orderStatusStats}" var="status">
                                statusLabels.push('${status.key}');
                                statusData.push(${status.value});
                                colorArray.push(statusColors['${status.key}'] || 'rgba(116, 88, 188, 0.8)');
                            </c:forEach>

                                new Chart(orderStatusChartCtx, {
                                    type: 'pie',
                                    data: {
                                        labels: statusLabels.length > 0 ? statusLabels : ['Không có dữ liệu'],
                                        datasets: [{
                                                data: statusData.length > 0 ? statusData : [1],
                                                backgroundColor: colorArray.length > 0 ? colorArray : ['rgba(116, 88, 188, 0.8)'],
                                                borderColor: 'white',
                                                borderWidth: 2,
                                                hoverOffset: 10
                                            }]
                                    },
                                    options: {
                                        responsive: true,
                                        maintainAspectRatio: false,
                                        plugins: {
                                            legend: {
                                                position: 'bottom',
                                                labels: {
                                                    boxWidth: 12,
                                                    padding: 15,
                                                    font: {
                                                        size: 11
                                                    }
                                                }
                                            },
                                            tooltip: {
                                                backgroundColor: 'rgba(255, 255, 255, 0.9)',
                                                titleColor: '#333',
                                                bodyColor: '#333',
                                                borderColor: 'rgba(0, 0, 0, 0.1)',
                                                borderWidth: 1,
                                                callbacks: {
                                                    label: function (context) {
                                                        const value = context.raw;
                                                        const total = context.dataset.data.reduce((acc, val) => acc + val, 0);
                                                        const percentage = ((value / total) * 100).toFixed(1);
                                                        return `${context.label}: ${value} đơn (${percentage}%)`;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                });

                                // Animation on scroll
                                const animateOnScroll = () => {
                                    const elements = document.querySelectorAll('.animate__animated:not(.animate__animated--triggered)');
                                    elements.forEach(element => {
                                        const elementPosition = element.getBoundingClientRect().top;
                                        const screenPosition = window.innerHeight;

                                        if (elementPosition < screenPosition - 100) {
                                            const animationClass = element.classList.contains('animate__fadeIn') ? 'animate__fadeIn' :
                                                    element.classList.contains('animate__fadeInUp') ? 'animate__fadeInUp' :
                                                    element.classList.contains('animate__fadeInLeft') ? 'animate__fadeInLeft' : '';

                                            if (animationClass) {
                                                element.classList.add(animationClass + '--triggered');
                                            }
                                        }
                                    });
                                };

                                // Initial check
                                animateOnScroll();

                                // Add scroll event listener
                                window.addEventListener('scroll', animateOnScroll);
                            });
                        </script>
                        </body>
                        </html>

