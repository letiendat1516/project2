<%-- 
    Author     : DAT, KHANH, LINH
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Sản phẩm</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
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

            /* Table Styles */
            .table thead th {
                background-color: #f8f9fc;
                font-weight: 600;
            }

            /* Products specific styles */
            .product-image {
                border-radius: 8px;
                object-fit: cover;
                height: 50px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                transition: transform 0.3s;
            }

            .product-image:hover {
                transform: scale(1.1);
            }

            /* Status Badge Styles */
            .badge {
                padding: 0.5em 1em;
                font-size: 0.875rem;
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

            /* Action Buttons */
            .btn-action {
                margin-right: 5px;
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
                                <a class="nav-link active animate__animated animate__fadeInLeft" href="${pageContext.request.contextPath}/admin_products">
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
                            <h5 class="mb-0">Quản lý Sản phẩm</h5>
                            <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addProductModal">
                                <i class="bi bi-plus-circle"></i> Thêm sản phẩm mới
                            </button>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <form action="${pageContext.request.contextPath}/admin_products" method="get" class="d-flex">
                                    <select name="category" class="form-select me-2">
                                        <option value="">Tất cả danh mục</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.categoryId}" 
                                                    <c:if test="${category.categoryId == selectedCategory}">selected</c:if>>
                                                ${category.categoryName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <input type="text" name="search" placeholder="Tên sản phẩm..." class="form-control me-2" value="${searchTerm}">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-search"></i> 
                                    </button>
                                </form>
                            </div>

                            <div class="table-responsive">
                                <table id="productsTable" class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Hình ảnh</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Danh mục</th>
                                            <th>Giá</th>
                                            <th>Tồn kho</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${products}" var="product">
                                            <tr>
                                                <td>${product.productId}</td>
                                                <td>
                                                    <img src="${product.imageUrl}" alt="${product.name}" class="product-image" width="50">
                                                </td>
                                                <td>${product.name}</td>
                                                <td>${product.categoryName}</td>
                                                <td>
                                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/>
                                                </td>
                                                <td>${product.stockQuantity}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${product.stockQuantity > 0}">
                                                            <span class="badge bg-success">Còn hàng</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-danger">Hết hàng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <div class="btn-group">
                                                        <button class="btn btn-warning btn-sm" onclick="editProduct(${product.productId})">
                                                            <i class="bi bi-pencil"></i>
                                                        </button>
                                                        <button class="btn btn-danger btn-sm" onclick="confirmDelete(${product.productId})">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
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
                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}&search=${searchTerm}&category=${selectedCategory}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item <c:if test="${i == currentPage}">active</c:if>">
                                        <a class="page-link" href="?page=${i}&search=${searchTerm}&category=${selectedCategory}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}&search=${searchTerm}&category=${selectedCategory}" aria-label="Next">
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

        <!-- Add Product Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">Thêm sản phẩm mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin_products" method="post" enctype="multipart/form-data">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="add">
                            <div class="mb-3">
                                <label for="productName" class="form-label">Tên sản phẩm</label>
                                <input type="text" class="form-control" id="productName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="price" class="form-label">Giá</label>
                                <input type="number" class="form-control" id="price" name="price" min="0" step="0.01" required>
                            </div>
                            <div class="mb-3">
                                <label for="stockQuantity" class="form-label">Số lượng tồn kho</label>
                                <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" min="0" required>
                            </div>
                            <div class="mb-3">
                                <label for="categoryId" class="form-label">Danh mục</label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.categoryId}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="imageFile" class="form-label">Hình ảnh</label>
                                <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*" required>
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" id="isFeatured" name="isFeatured">
                                <label class="form-check-label" for="isFeatured">Đánh dấu là sản phẩm nổi bật</label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Product Modal -->
        <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editProductModalLabel">Chỉnh sửa sản phẩm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin_products" method="post" enctype="multipart/form-data">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" id="editProductId" name="productId">
                            <div class="mb-3">
                                <label for="editProductName" class="form-label">Tên sản phẩm</label>
                                <input type="text" class="form-control" id="editProductName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="editDescription" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="editDescription" name="description" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="editPrice" class="form-label">Giá</label>
                                <input type="number" class="form-control" id="editPrice" name="price" min="0" step="0.01" required>
                            </div>
                            <div class="mb-3">
                                <label for="editStockQuantity" class="form-label">Số lượng tồn kho</label>
                                <input type="number" class="form-control" id="editStockQuantity" name="stockQuantity" min="0" required>
                            </div>
                            <div class="mb-3">
                                <label for="editCategoryId" class="form-label">Danh mục</label>
                                <select class="form-select" id="editCategoryId" name="categoryId" required>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.categoryId}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="editImageFile" class="form-label">Hình ảnh</label>
                                <input type="file" class="form-control" id="editImageFile" name="imageFile" accept="image/*">
                            </div>
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" id="editIsFeatured" name="isFeatured">
                                <label class="form-check-label" for="editIsFeatured">Đánh dấu là sản phẩm nổi bật</label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Cập nhật sản phẩm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                                                     

                                                            function editProduct(productId) {
                                                                $.get('admin_products?action=get&id=' + productId, function (product) {
                                                                    $('#editProductId').val(product.productId);
                                                                    $('#editProductName').val(product.name);
                                                                    $('#editDescription').val(product.description);
                                                                    $('#editPrice').val(product.price);
                                                                    $('#editStockQuantity').val(product.stockQuantity);
                                                                    $('#editCategoryId').val(product.categoryId);
                                                                    $('#editIsFeatured').prop('checked', product.isFeatured);
                                                                    $('#editProductModal').modal('show');
                                                                });
                                                            }

                                                            function confirmDelete(productId) {
                                                                Swal.fire({
                                                                    title: 'Xác nhận xóa sản phẩm?',
                                                                    text: "Bạn không thể hoàn tác sau khi xóa!",
                                                                    icon: 'warning',
                                                                    showCancelButton: true,
                                                                    confirmButtonColor: '#d33',
                                                                    cancelButtonColor: '#3085d6',
                                                                    confirmButtonText: 'Xóa',
                                                                    cancelButtonText: 'Hủy'
                                                                }).then((result) => {
                                                                    if (result.isConfirmed) {
                                                                        window.location.href = '${pageContext.request.contextPath}/admin_products?action=delete&id=' + productId;
                                                                    }
                                                                });
                                                            }
        </script>
    </body>
</html>
