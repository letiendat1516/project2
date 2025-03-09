<%-- 
    Document   : order-confirmation
    Created on : Mar 9, 2025, 2:26:00 PM
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
    <title>Đặt hàng thành công - Kingdoms Toys</title>
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
        }
        
        .success-icon {
            font-size: 5rem;
            color: #28a745;
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
        
        .progress {
            height: 10px;
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
        <!-- Progress bar -->
        <div class="progress mb-4">
            <div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
        </div>
        
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card text-center p-5">
                    <div class="card-body">
                        <i class="bi bi-check-circle-fill success-icon mb-4"></i>
                        <h2 class="card-title mb-3">Đặt hàng thành công!</h2>
                        <p class="card-text mb-2">Đơn hàng của bạn đã được tạo thành công.</p>
                        <p class="card-text mb-4">Mã đơn hàng: <span class="order-id">${param.id}</span></p>
                        <p class="card-text">Chúng tôi sẽ xử lý đơn hàng của bạn trong thời gian sớm nhất.</p>
                        <p class="card-text mb-4">Một email xác nhận đã được gửi đến địa chỉ email của bạn.</p>
                        
                        <div class="d-grid gap-2 col-md-6 mx-auto">
                            <a href="user-orders" class="btn btn-outline-primary mb-2">
                                <i class="bi bi-bag"></i> Xem đơn hàng của tôi
                            </a>
                            <a href="home" class="btn btn-primary">
                                <i class="bi bi-house"></i> Quay về trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <c:if test="${sessionScope.clearCart}">
    <script>
        // Xóa giỏ hàng sau khi đặt hàng thành công
        localStorage.removeItem('cart');
        
        <% session.removeAttribute("clearCart"); %>
    </script>
    </c:if>
</body>
</html>
