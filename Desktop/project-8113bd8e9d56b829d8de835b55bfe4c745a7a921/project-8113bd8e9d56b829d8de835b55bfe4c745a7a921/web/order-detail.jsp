<%-- 
    Document   : order-detail
    Created on : Mar 9, 2025, 9:39:54 PM
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
    <title>Chi tiết đơn hàng - Kingdoms Toys</title>
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
        
        .product-image {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 5px;
        }
        
        .price-text {
            color: #9B3C44;
            font-weight: 600;
        }
        
        .tracking-container {
            position: relative;
            margin-top: 30px;
            margin-bottom: 30px;
        }
        
        .tracking-line {
            position: absolute;
            top: 30px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: #dee2e6;
            z-index: 1;
        }
        
        .tracking-steps {
            position: relative;
            z-index: 2;
            display: flex;
            justify-content: space-between;
        }
        
        .tracking-step {
            text-align: center;
            width: 60px;
        }
        
        .tracking-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: #fff;
            border: 2px solid #dee2e6;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }
        
        .tracking-icon i {
            font-size: 1.5rem;
            color: #dee2e6;
        }
        
        .tracking-step.active .tracking-icon {
            border-color: rgba(130, 119, 172, 1);
            background-color: rgba(130, 119, 172, 0.1);
        }
        
        .tracking-step.active .tracking-icon i {
            color: rgba(130, 119, 172, 1);
        }
        
        .tracking-step.completed .tracking-icon {
            border-color: #28a745;
            background-color: #28a745;
        }
        
        .tracking-step.completed .tracking-icon i {
            color: #fff;
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
            <h1>Chi tiết đơn hàng #<span class="order-id">${order.orderId}</span></h1>
            <a href="my-orders" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>
        </div>
        
        <div class="row">
            <div class="col-lg-8">
                <!-- Order status tracking -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Trạng thái đơn hàng</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <p class="mb-0">Đặt hàng lúc: <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
                            <span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span>
                        </div>
                        
                        <div class="tracking-container">
                            <div class="tracking-line"></div>
                            <div class="tracking-steps">
                                <div class="tracking-step ${order.status eq 'Pending' || order.status eq 'Processing' || order.status eq 'Shipped' || order.status eq 'Delivered' ? 'completed' : ''}">
                                    <div class="tracking-icon">
                                        <i class="bi bi-cart-check"></i>
                                    </div>
                                    <p>Đặt hàng</p>
                                </div>
                                <div class="tracking-step ${order.status eq 'Processing' || order.status eq 'Shipped' || order.status eq 'Delivered' ? 'completed' : order.status eq 'Pending' ? 'active' : ''}">
                                    <div class="tracking-icon">
                                        <i class="bi bi-box-seam"></i>
                                    </div>
                                    <p>Xử lý</p>
                                </div>
                                <div class="tracking-step ${order.status eq 'Shipped' || order.status eq 'Delivered' ? 'completed' : order.status eq 'Processing' ? 'active' : ''}">
                                    <div class="tracking-icon">
                                        <i class="bi bi-truck"></i>
                                    </div>
                                    <p>Giao hàng</p>
                                </div>
                                <div class="tracking-step ${order.status eq 'Delivered' ? 'completed' : order.status eq 'Shipped' ? 'active' : ''}">
                                    <div class="tracking-icon">
                                        <i class="bi bi-house-check"></i>
                                    </div>
                                    <p>Hoàn thành</p>
                                </div>
                            </div>
                        </div>
                        
                        <c:if test="${order.status eq 'Cancelled'}">
                            <div class="alert alert-danger mt-3">
                                <i class="bi bi-exclamation-triangle-fill"></i> Đơn hàng này đã bị hủy.
                            </div>
                        </c:if>
                        
                        <c:if test="${order.status eq 'Pending'}">
                            <div class="d-flex justify-content-end mt-3">
                                <a href="cancel-order?id=${order.orderId}" class="btn btn-outline-danger btn-sm" 
                                   onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">
                                    <i class="bi bi-x-circle"></i> Hủy đơn hàng
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
                
                <!-- Order items -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Sản phẩm đã đặt</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table align-middle">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th class="text-center">Đơn giá</th>
                                        <th class="text-center">Số lượng</th>
                                        <th class="text-center">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${orderDetails}">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <img src="${pageContext.request.contextPath}/${item.productImage}" alt="${item.productName}" class="product-image me-3">
                                                    <span>${item.productName}</span>
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫" pattern="#,##0 ₫"/>
                                            </td>
                                            <td class="text-center">${item.quantity}</td>
                                            <td class="text-center price-text">
                                                <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₫" pattern="#,##0 ₫"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th colspan="3" class="text-end">Tổng cộng:</th>
                                        <th class="text-center price-text">
                                            <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" pattern="#,##0 ₫"/>
                                        </th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4">
                <!-- Shipping information -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Thông tin giao hàng</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Người nhận:</strong> ${user.fullName}</p>
                        <p><strong>Địa chỉ:</strong> ${user.address}</p>
                        <p><strong>Số điện thoại:</strong> ${user.phone}</p>
                        <p><strong>Email:</strong> ${user.email}</p>
                    </div>
                </div>
                
                <!-- Order summary -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Tóm tắt đơn hàng</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tổng tiền sản phẩm:</span>
                            <span><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" pattern="#,##0 ₫"/></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Phí vận chuyển:</span>
                            <span>0 ₫</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between">
                            <span><strong>Tổng thanh toán:</strong></span>
                            <span class="price-text"><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" pattern="#,##0 ₫"/></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
