<%-- 
    Document   : product
    Created on : Feb 20, 2025, 4:37:00 PM
    Author     : IUHADU
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sản phẩm - KINGDOMS TOYS</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <style>
            :root {
                --primary-color: rgba(130, 119, 172, 1);
                --text-color: #212121;
                --price-color: #9B3C44;
            }

            body {
                font-family: 'Karla', sans-serif;
                color: #777;
                background-color: #fff;
                padding-top: 140px;
            }

            /* Navigation Styles */
            .navbar {
                padding: 15px 0;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                background-color: rgba(255, 255, 255, 0.98) !important;
            }

            .navbar-brand img {
                max-height: 100px;
                transition: transform 0.3s ease;
            }

            .navbar-brand:hover img {
                transform: scale(1.05);
            }

            .navbar-nav .nav-item {
                position: relative;
                margin: 0 5px;
            }

            .navbar-nav .nav-link {
                color: #333;
                font-weight: 500;
                padding: 8px 15px;
                transition: all 0.3s ease;
                position: relative;
                z-index: 1;
            }

            .navbar-nav .nav-link::before {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                height: 2px;
                background-color: #B01E68;
                transform: scaleX(0);
                transform-origin: right;
                transition: transform 0.3s ease;
            }

            .navbar-nav .nav-link:hover::before {
                transform: scaleX(1);
                transform-origin: left;
            }

            .navbar-nav .nav-link:hover {
                color: #B01E68;
                transform: translateY(-2px);
            }

            .navbar-nav .auth-links .nav-link {
                border: 1px solid transparent;
                border-radius: 20px;
                padding: 6px 15px;
                margin: 0 5px;
                transition: all 0.3s ease;
            }

            .navbar-nav .auth-links .nav-link:hover {
                border-color: #B01E68;
                background-color: rgba(176, 30, 104, 0.05);
                color: #B01E68;
                transform: translateY(-2px);
            }

            .search-form {
                width: 100%;
                max-width: 400px;
                transition: all 0.3s ease;
            }

            .search-form:focus-within {
                transform: translateY(-2px);
            }

            .search-form .input-group {
                width: 100%;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }

            .search-form .form-control {
                border-radius: 20px 0 0 20px;
                border: 1px solid #B01E68;
                padding-left: 20px;
            }

            .search-form .btn {
                border-radius: 0 20px 20px 0;
                border: 1px solid #B01E68;
                color: #B01E68;
            }

            /* Products Page Specific CSS */
            .products-header {
                text-align: center;
                margin-bottom: 40px;
            }
            .products-header img{
                width: 1080px;
                height: 600px;
                margin-bottom: 1cm;
            }

            .filter-section {
                margin-bottom: 30px;
                padding: 15px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }

            .products-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
                margin-bottom: 40px;
            }

            .product-card {
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                border-radius: 8px;
                overflow: hidden;
                transition: transform 0.3s;
                background: white;
            }

            .product-card:hover {
                transform: translateY(-5px);
            }

            .product-image {
                position: relative;
                padding-top: 100%;
                overflow: hidden;
            }

            .product-image img {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .product-info {
                padding: 15px;
            }

            .product-title {
                font-size: 1rem;
                color: var(--text-color);
                margin-bottom: 10px;
                height: 2.4em;
                overflow: hidden;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
            }

            .product-price {
                color: var(--price-color);
                font-weight: 600;
                margin-bottom: 15px;
            }

            /* CSS cho liên kết sản phẩm */
            .product-link {
                text-decoration: none;
                color: inherit;
                display: block;
                cursor: pointer;
            }

            .product-title-link {
                text-decoration: none;
                color: var(--text-color);
                display: block;
            }

            .product-title-link:hover .product-title {
                color: var(--primary-color);
            }

            .product-card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                cursor: pointer;
            }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }

            /* Đảm bảo nút "Thêm vào giỏ" vẫn hoạt động độc lập */
            .add-to-cart {
                position: relative;
                z-index: 2;
            }

            .load-more {
                text-align: center;
                margin: 40px 0;
            }

            .load-more button {
                padding: 10px 30px;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 25px;
                transition: all 0.3s ease;
            }

            .load-more button:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }

            /* Footer Styles */
            footer {
                background-color: #f8f9fa;
                color: #6c757d;
                width: 100%;
                margin: 0;
                padding: 0;
            }

            .footer-content {
                background-color: #f8f9fa;
                width: 100%;
                margin: 0;
                padding: 0;
            }

            .footer-copyright {
                background-color: #f8f9fa;
                border-top: 1px solid #dee2e6;
                width: 100%;
                margin: 0;
                padding: 0;
            }

            /* Reset container-fluid padding */
            .footer-content .container-fluid,
            .footer-copyright .container-fluid {
                padding-left: 0;
                padding-right: 0;
            }

            footer h5 {
                font-weight: 600;
                margin-bottom: 1.5rem;
            }

            .footer-links a {
                color: #6c757d;
                transition: all 0.3s ease;
                display: inline-block;
            }

            .footer-links a:hover {
                color: var(--primary-color);
                transform: translateX(5px);
            }

            .social-links a {
                color: #6c757d;
                transition: all 0.3s ease;
            }

            .social-links a:hover {
                color: var(--primary-color);
            }

            .footer-contact i {
                color: var(--primary-color);
            }

            .footer-contact p {
                color: #6c757d;
                margin-bottom: 0;
            }

            .btn-outline-secondary {
                border: 1px solid #dee2e6;
                color: #6c757d;
                background-color: white;
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            .btn-outline-secondary:hover {
                background-color: #f8f9fa;
                border-color: #dee2e6;
                color: #6c757d;
            }

            .dropdown-menu {
                border: 1px solid #dee2e6;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                padding: 0.5rem 0;
            }

            .dropdown-item {
                padding: 0.5rem 1rem;
                color: #6c757d;
            }

            .dropdown-item:hover {
                background-color: #f8f9fa;
            }



            @media (max-width: 1200px) {
                .products-grid {
                    grid-template-columns: repeat(3, 1fr);
                }
            }

            @media (max-width: 991.98px) {
                .products-grid {
                    grid-template-columns: repeat(2, 1fr);
                }

                .navbar-collapse {
                    background: white;
                    padding: 1rem;
                    border-radius: 10px;
                    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                    margin-top: 1rem;
                }
            }

            @media (max-width: 575.98px) {
                .products-grid {
                    grid-template-columns: 1fr;
                }
            }
            /* Cart Offcanvas Styles */
            .offcanvas {
                width: 350px;
            }

            .cart-item {
                display: flex;
                align-items: center;
                padding: 10px 0;
                border-bottom: 1px solid #eee;
            }

            .cart-item img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                margin-right: 10px;
                border-radius: 4px;
            }

            .cart-item-details {
                flex-grow: 1;
            }

            .cart-item-title {
                font-size: 0.9rem;
                margin-bottom: 5px;
                color: var(--text-color);
            }

            .cart-item-price {
                color: var(--price-color);
                font-weight: 600;
                margin-bottom: 5px;
            }

            .cart-item-quantity {
                display: flex;
                align-items: center;
            }

            .quantity-btn {
                border: 1px solid #ddd;
                background: #f8f9fa;
                width: 25px;
                height: 25px;
                border-radius: 4px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                font-weight: bold;
                margin: 0 5px;
            }

            .cart-total {
                border-top: 1px solid #eee;
                padding-top: 15px;
            }

            .cart-total h6 {
                display: flex;
                justify-content: space-between;
                color: var(--text-color);
                font-weight: 600;
            }

            .total-amount {
                color: var(--price-color);
                font-weight: 700;
            }

            /* Toast notification */
            .toast {
                background-color: #fff;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            }

            /* Stock indicator styles */
            .stock {
                font-size: 0.9em;
                margin: 5px 0;
            }

            .in-stock {
                color: #2ecc71;
            }

            .low-stock {
                color: #f1c40f;
            }

            .out-stock {
                color: #e74c3c;
            }

        </style>
    </head>
    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container">
                <a class="navbar-brand" href="javascript:void(0);" onclick="window.location.href = '${pageContext.request.contextPath}/home';">
                    <img src="${pageContext.request.contextPath}/resources/logo.png" alt="Kingdoms Toys">
                </a>


                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <!-- Search Bar -->
                    <form action="search" method="post" class="d-flex mx-auto search-form">
                        <input type="hidden" name="source" value="product">
                        <div class="input-group">
                            <input name="txt" class="form-control" type="text" placeholder="Tìm kiếm sản phẩm..." aria-label="Search">
                            <button class="btn btn-outline-danger" type="submit">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </form>


                    <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="home">Trang chủ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="products">Sản phẩm</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="contact.jsp">Liên hệ</a>
                        </li>
                    </ul>

                    <ul class="navbar-nav auth-links">
                        <c:choose>
                            <c:when test="${empty sessionScope.user}">
                                <li class="nav-item">
                                    <a class="nav-link" href="login.jsp">Đăng nhập</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="signup.jsp">Đăng ký</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle"></i> ${sessionScope.user.fullName}
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <c:if test="${sessionScope.isAdmin == true || sessionScope.isStaff == true}">
                                            <li><a class="dropdown-item" href="admin.jsp">Quản lý</a></li>
                                            </c:if>
                                            <li><a class="dropdown-item" href="profile">Profile</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="my-orders">Đơn hàng</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="logout">Đăng xuất</a></li>
                                    </ul>
                                </li>
                            </c:otherwise>
                        </c:choose>
                        <li class="nav-item">
                            <a class="nav-link position-relative cart-icon" href="#" data-bs-toggle="offcanvas" data-bs-target="#cartOffcanvas">
                                <i class="bi bi-cart3"></i>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    0
                                </span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Products Content -->
        <div class="container mt-5">
            <div class="products-header">
                <img src="${pageContext.request.contextPath}/resources/product.png" alt="product banner"/>
                <h1>Tất cả sản phẩm</h1>
                <p>Khám phá bộ sưu tập đồ chơi độc đáo của chúng tôi</p>
            </div>

            <!-- Filter Section -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="d-flex justify-content-start mb-4">
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-secondary d-flex align-items-center gap-2">
                            <i class="bi bi-funnel"></i>
                            Filter
                        </button>

                        <div class="dropdown">
                            <!-- Dropdown Loại sản phẩm -->
                            <div class="dropdown">
                                <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="categoryDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    Loại sản phẩm
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="categoryDropdown">
                                    <li><a class="dropdown-item ${categoryId == null ? 'active' : ''}" href="products">Tất cả</a></li>
                                        <c:forEach items="${categories}" var="category">
                                        <li><a class="dropdown-item ${categoryId == category.key ? 'active' : ''}" 
                                               href="products?category=${category.key}${not empty sortBy ? '&sort='.concat(sortBy) : ''}">
                                                ${category.value} (${categoryCounts[category.key] != null ? categoryCounts[category.key] : 0})
                                            </a></li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </div>


                    </div>
                </div>
                <div class="d-flex justify-content-end mb-4">
                    <div class="d-flex align-items-center gap-2">
                        <span class="text-secondary">Sắp Xếp</span>
                        <div class="dropdown">
                            <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                <c:choose>
                                    <c:when test="${sortBy == 'price_asc'}">Giá: Thấp Tới Cao</c:when>
                                    <c:when test="${sortBy == 'price_desc'}">Giá: Cao Tới Thấp</c:when>
                                    <c:when test="${sortBy == 'name_asc'}">Bảng chữ cái A-Z</c:when>
                                    <c:when test="${sortBy == 'newest'}">Mới nhất</c:when>
                                    <c:when test="${sortBy == 'best_selling'}">Bán chạy nhất</c:when>
                                    <c:otherwise>Đề Xuất</c:otherwise>
                                </c:choose>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item ${empty sortBy ? 'active' : ''}" 
                                       href="products${not empty roleId ? '?role='.concat(roleId) : ''}">
                                        Đề Xuất
                                    </a></li>
                                <li><a class="dropdown-item ${sortBy == 'price_asc' ? 'active' : ''}" 
                                       href="products?sort=price_asc${not empty roleId ? '&role='.concat(roleId) : ''}">
                                        Giá: Thấp Tới Cao
                                    </a></li>
                                <li><a class="dropdown-item ${sortBy == 'price_desc' ? 'active' : ''}" 
                                       href="products?sort=price_desc${not empty roleId ? '&role='.concat(roleId) : ''}">
                                        Giá: Cao Tới Thấp
                                    </a></li>
                                <li><a class="dropdown-item ${sortBy == 'name_asc' ? 'active' : ''}" 
                                       href="products?sort=name_asc${not empty roleId ? '&role='.concat(roleId) : ''}">
                                        Bảng chữ cái A-Z
                                    </a></li>
                                <li><a class="dropdown-item ${sortBy == 'newest' ? 'active' : ''}" 
                                       href="products?sort=newest${not empty roleId ? '&role='.concat(roleId) : ''}">
                                        Mới nhất
                                    </a></li>
                                <li><a class="dropdown-item ${sortBy == 'best_selling' ? 'active' : ''}" 
                                       href="products?sort=best_selling${not empty roleId ? '&role='.concat(roleId) : ''}">
                                        Bán chạy nhất
                                    </a></li>
                            </ul>

                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>




    <!-- Products Grid -->
    <div class="container mt-5">
        <!-- Hiển thị tất cả sản phẩm -->
        <div class="col-12">
            <h3 class="mb-3">Tất cả sản phẩm</h3>
            <div class="row">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach items="${products}" var="product">
                            <div class="col-md-3 mb-4">
                                <div class="product-card">
                                    <!-- Thêm thẻ a để bao quanh hình ảnh sản phẩm -->
                                    <a href="product-detail?id=${product.productId}" class="product-link">
                                        <div class="product-image">
                                            <c:choose>
                                                <c:when test="${not empty product.imageUrl}">
                                                    <img src="${pageContext.request.contextPath}/${product.imageUrl}" 
                                                         alt="${product.name}">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/resources/no-image.png" 
                                                         alt="${product.name}">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </a>
                                    <div class="product-info">
                                        <!-- Thêm thẻ a cho tên sản phẩm -->
                                        <a href="product-detail?id=${product.productId}" class="product-title-link">
                                            <h3 class="product-title">${product.name}</h3>
                                        </a>
                                        <p class="product-price">
                                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/>
                                        </p>

                                        <!-- Hiển thị số lượng bán -->
                                        <p class="sold-count">Đã bán: ${product.soldCount}</p> <!-- Thêm dòng này để hiển thị số lượng bán -->

                                        <!-- Hiển thị trạng thái tồn kho -->
                                        <c:choose>
                                            <c:when test="${product.stockQuantity > 10}">
                                                <p class="stock in-stock">Còn hàng (${product.stockQuantity})</p>
                                            </c:when>
                                            <c:when test="${product.stockQuantity > 0 && product.stockQuantity <= 10}">
                                                <p class="stock low-stock">Sắp hết hàng (Còn ${product.stockQuantity})</p>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="stock out-stock">Hết hàng</p>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Nút thêm vào giỏ -->
                                        <c:choose>
                                            <c:when test="${product.stockQuantity > 0}">
                                                <button class="btn btn-primary w-100 add-to-cart" 
                                                        data-id="${product.productId}">
                                                    <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-secondary w-100" disabled>
                                                    Hết hàng
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center">
                            <p>Không tìm thấy sản phẩm nào.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>

    <!-- Phân trang - giữ nguyên không thay đổi -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Page navigation" class="mt-4">
            <ul class="pagination justify-content-center">
                <!-- Nút Previous -->
                <c:choose>
                    <c:when test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="products?page=${currentPage - 1}${not empty categoryId ? '&category='.concat(categoryId) : ''}${not empty sortBy ? '&sort='.concat(sortBy) : ''}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item disabled">
                            <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <!-- Các số trang -->
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${currentPage == i}">
                            <li class="page-item active">
                                <a class="page-link" href="#">${i}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="products?page=${i}${not empty categoryId ? '&category='.concat(categoryId) : ''}${not empty sortBy ? '&sort='.concat(sortBy) : ''}">${i}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!-- Nút Next -->
                <c:choose>
                    <c:when test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="products?page=${currentPage + 1}${not empty categoryId ? '&category='.concat(categoryId) : ''}${not empty sortBy ? '&sort='.concat(sortBy) : ''}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item disabled">
                            <a class="page-link" href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
    </c:if>


    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="container-fluid p-0">
                <div class="container py-5">
                    <div class="row g-4">
                        <div class="col-lg-4 col-md-6">
                            <h5 class="mb-4" style="color: var(--text-color);">Về Kingdoms Toys</h5>
                            <div class="footer-about">
                                <img src="${pageContext.request.contextPath}/resources/logo.png" 
                                     alt="Kingdoms Toys" 
                                     class="mb-3" 
                                     style="max-height: 60px;">
                                <p class="mb-4">Chúng tôi là đơn vị chuyên cung cấp các sản phẩm đồ chơi chất lượng cao, 
                                    mang đến niềm vui và trải nghiệm tuyệt vời cho người sưu tầm.</p>
                                <div class="social-links">
                                    <a href="#" class="me-3 text-decoration-none">
                                        <i class="bi bi-facebook fs-5"></i>
                                    </a>
                                    <a href="#" class="me-3 text-decoration-none">
                                        <i class="bi bi-instagram fs-5"></i>
                                    </a>
                                    <a href="#" class="me-3 text-decoration-none">
                                        <i class="bi bi-tiktok fs-5"></i>
                                    </a>
                                    <a href="#" class="text-decoration-none">
                                        <i class="bi bi-youtube fs-5"></i>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6">
                            <h5 class="mb-4" style="color: var(--text-color);">Liên kết nhanh</h5>
                            <div class="row">
                                <div class="col-6">
                                    <ul class="list-unstyled footer-links">
                                        <li class="mb-2">
                                            <a href="#" class="text-decoration-none text-secondary">
                                                <i class="bi bi-chevron-right me-2"></i>Trang chủ
                                            </a>
                                        </li>
                                        <li class="mb-2">
                                            <a href="#" class="text-decoration-none text-secondary">
                                                <i class="bi bi-chevron-right me-2"></i>Sản phẩm
                                            </a>
                                        </li>
                                        <li class="mb-2">
                                            <a href="#" class="text-decoration-none text-secondary">
                                                <i class="bi bi-chevron-right me-2"></i>Về chúng tôi
                                            </a>
                                        </li>
                                        <li class="mb-2">
                                            <a href="#" class="text-decoration-none text-secondary">
                                                <i class="bi bi-chevron-right me-2"></i>Liên hệ
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-6">
                                    <ul class="list-unstyled footer-links">
                                        <li class="mb-2">
                                            <a href="#" class="text-decoration-none text-secondary">
                                                <i class="bi bi-chevron-right me-2"></i>Chính sách
                                            </a>
                                        </li>
                                        <li class="mb-2">
                                            <a href="#" class="text-decoration-none text-secondary">
                                                <i class="bi bi-chevron-right me-2"></i>Điều khoản
                                            </a>
                                        </li>
                                        <li class="mb-2">
                                            <a href="#" class="text-decoration-none text-secondary">
                                                <i class="bi bi-chevron-right me-2"></i>FAQs
                                            </a>
                                        </li>
                                        <li class="mb-2">
                                            <a href="#" class="text-decoration-none text-secondary">
                                                <i class="bi bi-chevron-right me-2"></i>Blog
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6">
                            <h5 class="mb-4" style="color: var(--text-color);">Thông tin liên hệ</h5>
                            <div class="footer-contact">
                                <div class="d-flex mb-3">
                                    <i class="bi bi-geo-alt-fill me-3 fs-5"></i>
                                    <p class="mb-0">123 Đường ABC, Quận XYZ, TP.HCM</p>
                                </div>
                                <div class="d-flex mb-3">
                                    <i class="bi bi-envelope-fill me-3 fs-5"></i>
                                    <p class="mb-0">info@findingunicorn.com</p>
                                </div>
                                <div class="d-flex mb-3">
                                    <i class="bi bi-telephone-fill me-3 fs-5"></i>
                                    <p class="mb-0">(84) 123-456-789</p>
                                </div>
                                <div class="d-flex">
                                    <i class="bi bi-clock-fill me-3 fs-5"></i>
                                    <div>
                                        <p class="mb-0">Thứ 2 - Thứ 6: 09:00 - 21:00</p>
                                        <p class="mb-0">Thứ 7 - Chủ nhật: 09:00 - 18:00</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Copyright -->
        <div class="footer-copyright">
            <div class="container-fluid p-0">
                <div class="container">
                    <div class="row py-3">
                        <div class="col-md-6 text-center text-md-start">
                            <p class="mb-0">&copy; 2025 Kingdoms Toys. All rights reserved.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>


    <!-- Cart Offcanvas -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="cartOffcanvas">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title">Giỏ hàng</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body">
            <div class="cart-items">
                <!-- Cart items will be dynamically added here -->
            </div>
            <div class="cart-total mt-3">
                <h6>Tổng cộng: <span class="total-amount">0₫</span></h6>
            </div>
            <button id="checkout-btn" class="btn btn-primary w-100 mt-3">Thanh toán</button>
        </div>
    </div>



    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>

                    // Khởi tạo giỏ hàng từ localStorage hoặc mảng rỗng nếu chưa có
                    let cart = JSON.parse(localStorage.getItem('cart')) || [];
                    // Cập nhật hiển thị giỏ hàng khi trang tải
                    document.addEventListener('DOMContentLoaded', function () {
                        updateCartDisplay();
                        updateCartBadge();
                        // JavaScript để xử lý click vào sản phẩm
                        document.querySelectorAll('.product-card').forEach(card => {
                            card.addEventListener('click', function (e) {
                                // Ngăn chặn sự kiện click khi nhấn vào nút "Thêm vào giỏ"
                                if (e.target.closest('.add-to-cart') || e.target.closest('button')) {
                                    return;
                                }

                                // Lấy URL từ liên kết sản phẩm
                                const productLink = this.querySelector('.product-link');
                                if (productLink) {
                                    window.location.href = productLink.getAttribute('href');
                                }
                            });
                        });
                    });

                    document.querySelectorAll('.add-to-cart').forEach(button => {
                        button.addEventListener('click', function () {
                            const productId = this.dataset.id;
                            const productCard = this.closest('.product-card');
                            const productName = productCard.querySelector('.product-title').textContent.trim();
                            const productPriceText = productCard.querySelector('.product-price').textContent.trim();
                            // Xử lý chuỗi giá tiền để lấy số
                            // Cách sửa lỗi
                            const productPrice = parseFloat(productPriceText.replace(/[₫,]/g, '').replace('.', ',').replace(',', '.'));
                            const productImage = productCard.querySelector('.product-image img').src;
                            const product = {
                                id: productId,
                                name: productName,
                                price: productPrice,
                                image: productImage,
                                quantity: 1
                            };
                            addToCart(product);
                            // Hiển thị thông báo đã thêm vào giỏ
                            const toast = document.createElement('div');
                            toast.className = 'position-fixed bottom-0 end-0 p-3';
                            toast.style.zIndex = '5';
                            toast.innerHTML = `
                <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header">
                        <strong class="me-auto">Thông báo</strong>
                        <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
                    </div>
        <div class="toast-body">
                        Đã thêm ${productName} vào giỏ hàng!
                    </div>
                </div>
            `;
                            document.body.appendChild(toast);
                            setTimeout(() => {
                                toast.remove();
                            }, 3000);
                            // Mở giỏ hàng
                            var cartOffcanvas = new bootstrap.Offcanvas(document.getElementById('cartOffcanvas'));
                            cartOffcanvas.show();
                        });
                    });

                    function addToCart(product) {
                        console.log('Adding to cart:', product);
                        const existingItem = cart.find(item => item.id === product.id);
                        if (existingItem) {
                            existingItem.quantity++;
                        } else {
                            cart.push(product);
                        }

                        // Lưu giỏ hàng vào localStorage
                        localStorage.setItem('cart', JSON.stringify(cart));
                        console.log('Cart after update:', JSON.parse(localStorage.getItem('cart')));
                        updateCartBadge();
                        updateCartDisplay();
                    }

                    function updateCartBadge() {
                        const badge = document.querySelector('.badge');
                        const total = cart.reduce((sum, item) => sum + item.quantity, 0);
                        badge.textContent = total;
                    }

                    function updateCartDisplay() {
                        const cartItems = document.querySelector('.cart-items');
                        console.log('Updating cart display, cart items:', cart);
                        if (cart.length === 0) {
                            cartItems.innerHTML = '<p class="text-center my-4">Giỏ hàng trống</p>';
                            const checkoutBtn = document.querySelector('#checkout-btn');
                            if (checkoutBtn)
                                checkoutBtn.disabled = true;
                        } else {
                            let html = '';
                            cart.forEach(item => {
                                html += `
                <div class="cart-item">
                    <img src="\${item.image}" alt="\${item.name}">
                    <div class="cart-item-details">
                        <h6 class="cart-item-title">\${item.name}</h6>
                            <p class="cart-item-price">\${formatCurrency(item.price)}</p>
                        <div class="cart-item-quantity">
                            <button class="quantity-btn" onclick="updateQuantity('\${item.id}', -1)">-</button>
                            <span>\${item.quantity}</span>
                            <button class="quantity-btn" onclick="updateQuantity('\${item.id}', 1)">+</button>
                            <button class="btn btn-sm btn-danger ms-2" onclick="removeItem('\${item.id}')">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    </div>
                </div>
                            `;
                            });
                            cartItems.innerHTML = html;
                            console.log('Cart HTML:', html);
                            const checkoutBtn = document.querySelector('#checkout-btn');
                            if (checkoutBtn)
                                checkoutBtn.disabled = false;
                        }

                        updateCartTotal();
                    }

                    function updateQuantity(id, change) {
                        const item = cart.find(item => item.id === id);
                        if (item) {
                            item.quantity += change;
                            if (item.quantity <= 0) {
                                cart = cart.filter(i => i.id !== id);
                            }

                            // Lưu giỏ hàng vào localStorage
                            localStorage.setItem('cart', JSON.stringify(cart));
                            updateCartDisplay();
                            updateCartBadge();
                        }
                    }

                    function removeItem(id) {
                        cart = cart.filter(item => item.id !== id);
                        // Lưu giỏ hàng vào localStorage
                        localStorage.setItem('cart', JSON.stringify(cart));
                        updateCartDisplay();
                        updateCartBadge();
                    }

                    function updateCartTotal() {
                        const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
                        document.querySelector('.total-amount').textContent = formatCurrency(total);
                    }

                    function formatCurrency(amount) {
                        return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
                    }

                    // Thêm sự kiện cho nút thanh toán
                    document.addEventListener('DOMContentLoaded', function () {
                        const checkoutBtn = document.querySelector('#checkout-btn');
                        if (checkoutBtn) {
                            checkoutBtn.addEventListener('click', function () {
                                if (cart.length > 0) {
                                    // Chuyển đến trang thanh toán
                                    window.location.href = 'checkout';
                                }
                            });
                        }
                    });
    </script>


</body>
</html>
