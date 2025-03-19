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
    <title>Cập Nhật Hồ Sơ | ${user.fullName}</title>
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
            --border-color: #d9d0c3;
            --light-color: #f8f5f0;
            --error-color: #9b2c2c;
            --success-color: #2c9b4f;
        }
        
        body {
            background-color: var(--light-color);
            color: var(--text-color);
            font-family: 'Roboto Slab', serif;
            background-image: url('https://www.transparenttextures.com/patterns/paper-fibers.png');
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            opacity: 0;
            transition: opacity 0.8s ease;
        }
        
        body.loaded {
            opacity: 1;
        }
        
        .page-header {
            background-color: var(--primary-color);
            color: var(--light-color);
            padding: 1.5rem 0;
            margin-bottom: 2rem;
            border-bottom: 5px solid var(--accent-color);
            background-image: url('https://www.transparenttextures.com/patterns/old-map.png');
            position: relative;
        }
        
        .page-header h1 {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            letter-spacing: 1px;
            margin: 0;
        }
        
        .page-header .book-icon {
            margin-right: 10px;
            font-size: 1.8rem;
        }
        
        .container {
            max-width: 1140px;
            padding-top: 2rem;
            padding-bottom: 2rem;
        }
        
        .form-section {
            background-color: var(--secondary-color);
            border-radius: 8px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.8s ease;
        }
        
        .form-section.visible {
            opacity: 1;
            transform: translateY(0);
        }
        
        .form-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background-color: var(--primary-color);
        }
        
        .form-section::after {
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
        
        .form-section > * {
            position: relative;
            z-index: 1;
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
            background: var(--secondary-color);
            padding: 0 10px;
            z-index: 1;
        }
        
        .form-label {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 0.9rem;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
        }
        
        .form-label i {
            margin-right: 8px;
            color: var(--accent-color);
        }
        
        .form-control {
            border: 1px solid var(--border-color);
            border-radius: 6px;
            padding: 12px 15px;
            background-color: rgba(255, 255, 255, 0.7);
            color: var(--dark-color);
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.25rem rgba(210, 180, 140, 0.25);
            background-color: #fff;
        }
        
        .form-control::placeholder {
            color: #aaa;
            font-style: italic;
        }
        
        .btn {
            padding: 12px 25px;
            font-weight: 600;
            border-radius: 30px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            letter-spacing: 0.5px;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: 2px solid var(--primary-color);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            color: var(--dark-color);
            transform: translateY(-3px);
        }
        
        .btn-secondary {
            background-color: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
        }
        
        .btn-secondary:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-3px);
        }
        
        .btn i {
            margin-right: 8px;
        }
        
        .alert {
            border-radius: 8px;
            padding: 15px 20px;
            margin-bottom: 25px;
            border: none;
            position: relative;
            opacity: 0;
            animation: fadeInDown 0.5s ease forwards;
        }
        
        .alert-danger {
            background-color: rgba(155, 44, 44, 0.1);
            color: var(--error-color);
            border-left: 5px solid var(--error-color);
        }
        
        .alert-success {
            background-color: rgba(44, 155, 79, 0.1);
            color: var(--success-color);
            border-left: 5px solid var(--success-color);
        }
        
        .alert i {
            margin-right: 10px;
        }
        
        .separator {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 30px 0;
            color: var(--primary-color);
        }
        
        .separator::before,
        .separator::after {
            content: '';
            flex: 1;
            border-bottom: 1px dashed var(--border-color);
        }
        
        .separator::before {
            margin-right: 15px;
        }
        
        .separator::after {
            margin-left: 15px;
        }
        
        .separator-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: var(--accent-color);
            color: white;
            border-radius: 50%;
        }
        
        .password-section {
            background-color: rgba(255, 255, 255, 0.4);
            border-radius: 8px;
            padding: 20px;
            border: 1px dashed var(--border-color);
        }
        
        .password-section h5 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
        
        .password-section h5 i {
            margin-right: 10px;
        }
        
        .form-floating {
            position: relative;
        }
        
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: var(--primary-color);
            z-index: 10;
            background: transparent;
            border: none;
            padding: 0;
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
            opacity: 0;
            transform: scale(0);
            animation: fadeInScale 0.5s ease 1.5s forwards;
        }
        
        .back-btn:hover {
            transform: scale(1.1);
            background-color: var(--accent-color);
            color: var(--dark-color);
        }
        
        /* Hiệu ứng vintage */
        .vintage-corner {
            position: relative;
        }
        
        .corner-decoration {
            position: absolute;
            color: var(--accent-color);
            font-size: 20px;
            opacity: 0;
            transition: opacity 0.5s ease;
        }
        
        .corner-decoration.top-left {
            top: 10px;
            left: 10px;
        }
        
        .corner-decoration.top-right {
            top: 10px;
            right: 10px;
            transform: rotate(90deg);
        }
        
        .corner-decoration.bottom-left {
            bottom: 10px;
            left: 10px;
            transform: rotate(-90deg);
        }
        
        .corner-decoration.bottom-right {
            bottom: 10px;
            right: 10px;
            transform: rotate(180deg);
        }
        
        .vintage-corner:hover .corner-decoration {
            opacity: 1;
        }
        
        .form-floating-group {
            position: relative;
        }
        
        .password-strength {
            height: 5px;
            margin-top: 5px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        
        /* Hiệu ứng animation */
        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        @keyframes fadeInScale {
            from { 
                opacity: 0;
                transform: scale(0);
            }
            to { 
                opacity: 1;
                transform: scale(1);
            }
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        
        @keyframes fadeInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        
        @keyframes shimmer {
            0% {
                background-position: -200% 0;
            }
            100% {
                background-position: 200% 0;
            }
        }
        
        /* Hiệu ứng loading */
        .shimmer {
            background: linear-gradient(90deg, 
                var(--secondary-color) 0%, 
                var(--light-color) 50%, 
                var(--secondary-color) 100%);
            background-size: 200% 100%;
            animation: shimmer 2s infinite;
        }
        
        /* Responsive */
        @media (max-width: 767px) {
            .form-section {
                padding: 20px 15px;
            }
            
            .page-header {
                padding: 1rem 0;
            }
            
            .btn {
                width: 100%;
                margin-bottom: 10px;
            }
            
            .d-md-flex {
                display: block !important;
            }
            
            .justify-content-md-end {
                justify-content: center !important;
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
                    <h1 class="mb-0"><i class="fas fa-pen-fancy book-icon"></i>Cập Nhật Hồ Sơ</h1>
                </div>
                <div class="col-md-6 text-md-end">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb justify-content-md-end mb-0">
                            <li class="breadcrumb-item"><a href="home" class="text-white">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="profile" class="text-white">Hồ sơ</a></li>
                            <li class="breadcrumb-item active text-white-50" aria-current="page">Cập nhật</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <!-- Thông báo -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                    </div>
                </c:if>
                
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success" role="alert">
                        <i class="fas fa-check-circle"></i> ${successMessage}
                    </div>
                </c:if>
                
                <!-- Form cập nhật thông tin -->
                <div class="form-section vintage-corner" id="form-section-1">
                    <div class="corner-decoration top-left">❦</div>
                    <div class="corner-decoration top-right">❦</div>
                    <div class="corner-decoration bottom-left">❦</div>
                    <div class="corner-decoration bottom-right">❦</div>
                    
                    <h4 class="section-title">Thông Tin Cá Nhân</h4>
                    
                    <form action="updateProfile" method="post" id="updateProfileForm">
                        <input type="hidden" name="userId" value="${user.userId}">
                        
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label for="fullName" class="form-label">
                                    <i class="fas fa-user"></i> Họ và tên
                                </label>
                                <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope"></i> Email
                                </label>
                                <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                            </div>
                        </div>
                        
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label for="phone" class="form-label">
                                    <i class="fas fa-phone"></i> Số điện thoại
                                </label>
                                <input type="tel" class="form-control" id="phone" name="phone" value="${user.phone}" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label for="address" class="form-label">
                                    <i class="fas fa-map-marker-alt"></i> Địa chỉ
                                </label>
                                <input type="text" class="form-control" id="address" name="address" value="${user.address}">
                            </div>
                        </div>
                        
                        <div class="separator">
                            <div class="separator-icon">
                                <i class="fas fa-key"></i>
                            </div>
                        </div>
                        
                        <div class="password-section">
                            <h5><i class="fas fa-lock"></i> Đổi Mật Khẩu</h5>
                            <p class="text-muted mb-4"><small><i class="fas fa-info-circle me-1"></i> Bỏ trống các trường dưới đây nếu không muốn thay đổi mật khẩu</small></p>
                            
                            <div class="row mb-4">
                                <div class="col-md-4">
                                    <div class="form-floating-group">
                                        <label for="currentPassword" class="form-label">
                                            <i class="fas fa-unlock-alt"></i> Mật khẩu hiện tại
                                        </label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="currentPassword" name="currentPassword">
                                            <button type="button" class="toggle-password" tabindex="-1">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <div class="form-floating-group">
                                        <label for="newPassword" class="form-label">
                                            <i class="fas fa-key"></i> Mật khẩu mới
                                        </label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="newPassword" name="newPassword">
                                            <button type="button" class="toggle-password" tabindex="-1">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                        <div class="password-strength w-100"></div>
                                        <small class="password-feedback text-muted"></small>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <div class="form-floating-group">
                                        <label for="confirmPassword" class="form-label">
                                            <i class="fas fa-check-circle"></i> Xác nhận mật khẩu
                                        </label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                                            <button type="button" class="toggle-password" tabindex="-1">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                            <a href="profile" class="btn btn-secondary me-md-2">
                                <i class="fas fa-arrow-left"></i> Quay Lại
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Lưu Thay Đổi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Back to Profile Button -->
    <a href="profile" class="back-btn" title="Quay về hồ sơ">
        <i class="fas fa-user"></i>
    </a>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Hiệu ứng loading ban đầu
            const formSections = document.querySelectorAll('.form-section');
            
            // Thêm hiệu ứng shimmer khi đang tải
            formSections.forEach(section => {
                section.classList.add('shimmer');
            });
            
            // Hiển thị form sau khi tải xong
            setTimeout(() => {
                document.body.classList.add('loaded');
                
                formSections.forEach((section, index) => {
                    setTimeout(() => {
                        section.classList.remove('shimmer');
                        section.classList.add('visible');
                        section.style.animation = index % 2 === 0 ? 'fadeInLeft 0.8s ease forwards' : 'fadeInRight 0.8s ease forwards';
                    }, 200 * (index + 1));
                });
            }, 600);
            
            // Hiệu ứng cho các góc trang
            const corners = document.querySelectorAll('.vintage-corner');
            corners.forEach(corner => {
                corner.addEventListener('mouseenter', () => {
                    const decorations = corner.querySelectorAll('.corner-decoration');
                    decorations.forEach(decoration => {
                        decoration.style.opacity = '1';
                    });
                });
                
                corner.addEventListener('mouseleave', () => {
                    const decorations = corner.querySelectorAll('.corner-decoration');
                    decorations.forEach(decoration => {
                        decoration.style.opacity = '0';
                    });
                });
            });
            
            // Hiệu ứng hiển thị/ẩn mật khẩu
            const toggleButtons = document.querySelectorAll('.toggle-password');
            toggleButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const input = this.previousElementSibling;
                    const icon = this.querySelector('i');
                    
                    if (input.type === 'password') {
                        input.type = 'text';
                        icon.classList.remove('fa-eye');
                        icon.classList.add('fa-eye-slash');
                    } else {
                        input.type = 'password';
                        icon.classList.remove('fa-eye-slash');
                        icon.classList.add('fa-eye');
                    }
                });
            });
            
            // Hiệu ứng kiểm tra độ mạnh mật khẩu
            const newPassword = document.getElementById('newPassword');
            const passwordStrength = document.querySelector('.password-strength');
            const passwordFeedback = document.querySelector('.password-feedback');
            
            newPassword.addEventListener('input', function() {
                const value = this.value;
                let strength = 0;
                let feedback = '';
                
                if (value.length > 0) {
                    // Kiểm tra độ dài
                    if (value.length >= 8) strength += 1;
                    
                    // Kiểm tra chữ hoa
                    if (/[A-Z]/.test(value)) strength += 1;
                    
                    // Kiểm tra chữ thường
                    if (/[a-z]/.test(value)) strength += 1;
                    
                    // Kiểm tra số
                    if (/[0-9]/.test(value)) strength += 1;
                    
                    // Kiểm tra ký tự đặc biệt
                    if (/[^A-Za-z0-9]/.test(value)) strength += 1;
                    
                    // Hiển thị thanh độ mạnh
                    passwordStrength.style.width = '100%';
                    
                    if (strength === 0) {
                        passwordStrength.style.backgroundColor = '#f8d7da';
                        feedback = 'Mật khẩu quá yếu';
                    } else if (strength <= 2) {
                        passwordStrength.style.backgroundColor = '#f56565';
                        feedback = 'Mật khẩu yếu';
                    } else if (strength <= 3) {
                        passwordStrength.style.backgroundColor = '#ed8936';
                        feedback = 'Mật khẩu trung bình';
                    } else if (strength === 4) {
                        passwordStrength.style.backgroundColor = '#48bb78';
                        feedback = 'Mật khẩu mạnh';
                    } else {
                        passwordStrength.style.backgroundColor = '#38a169';
                        feedback = 'Mật khẩu rất mạnh';
                    }
                } else {
                    passwordStrength.style.width = '0';
                    feedback = '';
                }
                
                passwordFeedback.textContent = feedback;
            });
            
            // Hiệu ứng kiểm tra xác nhận mật khẩu
            const confirmPassword = document.getElementById('confirmPassword');
            
            confirmPassword.addEventListener('input', function() {
                if (newPassword.value && this.value) {
                    if (this.value === newPassword.value) {
                        this.style.borderColor = '#38a169';
                        this.style.boxShadow = '0 0 0 0.25rem rgba(56, 161, 105, 0.25)';
                    } else {
                        this.style.borderColor = '#f56565';
                        this.style.boxShadow = '0 0 0 0.25rem rgba(245, 101, 101, 0.25)';
                    }
                } else {
                    this.style.borderColor = '';
                    this.style.boxShadow = '';
                }
            });
            
            // Kiểm tra form trước khi submit
            document.getElementById('updateProfileForm').addEventListener('submit', function(event) {
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const currentPassword = document.getElementById('currentPassword').value;
                
                // Kiểm tra mật khẩu hiện tại nếu đổi mật khẩu mới
                if (newPassword && !currentPassword) {
                    event.preventDefault();
                    
                    // Hiển thị thông báo lỗi với hiệu ứng
                    const errorAlert = document.createElement('div');
                    errorAlert.className = 'alert alert-danger';
                    errorAlert.innerHTML = '<i class="fas fa-exclamation-circle"></i> Vui lòng nhập mật khẩu hiện tại để đổi mật khẩu mới';
                    
                    const formSection = document.querySelector('.form-section');
                    formSection.insertBefore(errorAlert, formSection.firstChild);
                    
                    // Cuộn lên đầu trang
                                        window.scrollTo({
                        top: 0,
                        behavior: 'smooth'
                    });
                    
                    // Tự động xóa thông báo sau 5 giây
                    setTimeout(() => {
                        errorAlert.style.animation = 'fadeInUp 0.5s ease reverse forwards';
                        setTimeout(() => {
                            errorAlert.remove();
                        }, 500);
                    }, 5000);
                    
                    // Highlight trường mật khẩu hiện tại
                    document.getElementById('currentPassword').focus();
                    document.getElementById('currentPassword').style.borderColor = '#f56565';
                    document.getElementById('currentPassword').style.boxShadow = '0 0 0 0.25rem rgba(245, 101, 101, 0.25)';
                    
                    setTimeout(() => {
                        document.getElementById('currentPassword').style.borderColor = '';
                        document.getElementById('currentPassword').style.boxShadow = '';
                    }, 3000);
                }
                
                // Kiểm tra mật khẩu mới và xác nhận mật khẩu
                if (newPassword && newPassword !== confirmPassword) {
                    event.preventDefault();
                    
                    // Hiển thị thông báo lỗi với hiệu ứng
                    const errorAlert = document.createElement('div');
                    errorAlert.className = 'alert alert-danger';
                    errorAlert.innerHTML = '<i class="fas fa-exclamation-circle"></i> Mật khẩu mới và xác nhận mật khẩu không khớp';
                    
                    const formSection = document.querySelector('.form-section');
                    formSection.insertBefore(errorAlert, formSection.firstChild);
                    
                    // Cuộn lên đầu trang
                    window.scrollTo({
                        top: 0,
                        behavior: 'smooth'
                    });
                    
                    // Tự động xóa thông báo sau 5 giây
                    setTimeout(() => {
                        errorAlert.style.animation = 'fadeInUp 0.5s ease reverse forwards';
                        setTimeout(() => {
                            errorAlert.remove();
                        }, 500);
                    }, 5000);
                    
                    // Highlight trường xác nhận mật khẩu
                    document.getElementById('confirmPassword').focus();
                    document.getElementById('confirmPassword').style.borderColor = '#f56565';
                    document.getElementById('confirmPassword').style.boxShadow = '0 0 0 0.25rem rgba(245, 101, 101, 0.25)';
                    
                    setTimeout(() => {
                        document.getElementById('confirmPassword').style.borderColor = '';
                        document.getElementById('confirmPassword').style.boxShadow = '';
                    }, 3000);
                }
                
                // Kiểm tra độ mạnh mật khẩu nếu có nhập mật khẩu mới
                if (newPassword) {
                    let strength = 0;
                    
                    // Kiểm tra độ dài
                    if (newPassword.length >= 8) strength += 1;
                    
                    // Kiểm tra chữ hoa
                    if (/[A-Z]/.test(newPassword)) strength += 1;
                    
                    // Kiểm tra chữ thường
                    if (/[a-z]/.test(newPassword)) strength += 1;
                    
                    // Kiểm tra số
                    if (/[0-9]/.test(newPassword)) strength += 1;
                    
                    // Kiểm tra ký tự đặc biệt
                    if (/[^A-Za-z0-9]/.test(newPassword)) strength += 1;
                    
                    if (strength <= 2) {
                        event.preventDefault();
                        
                        // Hiển thị thông báo lỗi với hiệu ứng
                        const errorAlert = document.createElement('div');
                        errorAlert.className = 'alert alert-danger';
                        errorAlert.innerHTML = '<i class="fas fa-exclamation-circle"></i> Mật khẩu mới quá yếu. Vui lòng sử dụng mật khẩu mạnh hơn (ít nhất 8 ký tự, chữ hoa, chữ thường, số và ký tự đặc biệt)';
                        
                        const formSection = document.querySelector('.form-section');
                        formSection.insertBefore(errorAlert, formSection.firstChild);
                        
                        // Cuộn lên đầu trang
                        window.scrollTo({
                            top: 0,
                            behavior: 'smooth'
                        });
                        
                        // Tự động xóa thông báo sau 5 giây
                        setTimeout(() => {
                            errorAlert.style.animation = 'fadeInUp 0.5s ease reverse forwards';
                            setTimeout(() => {
                                errorAlert.remove();
                            }, 500);
                        }, 7000);
                        
                        // Highlight trường mật khẩu mới
                        document.getElementById('newPassword').focus();
                        document.getElementById('newPassword').style.borderColor = '#f56565';
                        document.getElementById('newPassword').style.boxShadow = '0 0 0 0.25rem rgba(245, 101, 101, 0.25)';
                        
                        setTimeout(() => {
                            document.getElementById('newPassword').style.borderColor = '';
                            document.getElementById('newPassword').style.boxShadow = '';
                        }, 3000);
                    }
                }
            });
            
            // Hiệu ứng cho các trường input khi focus
            const inputs = document.querySelectorAll('.form-control');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('input-focused');
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.classList.remove('input-focused');
                });
            });
            
            // Hiệu ứng cho nút back-to-top
            window.addEventListener('scroll', function() {
                const backBtn = document.querySelector('.back-btn');
                if (window.scrollY > 300) {
                    backBtn.style.opacity = '1';
                } else {
                    backBtn.style.opacity = '0.7';
                }
            });
            
            // Hiệu ứng cho thông báo alert
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                // Thêm nút đóng
                const closeBtn = document.createElement('button');
                closeBtn.type = 'button';
                closeBtn.className = 'btn-close';
                closeBtn.setAttribute('data-bs-dismiss', 'alert');
                closeBtn.setAttribute('aria-label', 'Close');
                alert.appendChild(closeBtn);
                
                // Tự động đóng sau 10 giây
                setTimeout(() => {
                    if (alert.parentNode) {
                        alert.style.animation = 'fadeInUp 0.5s ease reverse forwards';
                        setTimeout(() => {
                            if (alert.parentNode) {
                                alert.parentNode.removeChild(alert);
                            }
                        }, 500);
                    }
                }, 10000);
            });
            
            // Hiệu ứng kiểm tra số điện thoại
            const phoneInput = document.getElementById('phone');
            phoneInput.addEventListener('input', function() {
                // Chỉ cho phép nhập số
                this.value = this.value.replace(/[^0-9]/g, '');
                
                // Kiểm tra định dạng số điện thoại Việt Nam
                const phoneRegex = /^(0[3|5|7|8|9])+([0-9]{8})$/;
                
                if (this.value && !phoneRegex.test(this.value)) {
                    this.style.borderColor = '#f56565';
                    this.style.boxShadow = '0 0 0 0.25rem rgba(245, 101, 101, 0.25)';
                    
                    // Hiển thị thông báo lỗi nếu chưa có
                    if (!this.nextElementSibling || !this.nextElementSibling.classList.contains('invalid-feedback')) {
                        const feedback = document.createElement('div');
                        feedback.className = 'invalid-feedback d-block';
                        feedback.textContent = 'Vui lòng nhập đúng định dạng số điện thoại Việt Nam (10 số, bắt đầu bằng 03, 05, 07, 08, 09)';
                        this.parentNode.appendChild(feedback);
                    }
                } else {
                    this.style.borderColor = '';
                    this.style.boxShadow = '';
                    
                    // Xóa thông báo lỗi nếu có
                    if (this.nextElementSibling && this.nextElementSibling.classList.contains('invalid-feedback')) {
                        this.nextElementSibling.remove();
                    }
                }
            });
            
            // Hiệu ứng kiểm tra email
            const emailInput = document.getElementById('email');
            emailInput.addEventListener('input', function() {
                const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                
                if (this.value && !emailRegex.test(this.value)) {
                    this.style.borderColor = '#f56565';
                    this.style.boxShadow = '0 0 0 0.25rem rgba(245, 101, 101, 0.25)';
                    
                    // Hiển thị thông báo lỗi nếu chưa có
                    if (!this.nextElementSibling || !this.nextElementSibling.classList.contains('invalid-feedback')) {
                        const feedback = document.createElement('div');
                        feedback.className = 'invalid-feedback d-block';
                        feedback.textContent = 'Vui lòng nhập đúng định dạng email';
                        this.parentNode.appendChild(feedback);
                    }
                } else {
                    this.style.borderColor = '';
                    this.style.boxShadow = '';
                    
                    // Xóa thông báo lỗi nếu có
                    if (this.nextElementSibling && this.nextElementSibling.classList.contains('invalid-feedback')) {
                        this.nextElementSibling.remove();
                    }
                }
            });
        });
    </script>
</body>
</html>
