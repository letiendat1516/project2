<%-- 
    Document   : admin_orders
    Created on : Mar 10, 2025, 8:23:19 AM
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
    <title>Quản lý Đơn hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    <!-- Sweet Alert 2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
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

        /* Order specific styles */
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            margin: 20px 0;
        }

        .card-header {
            background: linear-gradient(45deg, #4e73df, #224abe);
            color: white;
            border-radius: 15px 15px 0 0 !important;
            padding: 1.5rem;
        }

        .btn-filter {
            background: linear-gradient(45deg, #36b9cc, #1a8a9c);
            border: none;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 7px;
            transition: all 0.3s;
        }

        .btn-filter:hover {
            background: linear-gradient(45deg, #1a8a9c, #0f7285);
            transform: translateY(-2px);
        }

        .table thead th {
            background-color: #f8f9fc;
            font-weight: 600;
        }

        .alert {
            border-radius: 10px;
            margin: 1rem 0;
        }

        /* Status Badge Styles */
        .badge {
            padding: 0.5em 1em;
            font-size: 0.875rem;
        }

        .badge-pending {
            background-color: var(--warning-color);
            color: #212529;
        }

        .badge-processing {
            background-color: var(--info-color);
            color: white;
        }

        .badge-shipped {
            background-color: var(--secondary-color);
            color: white;
        }

        .badge-delivered {
            background-color: var(--success-color);
            color: white;
        }

        .badge-cancelled {
            background-color: var(--danger-color);
            color: white;
        }

        /* Modal Styles */
        .modal-content {
            border-radius: 15px;
            border: none;
        }

        .modal-header {
            background: linear-gradient(45deg, #4e73df, #224abe);
            color: white;
            border-radius: 15px 15px 0 0;
            border-bottom: none;
        }

        .modal-footer {
            border-top: none;
        }

        /* Button Styles */
        .btn-sm {
            padding: 0.4rem 0.8rem;
            font-size: 0.875rem;
        }

        .btn-view {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .btn-edit {
            background-color: var(--warning-color);
            border-color: var(--warning-color);
            color: #212529;
        }

        .btn-delete {
            background-color: var(--danger-color);
            border-color: var(--danger-color);
            color: white;
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

        /* DataTables Custom Styles */
        .dataTables_wrapper .dataTables_paginate .paginate_button.current {
            background: var(--primary-color);
            color: white !important;
            border: none;
            border-radius: 5px;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
            background: var(--primary-color);
            color: white !important;
            border: none;
        }

        /* Status Dropdown */
        .dropdown-item {
            padding: 0.5rem 1rem;
            transition: all 0.2s;
        }

        .dropdown-item:hover {
            background-color: #f8f9fa;
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
                            <a class="nav-link active animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin_orders">
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
                <!-- Alert Messages -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible fade show animate__animated animate__fadeIn" role="alert">
                        ${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% session.removeAttribute("successMessage"); %>
                </c:if>

                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show animate__animated animate__fadeIn" role="alert">
                        ${sessionScope.errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% session.removeAttribute("errorMessage"); %>
                </c:if>

                <div class="card animate__animated animate__fadeIn">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Quản lý Đơn hàng</h5>
                        <div>
                            
                        </div>
                    </div>
                    <div class="card-body">
    <div class="table-responsive">
    <table id="ordersTable" class="table table-striped table-hover">
        <thead>
            <tr>
                <th>Mã đơn</th>
                <th>Ngày đặt</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${orders}" var="order">
                <tr>
                    <td>#${order.orderId}</td>
                    <td><fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${order.createdAt}" /></td>
                    <td><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" /></td>
                    <td>
                        <c:choose>
                            <c:when test="${order.status eq 'Pending'}">
                                <span class="badge badge-pending">Chờ xử lý</span>
                            </c:when>
                            <c:when test="${order.status eq 'Processing'}">
                                <span class="badge badge-processing">Đang xử lý</span>
                            </c:when>
                            <c:when test="${order.status eq 'Shipped'}">
                                <span class="badge badge-shipped">Đang giao</span>
                            </c:when>
                            <c:when test="${order.status eq 'Delivered'}">
                                <span class="badge badge-delivered">Đã giao</span>
                            </c:when>
                            <c:when test="${order.status eq 'Cancelled'}">
                                <span class="badge badge-cancelled">Đã hủy</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">${order.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <div class="btn-group">
                            <a href="${pageContext.request.contextPath}/admin_orders?action=view&id=${order.orderId}" class="btn btn-view btn-sm">
                                <i class="bi bi-eye"></i>
                            </a>
                            
                            <button class="btn btn-delete btn-sm" onclick="confirmDelete(${order.orderId})">
                                <i class="bi bi-trash"></i>
                            </button>
                            <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-three-dots"></i>
                            </button>
                            <ul class="dropdown-menu">
                                <li>
                                    <form action="${pageContext.request.contextPath}/admin_orders" method="post">
                                        <input type="hidden" name="action" value="update-status">
                                        <input type="hidden" name="id" value="${order.orderId}">
                                        <input type="hidden" name="status" value="Pending">
                                        <button type="submit" class="dropdown-item">Đánh dấu Chờ xử lý</button>
                                    </form>
                                </li>
                                <li>
                                    <form action="${pageContext.request.contextPath}/admin_orders" method="post">
                                        <input type="hidden" name="action" value="update-status">
                                        <input type="hidden" name="id" value="${order.orderId}">
                                        <input type="hidden" name="status" value="Processing">
                                        <button type="submit" class="dropdown-item">Đánh dấu Đang xử lý</button>
                                    </form>
                                </li>
                                <li>
                                    <form action="${pageContext.request.contextPath}/admin_orders" method="post">
                                        <input type="hidden" name="action" value="update-status">
                                        <input type="hidden" name="id" value="${order.orderId}">
                                        <input type="hidden" name="status" value="Shipped">
                                        <button type="submit" class="dropdown-item">Đánh dấu Đang giao</button>
                                    </form>
                                </li>
                                <li>
                                    <form action="${pageContext.request.contextPath}/admin_orders" method="post">
                                        <input type="hidden" name="action" value="update-status">
                                        <input type="hidden" name="id" value="${order.orderId}">
                                        <input type="hidden" name="status" value="Delivered">
                                        <button type="submit" class="dropdown-item">Đánh dấu Đã giao</button>
                                    </form>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <form action="${pageContext.request.contextPath}/admin_orders" method="post">
                                        <input type="hidden" name="action" value="update-status">
                                        <input type="hidden" name="id" value="${order.orderId}">
                                        <input type="hidden" name="status" value="Cancelled">
                                        <button type="submit" class="dropdown-item text-danger">Đánh dấu Đã hủy</button>
                                    </form>
                                </li>
                            </ul>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</div>

                </div>

                <!-- Pagination -->
                <c:if test="${noOfPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <c:if test="${currentPage != 1}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin_orders?page=${currentPage - 1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            
                            <c:forEach begin="1" end="${noOfPages}" var="i">
                                <c:choose>
                                    <c:when test="${currentPage eq i}">
                                        <li class="page-item active"><a class="page-link" href="#">${i}</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/admin_orders?page=${i}">${i}</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <c:if test="${currentPage < noOfPages}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin_orders?page=${currentPage + 1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </main>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        $(document).ready(function() {
    $('#ordersTable').DataTable({
        language: {
            url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/vi.json'
        },
        paging: false,       // Tắt phân trang của DataTables
        info: false,         // Tắt thông tin "Showing X to Y of Z entries"
        order: [[1, 'desc']], // Sắp xếp theo ngày đặt (cột 2, index 1)
        columnDefs: [
            { orderable: false, targets: 4 } // Không cho phép sắp xếp cột thao tác (cột 5, index 4)
        ]
    });
});



        function confirmDelete(orderId) {
            if (!orderId) {
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi',
                    text: 'ID đơn hàng không hợp lệ!'
                });
                return;
            }

            Swal.fire({
                title: 'Xác nhận xóa?',
                text: "Bạn không thể hoàn tác sau khi xóa!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Xóa',
                cancelButtonText: 'Hủy'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '${pageContext.request.contextPath}/admin_orders?action=delete&id=' + orderId;
                }
            });
        }
    </script>
</body>
</html>
