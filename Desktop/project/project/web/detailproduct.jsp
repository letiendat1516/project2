<%-- 
    Author     : DAT, KHANH, LINH
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
        <title>${product.name} - KINGDOMS TOYS</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />

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

            /* Product Detail Specific CSS */
            .breadcrumb {
                background-color: transparent;
                padding: 0;
                margin-bottom: 20px;
            }

            .breadcrumb-item a {
                color: var(--primary-color);
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .breadcrumb-item a:hover {
                color: #B01E68;
            }

            .breadcrumb-item.active {
                color: #6c757d;
            }

            .product-gallery {
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                margin-bottom: 30px;
                background-color: #fff;
                padding: 20px;
            }

            .product-main-image {
                width: 100%;
                height: 400px;
                object-fit: contain;
                border-radius: 8px;
                transition: transform 0.3s ease;
            }

            .product-main-image:hover {
                transform: scale(1.02);
            }

            .product-thumbnails {
                display: flex;
                gap: 10px;
                margin-top: 20px;
                overflow-x: auto;
                padding: 10px 0;
            }

            .product-thumbnail {
                width: 80px;
                height: 80px;
                border-radius: 5px;
                object-fit: cover;
                cursor: pointer;
                border: 2px solid transparent;
                transition: all 0.3s ease;
            }

            .product-thumbnail:hover,
            .product-thumbnail.active {
                border-color: var(--primary-color);
                transform: translateY(-3px);
                box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            }

            .product-info {
                padding: 20px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            }

            .product-title {
                color: var(--text-color);
                font-size: 2rem;
                margin-bottom: 15px;
                font-weight: 600;
            }

            .product-price {
                color: var(--price-color);
                font-size: 1.8rem;
                font-weight: 600;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
            }

            .original-price {
                text-decoration: line-through;
                color: #6c757d;
                font-size: 1.2rem;
                margin-right: 15px;
            }

            .discount-badge {
                background-color: #dc3545;
                color: white;
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.9rem;
                margin-left: 15px;
            }

            .product-rating {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }

            .product-rating .stars {
                color: #FFD700;
                margin-right: 10px;
            }

            .product-rating .reviews {
                color: #6c757d;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .product-rating .reviews:hover {
                color: var(--primary-color);
            }

            .product-description {
                margin-bottom: 30px;
                line-height: 1.8;
                color: #555;
            }

            .product-meta {
                margin-bottom: 30px;
                padding: 15px 0;
                border-top: 1px solid #eee;
                border-bottom: 1px solid #eee;
            }

            .product-meta p {
                margin-bottom: 10px;
                display: flex;
                align-items: center;
            }

            .product-meta i {
                color: var(--primary-color);
                margin-right: 10px;
            }

            .product-meta span {
                font-weight: 600;
                color: var(--text-color);
                margin-right: 5px;
            }

            .stock-status {
                display: inline-block;
                padding: 5px 15px;
                border-radius: 20px;
                font-weight: 500;
                margin-bottom: 20px;
            }

            .in-stock {
                background-color: rgba(40, 167, 69, 0.1);
                color: #28a745;
                border: 1px solid rgba(40, 167, 69, 0.2);
            }

            .low-stock {
                background-color: rgba(255, 193, 7, 0.1);
                color: #ffc107;
                border: 1px solid rgba(255, 193, 7, 0.2);
            }

            .out-stock {
                background-color: rgba(220, 53, 69, 0.1);
                color: #dc3545;
                border: 1px solid rgba(220, 53, 69, 0.2);
            }

            .quantity-selector {
                display: flex;
                align-items: center;
                margin-bottom: 30px;
            }

            .quantity-selector .btn {
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #f8f9fa;
                border: 1px solid #dee2e6;
                color: var(--text-color);
                transition: all 0.3s ease;
            }

            .quantity-selector .btn:hover {
                background-color: var(--primary-color);
                color: white;
            }

            .quantity-selector input {
                width: 60px;
                height: 40px;
                text-align: center;
                border: 1px solid #dee2e6;
                margin: 0 5px;
            }

            .product-actions {
                display: flex;
                gap: 15px;
                margin-bottom: 30px;
            }

            .product-actions .btn {
                padding: 12px 25px;
                border-radius: 25px;
                font-weight: 500;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

            .product-actions .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                flex-grow: 2;
            }

            .product-actions .btn-primary:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(130, 119, 172, 0.4);
            }

            .product-actions .btn-outline-secondary {
                border: 1px solid #dee2e6;
                color: #6c757d;
            }

            .product-actions .btn-outline-secondary:hover {
                background-color: #f8f9fa;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            }

            .product-share {
                display: flex;
                align-items: center;
                margin-bottom: 30px;
            }

            .product-share span {
                margin-right: 15px;
                font-weight: 500;
            }

            .product-share a {
                color: #6c757d;
                margin-right: 15px;
                transition: all 0.3s ease;
                width: 36px;
                height: 36px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #f8f9fa;
            }

            .product-share a:hover {
                color: white;
                background-color: var(--primary-color);
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            /* Product Tabs */
            .product-tabs {
                margin-top: 50px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                padding: 30px;
            }

            .nav-tabs {
                border-bottom: 1px solid #dee2e6;
                margin-bottom: 30px;
            }

            .nav-tabs .nav-link {
                color: #6c757d;
                border: none;
                border-bottom: 2px solid transparent;
                padding: 15px 20px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .nav-tabs .nav-link.active {
                color: var(--primary-color);
                border-bottom-color: var(--primary-color);
            }

            .tab-content {
                padding: 20px 0;
            }

            .tab-pane h4 {
                color: var(--text-color);
                margin-bottom: 20px;
            }

            .specifications-table {
                width: 100%;
                border-collapse: collapse;
            }

            .specifications-table tr {
                border-bottom: 1px solid #eee;
            }

            .specifications-table tr:last-child {
                border-bottom: none;
            }

            .specifications-table td {
                padding: 12px 15px;
            }

            .specifications-table td:first-child {
                font-weight: 500;
                color: var(--text-color);
                width: 30%;
            }

            /* Reviews Section */
            .review-item {
                margin-bottom: 30px;
                padding-bottom: 30px;
                border-bottom: 1px solid #eee;
            }

            .review-item:last-child {
                border-bottom: none;
            }

            .review-header {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }

            .reviewer-name {
                font-weight: 600;
                color: var(--text-color);
            }

            .review-date {
                color: #6c757d;
                font-size: 0.9rem;
            }
            .review-rating {
                color: #FFD700;
                margin-bottom: 10px;
            }

            .review-content {
                line-height: 1.8;
                color: #555;
            }

            .review-form {
                margin-top: 40px;
            }

            .review-form .form-control {
                border-radius: 20px;
                padding: 12px 20px;
                margin-bottom: 20px;
                border: 1px solid #dee2e6;
                transition: all 0.3s ease;
            }

            .review-form .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.25rem rgba(130, 119, 172, 0.25);
            }

            .review-form textarea {
                min-height: 150px;
                resize: vertical;
            }

            .review-form .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                padding: 12px 30px;
                border-radius: 25px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .review-form .btn-primary:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(130, 119, 172, 0.4);
            }

            /* Related Products */
            .related-products {
                margin-top: 50px;
            }

            .related-products h3 {
                color: var(--text-color);
                margin-bottom: 30px;
                text-align: center;
                font-weight: 600;
                position: relative;
                padding-bottom: 15px;
            }

            .related-products h3::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                width: 80px;
                height: 3px;
                background-color: var(--primary-color);
                transform: translateX(-50%);
            }

            .product-card {
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                margin-bottom: 30px;
                background-color: #fff;
                transition: all 0.3s ease;
            }

            .product-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            }

            .product-card-img {
                position: relative;
                overflow: hidden;
                height: 200px;
            }

            .product-card-img img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: all 0.5s ease;
            }

            .product-card:hover .product-card-img img {
                transform: scale(1.1);
            }

            .product-card-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.2);
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                transition: all 0.3s ease;
            }

            .product-card:hover .product-card-overlay {
                opacity: 1;
            }

            .product-card-overlay .btn {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 5px;
                transform: translateY(20px);
                opacity: 0;
                transition: all 0.3s ease;
            }

            .product-card:hover .product-card-overlay .btn {
                transform: translateY(0);
                opacity: 1;
            }

            .product-card-overlay .btn:hover {
                background-color: var(--primary-color);
                color: white;
            }

            .product-card-body {
                padding: 20px;
            }

            .product-card-title {
                font-weight: 600;
                margin-bottom: 10px;
                color: var(--text-color);
                text-decoration: none;
                transition: all 0.3s ease;
                display: block;
                height: 48px;
                overflow: hidden;
            }

            .product-card-title:hover {
                color: var(--primary-color);
            }

            .product-card-price {
                color: var(--price-color);
                font-weight: 600;
                font-size: 1.2rem;
                margin-bottom: 10px;
                display: flex;
                align-items: center;
            }

            .product-card-rating {
                color: #FFD700;
                margin-bottom: 10px;
            }

            .product-card-rating span {
                color: #6c757d;
                margin-left: 5px;
                font-size: 0.9rem;
            }

            /* Footer */
            footer {
                background-color: #f8f9fa;
                padding: 60px 0 30px;
                margin-top: 80px;
            }

            .footer-logo img {
                max-height: 80px;
                margin-bottom: 20px;
            }

            .footer-about p {
                margin-bottom: 20px;
                line-height: 1.8;
            }

            .footer-title {
                color: var(--text-color);
                font-weight: 600;
                margin-bottom: 25px;
                position: relative;
                padding-bottom: 10px;
            }

            .footer-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 50px;
                height: 2px;
                background-color: var(--primary-color);
            }

            .footer-links {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .footer-links li {
                margin-bottom: 15px;
            }

            .footer-links a {
                color: #777;
                text-decoration: none;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
            }

            .footer-links a i {
                margin-right: 10px;
                color: var(--primary-color);
            }

            .footer-links a:hover {
                color: var(--primary-color);
                transform: translateX(5px);
            }

            .footer-contact p {
                margin-bottom: 15px;
                display: flex;
                align-items: flex-start;
            }

            .footer-contact i {
                margin-right: 15px;
                color: var(--primary-color);
                margin-top: 5px;
            }

            .footer-social {
                display: flex;
                margin-top: 20px;
            }

            .footer-social a {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: #f1f1f1;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 10px;
                color: #777;
                transition: all 0.3s ease;
            }

            .footer-social a:hover {
                background-color: var(--primary-color);
                color: white;
                transform: translateY(-3px);
            }

            .footer-bottom {
                margin-top: 40px;
                padding-top: 20px;
                border-top: 1px solid #eee;
                text-align: center;
            }

            .footer-bottom p {
                margin-bottom: 0;
            }

            /* Responsive */
            @media (max-width: 991px) {
                body {
                    padding-top: 100px;
                }

                .navbar-brand img {
                    max-height: 70px;
                }

                .product-main-image {
                    height: 300px;
                }

                .product-title {
                    font-size: 1.5rem;
                }

                .product-price {
                    font-size: 1.5rem;
                }

                .product-actions {
                    flex-direction: column;
                }

                .product-actions .btn {
                    width: 100%;
                }
            }

            @media (max-width: 767px) {
                .product-tabs .nav-link {
                    padding: 10px 15px;
                }

                .product-gallery,
                .product-info {
                    margin-bottom: 20px;
                }

                .footer-widget {
                    margin-bottom: 30px;
                }
            }

            @media (max-width: 575px) {
                .product-main-image {
                    height: 250px;
                }

                .product-thumbnail {
                    width: 60px;
                    height: 60px;
                }

                .product-title {
                    font-size: 1.3rem;
                }

                .product-price {
                    font-size: 1.3rem;
                }

                .product-actions {
                    gap: 10px;
                }

                .product-tabs .nav-link {
                    padding: 8px 12px;
                    font-size: 0.9rem;
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

        </style>
    </head>
    <body>
        <!-- Header/Navbar -->
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

        <!-- Main Content -->
        <!-- Main Content -->
        <!-- Main Content -->
        <main class="container py-4">
            <!-- Debug Info - Chỉ hiển thị trong quá trình phát triển -->
            <c:if test="${param.debug == 'true'}">
                <div style="background-color: #f8d7da; padding: 10px; margin: 10px 0; border-radius: 5px;">
                    <h3>Debug Info:</h3>
                    <p>Product object exists: ${not empty product}</p>
                    <c:if test="${not empty product}">
                        <p>Product ID: ${product.productId}</p>
                        <p>Product Name: ${product.name}</p>
                        <p>Product Price: ${product.price}</p>
                        <p>Product Image URL: ${product.imageUrl}</p>
                        <p>Product Description: ${product.description}</p>
                        <p>Product Stock: ${product.stockQuantity}</p>
                    </c:if>
                </div>
            </c:if>

            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="products">Sản phẩm</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
                </ol>
            </nav>

            <!-- Product Detail -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="product-gallery">
                        <img src="${product.imageUrl}" alt="${product.name}" class="product-main-image" id="main-product-image">

                        <%-- Phần thumbnail có thể được thêm sau khi bạn có nhiều hình ảnh cho sản phẩm --%>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="product-info">
                        <h1 class="product-title">${product.name}</h1>

                        <div class="product-price">
                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                        </div>

                        <c:choose>
                            <c:when test="${product.stockQuantity > 10}">
                                <div class="stock-status in-stock">
                                    <i class="bi bi-check-circle"></i> Còn hàng
                                </div>
                            </c:when>
                            <c:when test="${product.stockQuantity > 0}">
                                <div class="stock-status low-stock">
                                    <i class="bi bi-exclamation-circle"></i> Còn ${product.stockQuantity} sản phẩm
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="stock-status out-stock">
                                    <i class="bi bi-x-circle"></i> Hết hàng
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <div class="product-description">
                            ${product.description}
                        </div>

                        <div class="product-meta">
                            <p><span>Mã sản phẩm:</span> SP${product.categoryId}</p>
                            <p><span>Danh mục:</span> 
                                <a href="products?role=${product.categoryId}">
                                    <%
                                        int categoryId = ((model.Product)pageContext.findAttribute("product")).getCategoryId();
                                        dal.CategoryDAO categoryDAO = new dal.CategoryDAO();
                                        model.Category category = categoryDAO.getCategoryById(categoryId);
                                        out.print(category != null ? category.getCategoryName() : "Đồ chơi");
                                    %>
                                </a>
                            </p>
                        </div>

                        <c:if test="${product.stockQuantity > 0}">
                            <div class="quantity-selector">
                                <span>Số lượng:</span>
                                <input type="number" id="quantity" value="1" min="1" max="${product.stockQuantity}">
                            </div>

                            <div class="product-actions">
                                <button class="btn btn-primary add-to-cart-btn" data-product-id="${product.productId}">
                                    <i class="bi bi-cart-plus"></i> Thêm vào giỏ hàng
                                </button>
                            </div>
                        </c:if>


                        <div class="product-share">
                            <span>Chia sẻ:</span>
                            <a href="#"><i class="bi bi-facebook"></i></a>
                            <a href="#"><i class="bi bi-twitter"></i></a>
                            <a href="#"><i class="bi bi-pinterest"></i></a>
                            <a href="#"><i class="bi bi-instagram"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product Tabs -->
            <div class="product-tabs">
                <ul class="nav nav-tabs" id="productTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button" role="tab" aria-controls="description" aria-selected="true">Mô tả</button>
                    </li>
                </ul>
                <div class="tab-content" id="productTabsContent">
                    <div class="tab-pane fade show active" id="description" role="tabpanel" aria-labelledby="description-tab">
                        <h4>Chi tiết sản phẩm</h4>
                        ${product.description}
                    </div>
                    
                </div>
            </div>

            <!-- Related Products -->
            <section class="related-products">
                <h3>Sản phẩm liên quan</h3>
                <div class="row">
                    <c:forEach items="${relatedProducts}" var="relatedProduct">
                        <div class="col-md-3 col-sm-6">
                            <div class="product-card">
                                <div class="product-card-img">
                                    <img src="${relatedProduct.imageUrl}" alt="${relatedProduct.name}">
                                    <div class="product-card-overlay">
                                        <a href="product-detail?id=${relatedProduct.productId}" class="btn"><i class="bi bi-eye"></i></a>
                                    </div>
                                </div>
                                <div class="product-card-body">
                                    <a href="product-detail?id=${relatedProduct.productId}" class="product-card-title">${relatedProduct.name}</a>
                                    <div class="product-card-price">
                                        <fmt:formatNumber value="${relatedProduct.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </main>

        <!-- Footer giữ nguyên -->

        <!-- Quick View Modal giữ nguyên -->

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

        <!-- Quick View Modal -->
        <div class="modal fade" id="quickViewModal" tabindex="-1" aria-labelledby="quickViewModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="quickViewModalLabel">Xem nhanh sản phẩm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="quickViewContent">
                        <!-- Content will be loaded dynamically -->
                    </div>
                </div>
            </div>
        </div>
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
        <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
        <script>
                    // Khởi tạo giỏ hàng
                    let cart = JSON.parse(localStorage.getItem('cart')) || [];

                    // Hàm thay đổi hình ảnh chính
                    function changeImage(src) {
                        const mainImage = document.getElementById('main-product-image');
                        if (mainImage) {
                            mainImage.src = src;
                            // Cập nhật thumbnail đang active
                            const thumbnails = document.querySelectorAll('.product-thumbnail');
                            thumbnails.forEach(thumbnail => {
                                thumbnail.classList.remove('active');
                                if (thumbnail.src === src) {
                                    thumbnail.classList.add('active');
                                }
                            });
                        }
                    }

                    // Các hàm xử lý giỏ hàng
                    function addToCart(product) {
                        const existingItem = cart.find(item => item.id === product.id);
                        if (existingItem) {
                            existingItem.quantity += product.quantity;
                        } else {
                            cart.push(product);
                        }
                        localStorage.setItem('cart', JSON.stringify(cart));
                        updateCartBadge();
                        updateCartDisplay();
                    }

                    function updateCartBadge() {
                        const badge = document.querySelector('.cart-icon .badge');
                        const total = cart.reduce((sum, item) => sum + item.quantity, 0);
                        if (badge) {
                            badge.textContent = total;
                        }
                    }

                    function updateCartDisplay() {
                        const cartItems = document.querySelector('.cart-items');
                        if (!cartItems)
                            return;

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
                            localStorage.setItem('cart', JSON.stringify(cart));
                            updateCartDisplay();
                            updateCartBadge();
                        }
                    }

                    function removeItem(id) {
                        cart = cart.filter(item => item.id !== id);
                        localStorage.setItem('cart', JSON.stringify(cart));
                        updateCartDisplay();
                        updateCartBadge();
                    }

                    function updateCartTotal() {
                        const totalElement = document.querySelector('.total-amount');
                        if (totalElement) {
                            const total = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
                            totalElement.textContent = formatCurrency(total);
                        }
                    }

                    function formatCurrency(amount) {
                        return new Intl.NumberFormat('vi-VN', {
                            style: 'currency',
                            currency: 'VND'
                        }).format(amount);
                    }

                    function showToast(message) {
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
                        \${message}
                    </div>
                </div>
            `;
                        document.body.appendChild(toast);
                        setTimeout(() => {
                            toast.remove();
                        }, 3000);
                    }

                    // Khởi tạo khi trang tải xong
                    document.addEventListener('DOMContentLoaded', function () {
                        // Cập nhật hiển thị giỏ hàng
                        updateCartDisplay();
                        updateCartBadge();

                        // Xử lý số lượng sản phẩm
                        const quantityInput = document.getElementById('quantity');
                        if (quantityInput) {
                            const quantityContainer = quantityInput.parentElement;
                            quantityContainer.innerHTML = `
                    <button class="btn btn-outline-secondary decrease-btn"><i class="bi bi-dash"></i></button>
                    <input type="number" id="quantity" value="1" min="1" max="\${quantityInput.getAttribute('max')}" class="form-control mx-2">
                    <button class="btn btn-outline-secondary increase-btn"><i class="bi bi-plus"></i></button>
                `;

                            const newQuantityInput = document.getElementById('quantity');
                            const decreaseBtn = document.querySelector('.decrease-btn');
                            const increaseBtn = document.querySelector('.increase-btn');

                            if (decreaseBtn) {
                                decreaseBtn.addEventListener('click', function () {
                                    let value = parseInt(newQuantityInput.value);
                                    if (value > 1) {
                                        newQuantityInput.value = value - 1;
                                    }
                                });
                            }

                            if (increaseBtn) {
                                increaseBtn.addEventListener('click', function () {
                                    let value = parseInt(newQuantityInput.value);
                                    let max = parseInt(newQuantityInput.getAttribute('max'));
                                    if (value < max) {
                                        newQuantityInput.value = value + 1;
                                    }
                                });
                            }

                            if (newQuantityInput) {
                                newQuantityInput.addEventListener('change', function () {
                                    let value = parseInt(this.value);
                                    const min = parseInt(this.getAttribute('min') || 1);
                                    const max = parseInt(this.getAttribute('max'));
                                    if (isNaN(value) || value < min) {
                                        this.value = min;
                                    } else if (value > max) {
                                        this.value = max;
                                    }
                                });
                            }
                        }

                        // Xử lý nút thêm vào giỏ hàng
                        const addToCartBtn = document.querySelector('.add-to-cart-btn');
                        if (addToCartBtn) {
                            addToCartBtn.addEventListener('click', function () {
                                const productId = this.dataset.productId;
                                const productName = document.querySelector('.product-title').textContent;
                                const productPriceText = document.querySelector('.product-price').textContent;
                                const productPrice = parseFloat(productPriceText.replace(/[₫,]/g, '').replace('.', ',').replace(',', '.'));
                                const productImage = document.querySelector('#main-product-image').src;
                                const quantity = parseInt(document.querySelector('#quantity').value);

                                const product = {
                                    id: productId,
                                    name: productName,
                                    price: productPrice,
                                    image: productImage,
                                    quantity: quantity
                                };

                                addToCart(product);
                                showToast(`Đã thêm \${productName} vào giỏ hàng!`);

                                // Mở giỏ hàng
                                const cartOffcanvas = new bootstrap.Offcanvas(document.getElementById('cartOffcanvas'));
                                cartOffcanvas.show();
                            });
                        }

                        // Xử lý nút thanh toán
                        const checkoutBtn = document.querySelector('#checkout-btn');
                        if (checkoutBtn) {
                            checkoutBtn.addEventListener('click', function () {
                                if (cart.length > 0) {
                                    window.location.href = 'checkout.jsp';
                                }
                            });
                        }
                    });
        </script>
    </body>
</html>
