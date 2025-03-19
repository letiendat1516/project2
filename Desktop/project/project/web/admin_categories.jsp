<%-- 
    Author     : DAT, KHANH, LINH
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Danh mục</title>
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
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Noto+Sans+Vietnamese:wght@400;500;700&display=swap" rel="stylesheet">

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

            /* Categories specific styles */
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

            .btn-add {
                background: linear-gradient(45deg, #2ecc71, #27ae60);
                border: none;
                color: white;
                padding: 0.75rem 1.5rem;
                border-radius: 7px;
                transition: all 0.3s;
            }

            .btn-add:hover {
                background: linear-gradient(45deg, #27ae60, #219a52);
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

            .btn-warning {
                background-color: var(--warning-color);
                border-color: var(--warning-color);
                color: white;
            }

            .btn-danger {
                background-color: var(--danger-color);
                border-color: var(--danger-color);
            }

            /* Badge Styles */
            .badge {
                padding: 0.5em 1em;
                font-size: 0.875rem;
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
                                <a class="nav-link active animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin_categories">
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
                            <h5 class="mb-0">Quản lý Danh mục</h5>
                            <button class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                                <i class="bi bi-plus-circle me-2"></i>Thêm danh mục
                            </button>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table id="categoriesTable" class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên danh mục</th>
                                            <th>Số sản phẩm</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${categories}" var="category">
                                            <tr>
                                                <td>${category.categoryId}</td>
                                                <td>${category.categoryName}</td>
                                                <td>
                                                    <span class="badge bg-primary">${category.productCount}</span>
                                                </td>
                                                <td>
                                                    <button class="btn btn-warning btn-sm" onclick="editCategory(${category.categoryId}, '${category.categoryName}')">
                                                        <i class="bi bi-pencil"></i>
                                                    </button>
                                                    <button class="btn btn-danger btn-sm" onclick="confirmDelete(${category.categoryId})">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Add Category Modal -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm danh mục mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="admin_categories" method="POST">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="add">
                            <div class="mb-3">
                                <label for="categoryName" class="form-label">Tên danh mục</label>
                                <input type="text" class="form-control" id="categoryName" name="categoryName" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Thêm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Category Modal -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Sửa danh mục</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="admin_categories" method="POST">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" id="editCategoryId" name="categoryId">
                            <div class="mb-3">
                                <label for="editCategoryName" class="form-label">Tên danh mục</label>
                                <input type="text" class="form-control" id="editCategoryName" name="categoryName" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                                                        $(document).ready(function () {
                                                            $('#categoriesTable').DataTable({
                                                                language: {
                                                                    url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/vi.json'
                                                                }
                                                            });
                                                        });

                                                        function editCategory(id, name) {
                                                            $('#editCategoryId').val(id);
                                                            $('#editCategoryName').val(name);
                                                            $('#editCategoryModal').modal('show');
                                                        }

                                                        function confirmDelete(categoryId) {
                                                            if (!categoryId) {
                                                                Swal.fire({
                                                                    icon: 'error',
                                                                    title: 'Lỗi',
                                                                    text: 'ID danh mục không hợp lệ!'
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
                                                                    window.location.href = '${pageContext.request.contextPath}/admin_categories?action=delete&id=' + categoryId;
                                                                }
                                                            });
                                                        }
        </script>
    </body>
</html>
