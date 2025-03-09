<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - Kingdoms Toys</title>
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
        
        .card-header {
            background-color: rgba(130, 119, 172, 0.1);
            border-bottom: none;
            padding: 15px 20px;
        }
        
        .product-image {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 5px;
        }
        
        .btn-primary {
            background-color: rgba(130, 119, 172, 1);
            border-color: rgba(130, 119, 172, 1);
        }
        
        .btn-primary:hover {
            background-color: rgba(110, 99, 152, 1);
            border-color: rgba(110, 99, 152, 1);
        }
        
        .price-text {
            color: #9B3C44;
            font-weight: 600;
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
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="products">Sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">Thanh toán</li>
            </ol>
        </nav>
        
        <div class="row mb-3">
            <div class="col">
                <h1 class="mb-4">Thanh toán</h1>
            </div>
        </div>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>
        
        <div class="row">
            <div class="col-lg-8">
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Giỏ hàng của bạn</h5>
                    </div>
                    <div class="card-body">
                        <!-- Cart items will be displayed here -->
                        <div id="cart-items-container">
                            <p>Đang tải giỏ hàng...</p>
                        </div>
                        
                        <div class="mt-4">
                            <h5>Tổng cộng: <span id="cart-total" class="price-text">0₫</span></h5>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Thông tin giao hàng</h5>
                    </div>
                    <div class="card-body">
                        <form id="checkout-form" action="checkout" method="post">
                            <input type="hidden" id="cartData" name="cartData">
                            
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Họ và tên</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" value="${sessionScope.user.fullName}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${sessionScope.user.email}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="phone" class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control" id="phone" name="phone" value="${sessionScope.user.phone}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="address" class="form-label">Địa chỉ giao hàng</label>
                                <textarea class="form-control" id="address" name="address" rows="3" required>${sessionScope.user.address}</textarea>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" id="place-order-btn" class="btn btn-primary">
                                    <i class="bi bi-bag-check"></i> Đặt hàng
                                </button>
                                <a href="products" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left"></i> Tiếp tục mua sắm
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Hàm định dạng tiền tệ
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND',
                minimumFractionDigits: 0
            }).format(amount);
        }
        
        // Hiển thị giỏ hàng
        function displayCart() {
            // Lấy giỏ hàng từ localStorage
            let cart = JSON.parse(localStorage.getItem('cart')) || [];
            
            const cartContainer = document.getElementById('cart-items-container');
            const totalElement = document.getElementById('cart-total');
            const placeOrderBtn = document.getElementById('place-order-btn');
            
            if (cart.length === 0) {
                cartContainer.innerHTML = '<p class="text-center my-4">Giỏ hàng của bạn đang trống.</p>';
                totalElement.textContent = '0₫';
                placeOrderBtn.disabled = true;
                return;
            }
            
            let tableHtml = '<div class="table-responsive"><table class="table align-middle">';
            tableHtml += '<thead><tr><th>Sản phẩm</th><th class="text-center">Đơn giá</th><th class="text-center">Số lượng</th><th class="text-center">Thành tiền</th></tr></thead><tbody>';
            
            let total = 0;
            cart.forEach(item => {
                const itemTotal = item.price * item.quantity;
                total += itemTotal;
                
                tableHtml += '<tr>' +
                    '<td>' +
                    '<div class="d-flex align-items-center">' +
                    '<img src="' + item.image + '" alt="' + item.name + '" class="product-image me-3">' +
                    '<span>' + item.name + '</span>' +
                    '</div>' +
                    '</td>' +
                    '<td class="text-center">' + formatCurrency(item.price) + '</td>' +
                    '<td class="text-center">' + item.quantity + '</td>' +
                    '<td class="text-center price-text">' + formatCurrency(itemTotal) + '</td>' +
                    '</tr>';
            });
            
            tableHtml += '</tbody></table></div>';
            cartContainer.innerHTML = tableHtml;
            totalElement.textContent = formatCurrency(total);
            
            // Chuyển đổi dữ liệu giỏ hàng từ localStorage sang định dạng phù hợp với model CartItem
            const cartItems = cart.map(item => ({
                productId: parseInt(item.id),
                name: item.name,
                price: item.price,
                quantity: item.quantity,
                imageUrl: item.image
            }));
            
            // Lưu dữ liệu vào form để gửi lên server
            document.getElementById('cartData').value = JSON.stringify(cartItems);
            placeOrderBtn.disabled = false;
        }
        
        // Khởi tạo khi trang load xong
        document.addEventListener('DOMContentLoaded', function() {
            displayCart();
            
            // Xử lý form submit
            document.getElementById('checkout-form').addEventListener('submit', function(e) {
                let cart = JSON.parse(localStorage.getItem('cart')) || [];
                if (cart.length === 0) {
                    e.preventDefault();
                    alert('Giỏ hàng của bạn đang trống!');
                }
            });
        });
    </script>
</body>
</html>
