<%-- 
    Author     : DAT, DANG
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Người Dùng | ${user.fullName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        
        .profile-section {
            background-color: var(--secondary-color);
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }
        
        .profile-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background-color: var(--primary-color);
        }
        
        .profile-img-container {
            position: relative;
            width: 150px;
            height: 150px;
            margin: 0 auto 20px;
        }
        
        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background-color: var(--secondary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: var(--primary-color);
            border: 5px solid var(--accent-color);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            position: relative;
        }
        
        .profile-avatar::after {
            content: '';
            position: absolute;
            top: -10px;
            left: -10px;
            right: -10px;
            bottom: -10px;
            border: 2px dashed var(--accent-color);
            border-radius: 50%;
            animation: rotate 60s linear infinite;
        }
        
        .user-name {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            color: var(--dark-color);
            margin-top: 15px;
        }
        
        .role-badge {
            display: inline-block;
            padding: 5px 15px;
            background-color: var(--accent-color);
            color: var(--dark-color);
            border-radius: 30px;
            font-weight: 600;
            font-size: 0.85rem;
            margin-bottom: 20px;
            position: relative;
            border: 1px solid var(--primary-color);
        }
        
        .role-badge i {
            margin-right: 5px;
        }
        
        .btn-edit {
            background-color: var(--primary-color);
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
            border: 2px solid var(--primary-color);
        }
        
        .btn-edit:hover {
            background-color: var(--accent-color);
            color: var(--dark-color);
            transform: translateY(-3px);
        }
        
        .btn-edit::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.2);
            transition: all 0.4s;
        }
        
        .btn-edit:hover::after {
            left: 100%;
        }
        
        .info-label {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
        }
        
        .info-label i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
            color: var(--accent-color);
        }
        
        .info-value {
            font-weight: 400;
            font-size: 1.05rem;
            color: var(--dark-color);
            padding-left: 10px;
            border-left: 3px solid var(--accent-color);
        }
        
        .section-title {
            font-family: 'Playfair Display', serif;
            position: relative;
            padding-bottom: 15px;
            margin-bottom: 25px;
            color: var(--dark-color);
            font-weight: 700;
            text-align: center;
            letter-spacing: 1px;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            bottom: 0;
            width: 80px;
            height: 3px;
            background: var(--primary-color);
        }
        
        .section-title::before {
            content: '✦';
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            bottom: -6px;
            font-size: 14px;
            color: var(--primary-color);
            background: var(--secondary-color);
            padding: 0 10px;
            z-index: 1;
        }
        
        .info-row {
            border-bottom: 1px dashed var(--border-color);
            padding: 15px 0;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .status-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            border: 3px solid;
        }
        
        .status-active {
            background-color: rgba(72, 187, 120, 0.1);
            border-color: #48bb78;
            color: #48bb78;
        }
        
        .status-inactive {
            background-color: rgba(245, 101, 101, 0.1);
            border-color: #f56565;
            color: #f56565;
        }
        
        .status-text {
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 5px;
        }
        
        .status-date {
            font-size: 0.9rem;
            color: var(--text-color);
            opacity: 0.7;
        }
        
        .back-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            transition: all 0.3s;
            z-index: 1000;
            border: 3px solid var(--accent-color);
        }
        
        .back-btn:hover {
            transform: scale(1.1);
            background-color: var(--accent-color);
            color: var(--dark-color);
        }
        
        /* Hiệu ứng vintage */
        .vintage-border {
            position: relative;
        }
        
        .vintage-border::before {
            content: '';
            position: absolute;
            top: 10px;
            left: 10px;
            right: 10px;
            bottom: 10px;
            border: 1px solid var(--accent-color);
            z-index: -1;
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
        
        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        @media (max-width: 767px) {
            .profile-section {
                padding: 15px;
            }
            
            .page-header {
                padding: 1rem 0;
            }
            
            .info-row .col-md-4,
            .info-row .col-md-8 {
                padding: 5px 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h1 class="mb-0"><i class="fas fa-book-open me-2"></i>Hồ Sơ Người Dùng</h1>
                </div>
                <div class="col-md-6 text-md-end">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb justify-content-md-end mb-0">
                            <li class="breadcrumb-item"><a href="home" class="text-white">Trang chủ</a></li>
                            <li class="breadcrumb-item active text-white-50" aria-current="page">Hồ sơ</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row">
            <!-- Cột thông tin cá nhân -->
            <div class="col-lg-4 mb-4">
                <div class="profile-section text-center vintage-corner">
                    <div class="profile-img-container">
                        <div class="profile-avatar">
                            <c:choose>
                                <c:when test="${roleName == 'ADMIN'}">
                                    <i class="fas fa-user-shield"></i>
                                </c:when>
                                <c:when test="${roleName == 'STAFF'}">
                                    <i class="fas fa-user-tie"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-user"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <h3 class="user-name">${user.fullName}</h3>
                    <div class="role-badge">
                        <i class="fas 
                            <c:choose>
                                <c:when test="${roleName == 'ADMIN'}">fa-crown</c:when>
                                <c:when test="${roleName == 'STAFF'}">fa-user-tie</c:when>
                                <c:otherwise>fa-user</c:otherwise>
                            </c:choose>"></i>${roleName}
                    </div>
                    <div class="d-grid">
                        <a href="editProfile" class="btn btn-edit">
                            <i class="fas fa-quill me-2"></i>Chỉnh Sửa Hồ Sơ
                        </a>
                    </div>
                </div>
                
                <div class="profile-section text-center vintage-corner">
                    <h5 class="section-title">Trạng Thái Tài Khoản</h5>
                    <div class="status-icon ${user.isActive ? 'status-active' : 'status-inactive'}">
                        <i class="fas ${user.isActive ? 'fa-check' : 'fa-times'} fa-2x"></i>
                    </div>
                    <div class="status-text">${user.isActive ? 'Hoạt động' : 'Không hoạt động'}</div>
                    <div class="status-date">Từ ngày: ${user.createdAt}</div>
                </div>
            </div>
            
            <!-- Cột thông tin chi tiết -->
            <div class="col-lg-8">
                <div class="profile-section vintage-corner">
                    <h4 class="section-title">Thông Tin Cá Nhân</h4>
                    
                    <div class="info-row row align-items-center">
                        <div class="col-md-4">
                            <p class="info-label mb-0">
                                <i class="fas fa-user"></i>Họ và tên
                            </p>
                        </div>
                        <div class="col-md-8">
                            <p class="info-value mb-0">${user.fullName}</p>
                        </div>
                    </div>
                    
                    <div class="info-row row align-items-center">
                        <div class="col-md-4">
                            <p class="info-label mb-0">
                                <i class="fas fa-envelope"></i>Email
                            </p>
                        </div>
                        <div class="col-md-8">
                            <p class="info-value mb-0">${user.email}</p>
                        </div>
                    </div>
                    
                    <div class="info-row row align-items-center">
                        <div class="col-md-4">
                            <p class="info-label mb-0">
                                <i class="fas fa-phone"></i>Số điện thoại
                            </p>
                        </div>
                        <div class="col-md-8">
                            <p class="info-value mb-0">${not empty user.phone ? user.phone : '<span class="text-muted fst-italic">Chưa cập nhật</span>'}</p>
                        </div>
                    </div>
                    
                    <div class="info-row row align-items-center">
                        <div class="col-md-4">
                            <p class="info-label mb-0">
                                <i class="fas fa-map-marker-alt"></i>Địa chỉ
                            </p>
                        </div>
                        <div class="col-md-8">
                            <p class="info-value mb-0">${not empty user.address ? user.address : '<span class="text-muted fst-italic">Chưa cập nhật</span>'}</p>
                        </div>
                    </div>
                    
                    <div class="info-row row align-items-center">
                        <div class="col-md-4">
                            <p class="info-label mb-0">
                                <i class="fas fa-calendar-alt"></i>Ngày tham gia
                            </p>
                        </div>
                        <div class="col-md-8">
                            <p class="info-value mb-0">${user.createdAt}</p>
                        </div>
                    </div>
                </div>
                
                <!-- Thêm phần thông tin bổ sung cho Admin và Staff -->
                <c:if test="${roleName == 'ADMIN' || roleName == 'STAFF'}">
                    <div class="profile-section vintage-corner">
                        <h4 class="section-title">Đặc Quyền ${roleName}</h4>
                        
                        <div class="text-center mb-4">
                            <div class="d-inline-block p-3 rounded-circle mb-3" 
                                style="background-color: ${roleName == 'ADMIN' ? 'rgba(155, 44, 44, 0.1)' : 'rgba(44, 95, 155, 0.1)'};
                                       border: 2px solid ${roleName == 'ADMIN' ? '#9b2c2c' : '#2c5f9b'}">
                                <i class="fas ${roleName == 'ADMIN' ? 'fa-crown' : 'fa-certificate'} fa-3x" 
                                   style="color: ${roleName == 'ADMIN' ? '#9b2c2c' : '#2c5f9b'}"></i>
                            </div>
                        </div>
                        
                        <div class="info-row row align-items-center">
                            <div class="col-md-4">
                                <p class="info-label mb-0">
                                    <i class="fas fa-id-badge"></i>Chức vụ
                                </p>
                            </div>
                            <div class="col-md-8">
                                <p class="info-value mb-0">
                                    <c:choose>
                                        <c:when test="${roleName == 'ADMIN'}">Quản trị viên hệ thống</c:when>
                                        <c:when test="${roleName == 'STAFF'}">Nhân viên hỗ trợ</c:when>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                        
                        <div class="info-row row align-items-center">
                            <div class="col-md-4">
                                <p class="info-label mb-0">
                                    <i class="fas fa-shield-alt"></i>Quyền hạn
                                </p>
                            </div>
                            <div class="col-md-8">
                                <div class="info-value mb-0">
                                    <c:choose>
                                        <c:when test="${roleName == 'ADMIN'}">
                                            <div class="mb-2"><span class="badge bg-danger me-1">Quản lý người dùng</span></div>
                                            <div class="mb-2"><span class="badge bg-danger me-1">Quản lý hệ thống</span></div>
                                            <div><span class="badge bg-danger">Toàn quyền</span></div>
                                        </c:when>
                                        <c:when test="${roleName == 'STAFF'}">
                                            <div class="mb-2"><span class="badge bg-info me-1">Hỗ trợ người dùng</span></div>
                                            <div><span class="badge bg-info">Quản lý nội dung</span></div>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <!-- Back to Home Button -->
    <a href="home" class="back-btn" title="Về trang chủ">
        <i class="fas fa-home"></i>
    </a>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Hiệu ứng hiển thị khi cuộn trang
        document.addEventListener('DOMContentLoaded', function() {
            const profileSections = document.querySelectorAll('.profile-section');
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            });
            
            profileSections.forEach(section => {
                section.style.opacity = '0';
                section.style.transform = 'translateY(20px)';
                section.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
                observer.observe(section);
            });
            
            // Thêm hiệu ứng vintage cho các góc trang
            const addVintageCorners = () => {
                const corners = document.querySelectorAll('.vintage-corner');
                corners.forEach(corner => {
                    // Thêm các họa tiết vintage vào các góc
                    const topLeft = document.createElement('div');
                    topLeft.className = 'corner-decoration top-left';
                    topLeft.innerHTML = '❦';
                    topLeft.style.position = 'absolute';
                    topLeft.style.top = '10px';
                    topLeft.style.left = '10px';
                    topLeft.style.color = 'var(--accent-color)';
                    topLeft.style.fontSize = '20px';
                    
                    const bottomRight = document.createElement('div');
                    bottomRight.className = 'corner-decoration bottom-right';
                    bottomRight.innerHTML = '❦';
                    bottomRight.style.position = 'absolute';
                    bottomRight.style.bottom = '10px';
                    bottomRight.style.right = '10px';
                    bottomRight.style.color = 'var(--accent-color)';
                    bottomRight.style.fontSize = '20px';
                    bottomRight.style.transform = 'rotate(180deg)';
                    
                    corner.style.position = 'relative';
                    corner.appendChild(topLeft);
                    corner.appendChild(bottomRight);
                });
            };
            
            addVintageCorners();
            
            // Thêm hiệu ứng giấy cũ
            const addPaperTexture = () => {
                const style = document.createElement('style');
                style.innerHTML = `
                    .profile-section {
                        position: relative;
                    }
                    
                    .profile-section::after {
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
                    
                    .profile-section > * {
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
