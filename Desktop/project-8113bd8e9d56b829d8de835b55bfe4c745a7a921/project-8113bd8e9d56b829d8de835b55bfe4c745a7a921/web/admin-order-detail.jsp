<%-- 
    Document   : admin-order-detail
    Created on : Mar 10, 2025, 8:53:45 AM
    Author     : IUHADU
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Đơn hàng #${order.orderId}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 56px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            margin-bottom: 20px;
        }
        .card-header {
            background: linear-gradient(45deg, #4e73df, #224abe);
            color: white;
            border-radius: 10px 10px 0 0;
            padding: 1.5rem;
        }
        .btn-back {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1>Chi tiết Đơn hàng #${order.orderId}</h1>

        <div class="card">
            <div class="card-header">Thông tin khách hàng</div>
            <div class="card-body">
                <p><strong>Tên khách hàng:</strong> ${orderUserName}</p>
                <p><strong>Email:</strong> ${orderUserEmail}</p>
                <p><strong>Số điện thoại:</strong> ${orderUserPhone}</p>
            </div>
        </div>

        <div class="card">
            <div class="card-header">Thông tin giao hàng</div>
            <div class="card-body">
                <p><strong>Người nhận:</strong> ${order.shippingName}</p>
                <p><strong>Số điện thoại:</strong> ${order.shippingPhone}</p>
                <p><strong>Địa chỉ giao hàng:</strong> ${order.shippingAddress}</p>
            </div>
        </div>

        <div class="card">
            <div class="card-header">Sản phẩm trong đơn hàng</div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${orderDetails}">
                                <tr>
                                    <td>${detail.productName}</td>
                                    <td><fmt:formatNumber value="${detail.unitPrice}" type="currency" currencySymbol="₫" /></td>
                                    <td>${detail.quantity}</td>
                                    <td><fmt:formatNumber value="${detail.unitPrice * detail.quantity}" type="currency" currencySymbol="₫" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3" class="text-end"><strong>Tổng cộng:</strong></td>
                                <td><strong><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" /></strong></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/admin-orders" class="btn btn-secondary btn-back">
            <i class="bi bi-arrow-left"></i> Quay lại
        </a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
