<%-- 
    Author     : DAT, HUY
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Đăng nhập vào hệ thống">
        <meta name="robots" content="noindex, nofollow">
        <!-- Prevent caching of this page -->
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
        
        <title>Đăng nhập</title>
        
        <!-- CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
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
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                transition: opacity 1s ease;
            }
            
            body.loaded {
                opacity: 1;
            }
            
            .login-container {
                width: 100%;
                max-width: 450px;
                margin: 40px auto;
                padding: 20px;
                position: relative;
            }
            
            .login-card {
                background-color: var(--secondary-color);
                border-radius: 12px;
                box-shadow: 0 8px 30px rgba(0,0,0,0.15);
                padding: 40px;
                position: relative;
                overflow: hidden;
                border: 1px solid var(--border-color);
                transform: translateY(30px);
                opacity: 0;
                transition: all 0.8s ease;
                background-image: url('https://www.transparenttextures.com/patterns/old-paper.png');
            }
            
            .login-card.visible {
                transform: translateY(0);
                opacity: 1;
            }
            
            .login-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 5px;
                background-color: var(--primary-color);
            }
            
            .vintage-corner {
                position: relative;
            }
            
            .corner-decoration {
                position: absolute;
                color: var(--accent-color);
                font-size: 24px;
                opacity: 0.6;
                transition: all 0.5s ease;
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
                color: var(--primary-color);
            }
            
            .login-header {
                text-align: center;
                margin-bottom: 35px;
                position: relative;
            }
            
            .login-header::after {
                content: '';
                position: absolute;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 3px;
                background: var(--primary-color);
            }
            
            .login-header h1 {
                color: var(--primary-color);
                font-family: 'Playfair Display', serif;
                font-size: 2.2rem;
                margin-bottom: 10px;
                font-weight: 700;
                letter-spacing: 1px;
            }
            
            .login-header p {
                color: var(--text-color);
                font-style: italic;
            }
            
            .form-group {
                margin-bottom: 1.5rem;
                position: relative;
            }
            
            .form-label {
                color: var(--primary-color);
                font-weight: 600;
                font-size: 0.95rem;
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
                border-radius: 8px;
                padding: 14px 15px;
                background-color: rgba(255, 255, 255, 0.7);
                color: var(--dark-color);
                transition: all 0.3s ease;
                font-family: 'Roboto Slab', serif;
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
            
            .password-toggle {
                cursor: pointer;
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--primary-color);
                z-index: 10;
                background: transparent;
                border: none;
                padding: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 30px;
                height: 30px;
                transition: all 0.3s ease;
            }
            
            .password-toggle:hover {
                color: var(--accent-color);
            }
            
            .btn {
                padding: 14px 25px;
                font-weight: 600;
                border-radius: 30px;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
                letter-spacing: 0.5px;
                font-family: 'Roboto Slab', serif;
            }
            
            .btn-login {
                background-color: var(--primary-color);
                border: 2px solid var(--primary-color);
                color: white;
                width: 100%;
                margin-top: 25px;
                font-size: 1.1rem;
                position: relative;
                overflow: hidden;
                z-index: 1;
            }
            
            .btn-login::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: var(--accent-color);
                transition: all 0.4s ease;
                z-index: -1;
            }
            
            .btn-login:hover {
                color: var(--dark-color);
                border-color: var(--accent-color);
            }
            
            .btn-login:hover::before {
                left: 0;
            }
            
            .btn-login i {
                margin-right: 8px;
                transition: transform 0.3s ease;
            }
            
            .btn-login:hover i {
                transform: translateX(5px);
            }
            
            .links-container {
                text-align: center;
                margin-top: 25px;
                font-style: italic;
                color: var(--text-color);
                position: relative;
                padding-top: 15px;
                display: flex;
                flex-direction: column;
                gap: 12px;
            }
            
            .links-container::before {
                content: '✦';
                position: absolute;
                top: -5px;
                left: 50%;
                transform: translateX(-50%);
                font-size: 14px;
                color: var(--accent-color);
            }
            
            .links-container a {
                color: var(--primary-color);
                font-weight: 600;
                text-decoration: none;
                position: relative;
                transition: all 0.3s ease;
            }
            
            .links-container a::after {
                content: '';
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 0;
                height: 2px;
                background-color: var(--accent-color);
                transition: width 0.3s ease;
            }
            
            .links-container a:hover {
                color: var(--accent-color);
            }
            
            .links-container a:hover::after {
                width: 100%;
            }
            
            .form-check {
                margin-top: 15px;
                margin-bottom: 15px;
                padding-left: 30px;
            }
            
            .form-check-input {
                width: 18px;
                height: 18px;
                margin-top: 0.2rem;
                margin-left: -30px;
                border: 1px solid var(--border-color);
                cursor: pointer;
            }
            
            .form-check-input:checked {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }
            
            .form-check-input:focus {
                border-color: var(--accent-color);
                box-shadow: 0 0 0 0.25rem rgba(210, 180, 140, 0.25);
            }
            
            .form-check-label {
                font-size: 0.9rem;
                cursor: pointer;
            }
            
            .alert {
                border-radius: 8px;
                padding: 15px 20px;
                margin-bottom: 25px;
                border: none;
                position: relative;
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
            
            .error-message {
                color: var(--error-color);
                font-size: 0.85rem;
                margin-top: 5px;
                display: none;
                animation: fadeInDown 0.3s ease;
            }
            
            .error-message.show {
                display: block;
            }
            
            .error-message i {
                margin-right: 5px;
            }
            
            .separator {
                display: flex;
                align-items: center;
                text-align: center;
                margin: 25px 0;
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
                width: 30px;
                height: 30px;
                background-color: var(--accent-color);
                color: white;
                border-radius: 50%;
                font-size: 0.8rem;
            }
            
            /* Hiệu ứng animation */
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
            
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
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
                .login-container {
                    padding: 15px;
                    margin: 20px auto;
                }
                
                .login-card {
                    padding: 25px;
                }
                
                .login-header h1 {
                    font-size: 1.8rem;
                }
            }
            
            /* Hiệu ứng nổi */
            .floating {
                animation: floating 3s ease-in-out infinite;
            }
            
            @keyframes floating {
                0% { transform: translateY(0px); }
                50% { transform: translateY(-10px); }
                100% { transform: translateY(0px); }
            }
            
            .logo {
                position: absolute;
                top: -60px;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 100px;
                background-color: var(--secondary-color);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                border: 3px solid var(--accent-color);
                z-index: 10;
            }
            
            .logo i {
                font-size: 2.5rem;
                color: var(--primary-color);
            }
            
            /* Loading spinner */
            .spinner-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(248, 245, 240, 0.8);
                background-image: url('https://www.transparenttextures.com/patterns/old-paper.png');
                z-index: 9999;
            }
            
            .spinner-center {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                text-align: center;
            }
            
            .vintage-spinner {
                width: 80px;
                height: 80px;
                margin: 0 auto;
                position: relative;
            }
            
            .vintage-spinner::before {
                content: "";
                box-sizing: border-box;
                position: absolute;
                width: 80px;
                height: 80px;
                border: 4px solid var(--primary-color);
                border-radius: 50%;
                border-top-color: var(--accent-color);
                animation: spin 1s ease-in-out infinite;
            }
            
            .spinner-text {
                margin-top: 20px;
                font-family: 'Playfair Display', serif;
                font-style: italic;
                color: var(--primary-color);
            }
            
            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }
            
            /* Remember me checkbox */
            .remember-me {
                display: flex;
                align-items: center;
                margin-top: 15px;
            }
            
            .remember-me input[type="checkbox"] {
                appearance: none;
                -webkit-appearance: none;
                width: 20px;
                height: 20px;
                border: 2px solid var(--border-color);
                border-radius: 4px;
                margin-right: 10px;
                position: relative;
                cursor: pointer;
                background-color: rgba(255, 255, 255, 0.7);
            }
            
            .remember-me input[type="checkbox"]:checked {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }
            
            .remember-me input[type="checkbox"]:checked::after {
                content: '✓';
                position: absolute;
                color: white;
                font-size: 14px;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }
            
            .remember-me label {
                font-size: 0.9rem;
                color: var(--text-color);
                cursor: pointer;
            }
            
            /* Or separator */
            .or-separator {
                display: flex;
                align-items: center;
                text-align: center;
                margin: 20px 0;
            }
            
            .or-separator::before,
            .or-separator::after {
                content: '';
                flex: 1;
                border-bottom: 1px solid var(--border-color);
            }
            
            .or-separator-text {
                padding: 0 10px;
                color: var(--text-color);
                font-style: italic;
            }
        </style>
    </head>
    <body> 
        <!-- Loading Spinner -->
        <div class="spinner-overlay" id="loadingSpinner">
            <div class="spinner-center">
                <div class="vintage-spinner"></div>
                <p class="spinner-text">Đang đăng nhập...</p>
            </div>
        </div>
        
        <div class="container login-container">
            <div class="login-card vintage-corner" id="login-card">
                <div class="corner-decoration top-left">❦</div>
                <div class="corner-decoration top-right">❦</div>
                <div class="corner-decoration bottom-left">❦</div>
                <div class="corner-decoration bottom-right">❦</div>
                
                <div class="login-header">
                    <h1>Đăng nhập</h1>
                    <p>Chào mừng bạn quay trở lại</p>
                </div>
                
                <!-- Hiển thị thông báo lỗi nếu có -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/login" method="POST" 
                      id="loginForm" novalidate autocomplete="off">
                    <!-- CSRF Token -->
                    <input type="hidden" name="csrf_token" value="${csrf_token}">
                    
                    <!-- Email input -->
                    <div class="form-group">
                        <label for="email" class="form-label">
                            <i class="fas fa-envelope"></i> Email
                        </label>
                        <input type="email" class="form-control" id="email" name="email" 
                               placeholder="Nhập địa chỉ email" required
                               pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                               value="${cookie.rememberedEmail.value}">
                        <div class="error-message" id="emailError">
                            <i class="fas fa-exclamation-circle"></i> Vui lòng nhập email hợp lệ
                        </div>
                    </div>
                    
                    <!-- Password input -->
                    <div class="form-group">
                        <label for="password" class="form-label">
                            <i class="fas fa-key"></i> Mật khẩu
                        </label>
                        <div class="position-relative">
                            <input type="password" class="form-control" id="password" 
                                   name="password" placeholder="Nhập mật khẩu" required>
                            <button type="button" class="password-toggle" id="togglePassword">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="error-message" id="passwordError">
                            <i class="fas fa-exclamation-circle"></i> Vui lòng nhập mật khẩu
                        </div>
                    </div>
                    
                    <!-- Remember me -->
                    <div class="remember-me">
                        <input type="checkbox" id="rememberMe" name="rememberMe" 
                               ${not empty cookie.rememberedEmail.value ? 'checked' : ''}>
                        <label for="rememberMe">Ghi nhớ đăng nhập</label>
                    </div>
                    
                    <!-- Submit button -->
                    <button type="submit" class="btn btn-login" id="loginBtn">
                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                    </button>
                    
                    <!-- Links -->
                    <div class="links-container">
                        <a href="${pageContext.request.contextPath}/forgot-password.jsp" 
                           class="forgot-password-link">
                            <i class="fas fa-question-circle"></i> Quên mật khẩu?
                        </a>
                        
                        <div class="or-separator">
                            <span class="or-separator-text">hoặc</span>
                        </div>
                        
                        <a href="${pageContext.request.contextPath}/signup.jsp" 
                           class="signup-link">
                            <i class="fas fa-user-plus"></i> Đăng ký tài khoản mới
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Hiệu ứng loading ban đầu
                const loginCard = document.getElementById('login-card');
                
                // Thêm hiệu ứng shimmer khi đang tải
                loginCard.classList.add('shimmer');
                
                // Hiển thị form sau khi tải xong
                setTimeout(() => {
                    document.body.classList.add('loaded');
                    loginCard.classList.remove('shimmer');
                    loginCard.classList.add('visible');
                }, 600);
                
                const form = document.getElementById('loginForm');
                const loginBtn = document.getElementById('loginBtn');
                const loadingSpinner = document.getElementById('loadingSpinner');
                const emailInput = document.getElementById('email');
                const passwordInput = document.getElementById('password');
                const emailError = document.getElementById('emailError');
                const passwordError = document.getElementById('passwordError');
                
                // Validate email
                emailInput.addEventListener('input', function() {
                    const value = this.value.trim();
                    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                    
                    if (!emailRegex.test(value)) {
                        emailError.classList.add('show');
                        this.style.borderColor = 'var(--error-color)';
                    } else {
                        emailError.classList.remove('show');
                        this.style.borderColor = '';
                    }
                });
                
                // Validate password
                passwordInput.addEventListener('input', function() {
                    const value = this.value.trim();
                    
                    if (value.length === 0) {
                        passwordError.classList.add('show');
                        this.style.borderColor = 'var(--error-color)';
                    } else {
                        passwordError.classList.remove('show');
                        this.style.borderColor = '';
                    }
                });
                
                // Form validation
                form.addEventListener('submit', function(event) {
                    event.preventDefault();
                    let hasError = false;
                    
                    // Validate email
                    const email = emailInput.value.trim();
                    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                    if (!emailRegex.test(email)) {
                        emailError.classList.add('show');
                        emailInput.style.borderColor = 'var(--error-color)';
                        hasError = true;
                    }
                    
                    // Validate password
                    const password = passwordInput.value.trim();
                    if (password.length === 0) {
                        passwordError.classList.add('show');
                        passwordInput.style.borderColor = 'var(--error-color)';
                        hasError = true;
                    }
                    
                    if (hasError) {
                        // Hiển thị thông báo lỗi
                        Swal.fire({
                            title: 'Lỗi!',
                            text: 'Vui lòng kiểm tra lại thông tin đăng nhập',
                            icon: 'error',
                            confirmButtonText: 'Đã hiểu',
                            confirmButtonColor: 'var(--primary-color)',
                            background: 'var(--secondary-color)',
                            backdrop: `
                                rgba(155, 44, 44, 0.2)
                                url("https://www.transparenttextures.com/patterns/old-paper.png")
                            `
                        });
                        return;
                    }
                    
                    // Show loading
                    loginBtn.disabled = true;
                    loginBtn.innerHTML = '<i class="fas fa-circle-notch fa-spin"></i> Đang xử lý...';
                    loadingSpinner.style.display = 'block';
                    
                    // Submit form
                    setTimeout(() => {
                        form.submit();
                    }, 800);
                });

                // Password visibility toggle
                const togglePassword = document.getElementById('togglePassword');
                
                togglePassword.addEventListener('click', function() {
                    const type = passwordInput.type === 'password' ? 'text' : 'password';
                    passwordInput.type = type;
                    
                    const icon = this.querySelector('i');
                    if (type === 'text') {
                        icon.classList.remove('fa-eye');
                        icon.classList.add('fa-eye-slash');
                    } else {
                        icon.classList.remove('fa-eye-slash');
                        icon.classList.add('fa-eye');
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
                            decoration.style.opacity = '0.6';
                        });
                    });
                });
                
                // Thêm hiệu ứng khi hover vào nút đăng nhập
                document.querySelector('.btn-login').addEventListener('mouseenter', function() {
                    const icon = this.querySelector('i');
                    icon.classList.add('fa-fade');
                });
                
                document.querySelector('.btn-login').addEventListener('mouseleave', function() {
                    const icon = this.querySelector('i');
                    icon.classList.remove('fa-fade');
                });
                
                // Success message handling
                <c:if test="${not empty success}">
                    Swal.fire({
                        title: 'Thành công!',
                        text: 'Đăng nhập thành công!',
                        icon: 'success',
                        showConfirmButton: false,
                        timer: 1500,
                        background: 'var(--secondary-color)',
                        backdrop: `
                            rgba(44, 155, 79, 0.2)
                            url("https://www.transparenttextures.com/patterns/old-paper.png")
                        `
                    }).then(() => {
                        window.location.href = '${pageContext.request.contextPath}/dashboard';
                    });
                </c:if>
                
               
                // Hiệu ứng cho checkbox "Ghi nhớ đăng nhập"
                const rememberMeCheckbox = document.getElementById('rememberMe');
                rememberMeCheckbox.addEventListener('change', function() {
                    if (this.checked) {
                        this.parentElement.classList.add('checked');
                    } else {
                        this.parentElement.classList.remove('checked');
                    }
                });
                
                // Kiểm tra trạng thái ban đầu của checkbox
                if (rememberMeCheckbox.checked) {
                    rememberMeCheckbox.parentElement.classList.add('checked');
                }
            });
            
            // Prevent form resubmission
            if (window.history.replaceState) {
                window.history.replaceState(null, null, window.location.href);
            }
        </script>
    </body>
</html>
