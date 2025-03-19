<%-- 
    Author     : DAT
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
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto+Slab:wght@300;400;700&display=swap" rel="stylesheet">
  <style>
      :root {
          --primary-color: #8b735a;
          --secondary-color: #f4f1ea;
          --text-color: #3a3a3a;
          --dark-color: #2c2c2c;
          --accent-color: #d2b48c;
          --admin-color: #9b2c2c;
          --staff-color: #2c5f9b;
          --border-color: #d9d0c3;
          --light-color: #f8f5f0;
      }
      
      body {
          background-color: var(--light-color);
          color: var(--text-color);
          font-family: 'Roboto Slab', serif;
          background-image: url('https://www.transparenttextures.com/patterns/paper-fibers.png');
          padding-top: 80px;
      }
      
      h1, h2, h3, h4, h5, h6 {
          font-family: 'Playfair Display', serif;
          color: var(--dark-color);
      }
      
      .page-header {
          background-color: var(--primary-color);
          color: var(--light-color);
          padding: 1.5rem 0;
          margin-bottom: 2rem;
          border-bottom: 5px solid var(--accent-color);
          background-image: url('https://www.transparenttextures.com/patterns/old-map.png');
      }
      
      .page-header h1 {
          font-family: 'Playfair Display', serif;
          font-weight: 700;
          letter-spacing: 1px;
      }
      
      .container {
          max-width: 1140px;
      }
      
      .navbar {
          background-color: var(--light-color) !important;
          border-bottom: 1px solid var(--border-color);
          box-shadow: 0 2px 15px rgba(0,0,0,0.1);
      }
      
      .navbar-brand {
          font-family: 'Playfair Display', serif;
          font-weight: 700;
          color: var(--primary-color);
      }
      
      .nav-link {
          color: var(--text-color) !important;
          font-weight: 500;
      }
      
      .nav-link:hover {
          color: var(--primary-color) !important;
      }
      
      .card {
          background-color: var(--secondary-color);
          border-radius: 8px;
          padding: 0;
          margin-bottom: 25px;
          box-shadow: 0 4px 8px rgba(0,0,0,0.05);
          border: 1px solid var(--border-color);
          position: relative;
          overflow: hidden;
      }
      
      .card::before {
          content: '';
          position: absolute;
          top: 0;
          left: 0;
          right: 0;
          height: 5px;
          background-color: var(--primary-color);
      }
      
      .card-header {
          background-color: rgba(139, 115, 90, 0.1);
          border-bottom: 1px solid var(--border-color);
          padding: 15px 20px;
      }
      
      .order-id {
          font-weight: bold;
          color: var(--admin-color);
          font-family: 'Playfair Display', serif;
      }
      
      .btn-primary {
          background-color: var(--primary-color);
          border: none;
          color: white;
          padding: 8px 16px;
          border-radius: 30px;
          font-weight: 600;
          transition: all 0.3s;
          position: relative;
          overflow: hidden;
          border: 2px solid var(--primary-color);
      }
      
      .btn-primary:hover {
          background-color: var(--accent-color);
          color: var(--dark-color);
          transform: translateY(-3px);
      }
      
      .btn-outline-secondary {
          color: var(--primary-color);
          border: 2px solid var(--primary-color);
          background-color: transparent;
          border-radius: 30px;
          font-weight: 600;
          transition: all 0.3s;
      }
      
      .btn-outline-secondary:hover {
          background-color: var(--primary-color);
          color: white;
          transform: translateY(-3px);
      }
      
      .btn-outline-danger {
          color: var(--admin-color);
          border: 2px solid var(--admin-color);
          background-color: transparent;
          border-radius: 30px;
          font-weight: 600;
          transition: all 0.3s;
      }
      
      .btn-outline-danger:hover {
          background-color: var(--admin-color);
          color: white;
          transform: translateY(-3px);
      }
      
      .status-badge {
          display: inline-block;
          padding: 5px 15px;
          background-color: var(--accent-color);
          color: var(--dark-color);
          border-radius: 30px;
          font-weight: 600;
          font-size: 0.85rem;
          position: relative;
          border: 1px solid var(--primary-color);
      }
      
      .status-pending {
          background-color: #FFF3CD;
          color: #856404;
          border-color: #856404;
      }
      
      .status-processing {
          background-color: #D1ECF1;
          color: #0C5460;
          border-color: #0C5460;
      }
      
      .status-shipped {
          background-color: #D4EDDA;
          color: #155724;
          border-color: #155724;
      }
      
      .status-delivered {
          background-color: #C3E6CB;
          color: #155724;
          border-color: #155724;
      }
      
      .status-cancelled {
          background-color: #F8D7DA;
          color: #721C24;
          border-color: #721C24;
      }
      
      .product-image {
          width: 70px;
          height: 70px;
          object-fit: cover;
          border-radius: 5px;
          border: 1px solid var(--border-color);
      }
      
      .price-text {
          color: var(--admin-color);
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
          background-color: var(--border-color);
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
          background-color: var(--secondary-color);
          border: 2px solid var(--border-color);
          display: flex;
          align-items: center;
          justify-content: center;
          margin-bottom: 10px;
      }
      
      .tracking-icon i {
          font-size: 1.5rem;
          color: var(--border-color);
      }
      
      .tracking-step.active .tracking-icon {
          border-color: var(--primary-color);
          background-color: rgba(139, 115, 90, 0.1);
      }
      
      .tracking-step.active .tracking-icon i {
          color: var(--primary-color);
      }
      
      .tracking-step.completed .tracking-icon {
          border-color: var(--primary-color);
          background-color: var(--primary-color);
      }
      
      .tracking-step.completed .tracking-icon i {
          color: white;
      }
      
      .section-title {
          font-family: 'Playfair Display', serif;
          position: relative;
          padding-bottom: 15px;
          margin-bottom: 25px;
          color: var(--dark-color);
          font-weight: 700;
          letter-spacing: 1px;
      }
      
      .section-title::after {
          content: '';
          position: absolute;
          left: 0;
          bottom: 0;
          width: 80px;
          height: 3px;
          background: var(--primary-color);
      }
      
      .section-title::before {
          content: '✦';
          position: absolute;
          left: 40px;
          bottom: -6px;
          font-size: 14px;
          color: var(--primary-color);
          background: var(--light-color);
          padding: 0 10px;
          z-index: 1;
      }
      
      .table {
          color: var(--text-color);
      }
      
      .table thead th {
          border-bottom: 2px solid var(--accent-color);
          color: var(--dark-color);
          font-weight: 600;
          font-family: 'Playfair Display', serif;
      }
      
      .table tbody td {
          border-bottom: 1px solid var(--border-color);
      }
      
      .table tfoot th {
          border-top: 2px solid var(--accent-color);
          color: var(--dark-color);
          font-weight: 600;
          font-family: 'Playfair Display', serif;
      }
      
      .alert {
          border-radius: 8px;
          border-left-width: 5px;
      }
      
      .alert-danger {
          background-color: #FBEAE5;
          border-color: #9B3C44;
          color: #9B3C44;
      }
      
      .vintage-corner {
          position: relative;
      }
      
      .vintage-corner::before,
      .vintage-corner::after {
          content: '❧';
          position: absolute;
          color: var(--accent-color);
          font-size: 20px;
      }
      
      .vintage-corner::before {
          top: 5px;
          left: 10px;
      }
      
      .vintage-corner::after {
          bottom: 5px;
          right: 10px;
          transform: rotate(180deg);
      }
      
      @media (max-width: 767px) {
          .card {
              padding: 0;
          }
          
          .page-header {
              padding: 1rem 0;
          }
      }
  </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-light fixed-top">
      <div class="container">
          <a class="navbar-brand" href="home">
              <img src="${pageContext.request.contextPath}/resources/logo.png" alt="Kingdoms Toys" style="max-height: 50px;">
              Kingdoms Toys
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

  <!-- Page Header -->
  <div class="page-header">
      <div class="container">
          <div class="row align-items-center">
              <div class="col-md-6">
                  <h1 class="mb-0"><i class="bi bi-receipt me-2"></i>Chi tiết đơn hàng</h1>
              </div>
              <div class="col-md-6 text-md-end">
                  <nav aria-label="breadcrumb">
                      <ol class="breadcrumb justify-content-md-end mb-0">
                          <li class="breadcrumb-item"><a href="home" class="text-white">Trang chủ</a></li>
                          <li class="breadcrumb-item"><a href="my-orders" class="text-white">Đơn hàng</a></li>
                          <li class="breadcrumb-item active text-white-50" aria-current="page">Chi tiết</li>
                      </ol>
                  </nav>
              </div>
          </div>
      </div>
  </div>

  <div class="container my-5">
      <div class="d-flex justify-content-between align-items-center mb-4">
          <h2 class="section-title mb-0">Đơn hàng #<span class="order-id">${order.orderId}</span></h2>
          <a href="my-orders" class="btn btn-outline-secondary">
              <i class="bi bi-arrow-left"></i> Quay lại
          </a>
      </div>

      <div class="row">
          <div class="col-lg-8">
              <!-- Order status tracking -->
              <div class="card vintage-corner mb-4">
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
              <div class="card vintage-corner mb-4">
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
                                                  <c:choose>
                                                      <c:when test="${not empty item.productImage}">
                                                          <img src="${pageContext.request.contextPath}/${item.productImage}" 
                                                               alt="${not empty item.productName ? item.productName : 'Sản phẩm'}" 
                                                               class="product-image me-3">
                                                      </c:when>
                                                      <c:otherwise>
                                                          <div class="product-image me-3 bg-light d-flex align-items-center justify-content-center">
                                                              <i class="bi bi-image text-muted"></i>
                                                          </div>
                                                      </c:otherwise>
                                                  </c:choose>
                                                  <span>${not empty item.productName ? item.productName : 'Sản phẩm #'.concat(item.productId)}</span>
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
              <div class="card vintage-corner mb-4">
                  <div class="card-header">
                      <h5 class="mb-0">Thông tin giao hàng</h5>
                  </div>
                  <div class="card-body">
                      <p><strong>Người nhận:</strong> ${order.shippingName}</p>
                      <p><strong>Địa chỉ:</strong> ${order.shippingAddress}</p>
                      <p><strong>Số điện thoại:</strong> ${order.shippingPhone}</p>
                      <p><strong>Email:</strong> ${user.email}</p>
                  </div>
              </div>

              <!-- Order summary -->
              <div class="card vintage-corner">
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
  <script>
      // Hiệu ứng hiển thị khi cuộn trang
      document.addEventListener('DOMContentLoaded', function() {
          const cards = document.querySelectorAll('.card');
          
          const observer = new IntersectionObserver((entries) => {
              entries.forEach(entry => {
                  if (entry.isIntersecting) {
                      entry.target.style.opacity = '1';
                      entry.target.style.transform = 'translateY(0)';
                  }
              });
          });
          
          cards.forEach(card => {
              card.style.opacity = '0';
              card.style.transform = 'translateY(20px)';
              card.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
              observer.observe(card);
          });
          
          // Thêm hiệu ứng giấy cũ
          const addPaperTexture = () => {
              const style = document.createElement('style');
              style.innerHTML = `
                  .card {
                      position: relative;
                  }
                  
                  .card::after {
                      content: '';
                      position: absolute;
                      top: 0;
                      left: 0;
                      width: 100%;
                      height: 100%;
                      background-image: url('https://www.transparenttextures.com/patterns/old-paper.png');
                      opacity: 0.4;
                      pointer-events: none;
                      z-index: 0;
                  }
                  
                  .card > * {
                      position: relative;
                      z-index: 1;
                  }
              `;
              document.head.appendChild(style);
          };
          
          addPaperTexture();
      });
  </script>
</body>
</html>