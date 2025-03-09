<%-- 
    Document   : my-orders
    Created on : Mar 9, 2025, 9:25:35 PM
    Author     : IUHADU
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - Kingdoms Toys</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Karla', sans-serif;
            color: #777;
            background-color: #f8f9fa;
            padding-top: 80px;
        }
        
        .card {
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border: none;
            margin-bottom: 20px;
        }
        
        .card-header {
            background-color: rgba(130, 119, 172, 0.1);
            border-bottom: none;
            padding: 15px 20px;
        }
        
        .btn-primary {
            background-color: rgba(130, 119, 172, 1);
            border-color: rgba(130, 119, 172, 1);
        }
        
        .btn-primary:hover {
            background-color: rgba(110, 99, 152, 1);
            border-color: rgba(110, 99, 152, 1);
        }
        
        .order-id {
            font-weight: bold;
            color: #9B3C44;
        }
        
        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .status-pending {
            background-color: #FFF3CD;
            color: #856404;
        }
        
        .status-processing {
            background-color: #D1ECF1;
            color: #0C5460;
        }
        
        .status-shipped {
            background-color: #D4EDDA;
            color: #155724;
        }
        
        .status-delivered {
            background-color: #C3E6CB;
            color: #155724;
        }
        
        .status-cancelled {
            background-color: #F8D7DA;
            color: #721C24;
        }
        
        .empty-orders {
            text-align: center;
            padding: 50px 0;
        }
        
        .empty-orders i {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="home">
                <img src="${pageContext.request.contextPath}/resources/logo.png" alt="Kingdoms Toys" style="max-height: 50px;">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="home">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="products">Sản phẩm</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Đơn hàng của tôi</h1>
            <a href="home" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Trở về trang chủ
            </a>
        </div>
        
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="successMessage" scope="session" />
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="errorMessage" scope="session" />
        </c:if>
        
        <c:if test="${not empty orders}">
            <c:forEach var="order" items="${orders}">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-0">Đơn hàng #<span class="order-id">${order.orderId}</span></h5>
                            <small class="text-muted"><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></small>
                        </div>
                        <span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-8">
                                <p><strong>Tổng tiền:</strong> <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" pattern="#,##0 ₫"/></p>
                            </div>
                            <div class="col-md-4 text-end">
                                <a href="order-detail?id=${order.orderId}" class="btn btn-primary btn-sm">
                                    <i class="bi bi-eye"></i> Xem chi tiết
                                </a>
                                <c:if test="${order.status eq 'Pending'}">
                                    <a href="cancel-order?id=${order.orderId}" class="btn btn-outline-danger btn-sm ms-2" 
                                       onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">
                                        <i class="bi bi-x-circle"></i> Hủy đơn hàng
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty orders}">
            <div class="empty-orders">
                <i class="bi bi-bag-x"></i>
                <h3>Bạn chưa có đơn hàng nào</h3>
                <p>Hãy khám phá cửa hàng và đặt hàng ngay!</p>
                <a href="products" class="btn btn-primary mt-3">Mua sắm ngay</a>
            </div>
        </c:if>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
