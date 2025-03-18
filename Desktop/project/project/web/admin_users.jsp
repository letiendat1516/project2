<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Người dùng</title>
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
                padding: 2rem;
            }

            /* Card Styles */
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

            /* Form Styles */
            .form-container {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                margin-bottom: 30px;
            }

            .form-label {
                font-weight: 600;
            }

            /* Table Styles */
            .table thead th {
                background-color: #f8f9fc;
                font-weight: 600;
            }

            /* Status Badge Styles */
            .badge {
                padding: 0.5em 1em;
                font-size: 0.875rem;
            }

            /* Button Styles */
            .btn-sm {
                padding: 0.4rem 0.8rem;
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
            
            /* Protected Admin Styles */
            .protected-admin {
                background-color: rgba(255, 243, 205, 0.5);
            }
            
            .tooltip-info {
                cursor: help;
                color: #17a2b8;
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
                                <a class="nav-link active animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin_users">
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
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show animate__animated animate__fadeIn" role="alert">
                            ${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show animate__animated animate__fadeIn" role="alert">
                            ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Form thêm/sửa người dùng -->
                    <div class="card animate__animated animate__fadeIn">
                        <div class="card-header">
                            <h5 class="mb-0">${empty editUser ? 'Thêm người dùng mới' : 'Chỉnh sửa người dùng'}</h5>
                        </div>
                        <div class="card-body">
                            <form action="admin_users" method="post">
                                <input type="hidden" name="action" value="${empty editUser ? 'add' : 'update'}">
                                <input type="hidden" name="userId" value="${editUser.userId}">
                                
                                <!-- Kiểm tra xem đây có phải là tài khoản admin được bảo vệ không -->
                                <c:set var="isProtectedAdmin" value="${editUser.email == 'tiendat1516@gmail.com'}" />
                                
                                <c:if test="${isProtectedAdmin}">
                                    <div class="alert alert-warning mb-4">
                                        <i class="bi bi-shield-lock"></i> Đây là tài khoản Admin được bảo vệ. Một số tùy chọn sẽ bị hạn chế.
                                    </div>
                                </c:if>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="fullName" class="form-label">Họ và tên</label>
                                        <input type="text" id="fullName" name="fullName" class="form-control" value="${editUser.fullName}" required>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" id="email" name="email" class="form-control" value="${editUser.email}" required ${isProtectedAdmin ? 'readonly' : ''}>
                                        <c:if test="${isProtectedAdmin}">
                                            <small class="text-muted">Email của tài khoản Admin được bảo vệ không thể thay đổi</small>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="phone" class="form-label">Số điện thoại</label>
                                        <input type="text" id="phone" name="phone" class="form-control" value="${editUser.phone}" required>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="password" class="form-label">Mật khẩu ${empty editUser ? '' : '(để trống nếu không thay đổi)'}</label>
                                        <input type="password" id="password" name="password" class="form-control" ${empty editUser ? 'required' : ''}>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="roleId" class="form-label">Vai trò</label>
                                        <c:choose>
                                            <c:when test="${isAdmin && !isProtectedAdmin}">
                                                <!-- Admin có thể thấy và thay đổi role cho tài khoản thông thường -->
                                                <select id="roleId" name="roleId" class="form-select">
                                                    <option value="1" ${editUser.roleId == 1 ? 'selected' : ''}>Admin</option>
                                                    <option value="2" ${editUser.roleId == 2 ? 'selected' : ''}>Nhân viên</option>
                                                    <option value="3" ${editUser.roleId == 3 ? 'selected' : ''}>Người dùng</option>
                                                </select>
                                            </c:when>
                                            <c:when test="${isProtectedAdmin}">
                                                <!-- Tài khoản admin được bảo vệ không thể thay đổi role -->
                                                <select id="roleId" name="roleId" class="form-select" disabled>
                                                    <option value="1" selected>Admin</option>
                                                </select>
                                                <input type="hidden" name="roleId" value="1">
                                                <small class="text-muted">Vai trò của tài khoản Admin được bảo vệ không thể thay đổi</small>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Staff có thể thấy nhưng không thể thay đổi role -->
                                                <select id="roleId" name="roleId" class="form-select" ${isStaff ? 'disabled' : ''}>
                                                    <option value="1" ${editUser.roleId == 1 ? 'selected' : ''}>Admin</option>
                                                    <option value="2" ${editUser.roleId == 2 ? 'selected' : ''}>Nhân viên</option>
                                                    <option value="3" ${editUser.roleId == 3 ? 'selected' : ''}>Người dùng</option>
                                                </select>
                                                <!-- Thêm field ẩn để gửi giá trị nguyên gốc khi form submit -->
                                                <c:if test="${isStaff}">
                                                    <input type="hidden" name="roleId" value="${empty editUser ? '3' : editUser.roleId}">
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="isActive" class="form-label">Trạng thái</label>
                                        <c:choose>
                                            <c:when test="${isProtectedAdmin}">
                                                <select id="isActive" name="isActive" class="form-select" disabled>
                                                    <option value="true" selected>Hoạt động</option>
                                                </select>
                                                <input type="hidden" name="isActive" value="true">
                                                <small class="text-muted">Tài khoản Admin được bảo vệ luôn trong trạng thái hoạt động</small>
                                            </c:when>
                                            <c:otherwise>
                                                <select id="isActive" name="isActive" class="form-select">
                                                    <option value="true" ${editUser.isActive ? 'selected' : ''}>Hoạt động</option>
                                                    <option value="false" ${!editUser.isActive ? 'selected' : ''}>Không hoạt động</option>
                                                </select>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="mt-3">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-save"></i> ${empty editUser ? 'Thêm mới' : 'Cập nhật'}
                                    </button>
                                    <c:if test="${not empty editUser}">
                                        <a href="admin_users" class="btn btn-secondary">
                                            <i class="bi bi-x-circle"></i> Hủy
                                        </a>
                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Bảng danh sách người dùng -->
                    <div class="card animate__animated animate__fadeIn mt-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Danh sách người dùng</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table id="usersTable" class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Họ và tên</th>
                                            <th>Email</th>
                                            <th>Số điện thoại</th>
                                            <th>Vai trò</th>
                                            <th>Trạng thái</th>
                                            <th>Ngày tạo</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${userList}">
                                            <c:set var="isProtectedUser" value="${user.email == 'tiendat1516@gmail.com'}" />
                                            <tr class="${isProtectedUser ? 'protected-admin' : ''}">
                                                <td>${user.userId}</td>
                                                <td>
                                                    ${user.fullName}
                                                    <c:if test="${isProtectedUser}">
                                                        <i class="bi bi-shield-fill-check text-success ms-1" data-bs-toggle="tooltip" title="Tài khoản Admin được bảo vệ"></i>
                                                    </c:if>
                                                </td>
                                                <td>${user.email}</td>
                                                <td>${user.phone}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.roleId == 1}">Admin</c:when>
                                                        <c:when test="${user.roleId == 2}">Nhân viên</c:when>
                                                        <c:when test="${user.roleId == 3}">Người dùng</c:when>
                                                        <c:otherwise>Không xác định</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.isActive}">Hoạt động</c:when>
                                                        <c:otherwise>Không hoạt động</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                </td>
                                                <td>
                                                    <div class="btn-group">
                                                        <a href="admin_users?action=edit&id=${user.userId}" class="btn btn-warning btn-sm">
                                                            <i class="bi bi-pencil"></i>
                                                        </a>
                                                        <c:choose>
                                                            <c:when test="${isProtectedUser}">
                                                                <button class="btn btn-secondary btn-sm" disabled data-bs-toggle="tooltip" title="Tài khoản Admin được bảo vệ không thể bị xóa">
                                                                    <i class="bi bi-trash"></i>
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-danger btn-sm" onclick="confirmDelete(${user.userId})">
                                                                    <i class="bi bi-trash"></i>
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
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

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            $(document).ready(function () {
                $('#usersTable').DataTable({
                    language: {
                        url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/vi.json'
                    },
                    columnDefs: [
                        {orderable: false, targets: [7]} // Không cho phép sắp xếp cột thao tác
                    ]
                });
                
                // Kích hoạt tooltips
                var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
                var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl)
                });
            });

            function confirmDelete(userId) {
                Swal.fire({
                    title: 'Xác nhận xóa người dùng?',
                    text: "Bạn không thể hoàn tác sau khi xóa!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Xóa',
                    cancelButtonText: 'Hủy'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'admin_users?action=delete&id=' + userId;
                    }
                });
            }
        </script>
    </body>
</html>
