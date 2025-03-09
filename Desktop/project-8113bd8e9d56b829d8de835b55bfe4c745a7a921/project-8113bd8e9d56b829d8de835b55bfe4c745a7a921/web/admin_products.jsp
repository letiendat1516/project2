<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Sản phẩm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap5.min.css">
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

                <div class="col-md-10">
                    <h1 class="mt-4">Quản lý Sản phẩm</h1>

                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% session.removeAttribute("successMessage"); %>
                    </c:if>

                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${sessionScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% session.removeAttribute("errorMessage"); %>
                    </c:if>

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
                            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                        </form>
                    </div>

                    <div class="mb-3">
                        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addProductModal">
                            <i class="bi bi-plus-circle"></i> Thêm sản phẩm mới
                        </button>
                    </div>

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
                                        <button class="btn btn-warning btn-sm" onclick="editProduct(${product.productId})" data-bs-toggle="modal" data-bs-target="#editProductModal">
                                            <i class="bi bi-pencil-square"></i> Sửa
                                        </button>
                                        <button class="btn btn-danger btn-sm ms-1" onclick="confirmDelete(${product.productId})">
                                            <i class="bi bi-trash3-fill"></i> Xóa
                                        </button>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage - 1}&search=${searchTerm}&category=${selectedCategory}">Previous</a>
                                </li>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item <c:if test="${i == currentPage}">active</c:if>">
                                    <a class="page-link" href="?page=${i}&search=${searchTerm}&category=${selectedCategory}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage + 1}&search=${searchTerm}&category=${selectedCategory}">Next</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
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
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#productsTable').DataTable({
                    responsive: true,
                    language: {
                        url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/vi.json'
                    }
                });
            });

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
                if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')) {
                    window.location.href = 'admin_products?action=delete&id=' + productId;
                }
            }
        </script>
    </body>
</html>
