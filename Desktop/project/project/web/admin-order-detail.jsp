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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn-back {
            margin-top: 20px;
        }
        .card-header .btn {
            margin-left: 10px;
        }
        .status-badge {
            font-size: 0.9rem;
            padding: 0.5rem 0.75rem;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1>Chi tiết Đơn hàng #${order.orderId}</h1>
        
        <!-- Hiển thị thông báo thành công/lỗi nếu có -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("successMessage"); %>
        </c:if>
        
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("errorMessage"); %>
        </c:if>

        <div class="card">
            <div class="card-header">
                <span>Thông tin khách hàng</span>
            </div>
            <div class="card-body">
                <p><strong>Tên khách hàng:</strong> ${orderUserName}</p>
                <p><strong>Email:</strong> ${orderUserEmail}</p>
                <p><strong>Số điện thoại:</strong> ${orderUserPhone}</p>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <span>Thông tin giao hàng</span>
                <button class="btn btn-sm btn-light" data-bs-toggle="modal" data-bs-target="#editShippingModal">
                    <i class="bi bi-pencil"></i> Sửa thông tin giao hàng
                </button>
            </div>
            <div class="card-body">
                <p><strong>Người nhận:</strong> ${order.shippingName}</p>
                <p><strong>Số điện thoại:</strong> ${order.shippingPhone}</p>
                <p><strong>Địa chỉ giao hàng:</strong> ${order.shippingAddress}</p>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <span>Thông tin đơn hàng</span>
            </div>
            <div class="card-body">
                <p><strong>Mã đơn hàng:</strong> #${order.orderId}</p>
                <p><strong>Ngày đặt hàng:</strong> <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" /></p>
                <p><strong>Trạng thái:</strong> ${order.status}</p>
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

        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/admin_orders" class="btn btn-secondary btn-back">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>
        </div>
    </div>

    <!-- Modal Sửa thông tin giao hàng -->
    <div class="modal fade" id="editShippingModal" tabindex="-1" aria-labelledby="editShippingModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editShippingModalLabel">Sửa thông tin giao hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin_orders" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${order.orderId}">
                        <input type="hidden" name="status" value="${order.status}">
                        
                        <div class="mb-3">
                            <label for="shippingName" class="form-label">Người nhận:</label>
                            <input type="text" class="form-control" id="shippingName" name="shippingName" value="${order.shippingName}" required>
                        </div>
                        <div class="mb-3">
                            <label for="shippingPhone" class="form-label">Số điện thoại:</label>
                            <input type="text" class="form-control" id="shippingPhone" name="shippingPhone" value="${order.shippingPhone}" required>
                        </div>
                        <div class="mb-3">
                            <label for="shippingAddress" class="form-label">Địa chỉ giao hàng:</label>
                            <textarea class="form-control" id="shippingAddress" name="shippingAddress" rows="3" required>${order.shippingAddress}</textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
