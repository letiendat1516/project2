<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký tài khoản</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <!-- SweetAlert2 -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Google Fonts -->
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
            
            .signup-container {
                width: 100%;
                max-width: 600px;
                margin: 40px auto;
                padding: 20px;
                position: relative;
            }
            
            .signup-card {
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
            
            .signup-card.visible {
                transform: translateY(0);
                opacity: 1;
            }
            
            .signup-card::before {
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
            
            .signup-header {
                text-align: center;
                margin-bottom: 35px;
                position: relative;
            }
            
            .signup-header::after {
                content: '';
                position: absolute;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 3px;
                background: var(--primary-color);
            }
            
            .signup-header h1 {
                color: var(--primary-color);
                font-family: 'Playfair Display', serif;
                font-size: 2.2rem;
                margin-bottom: 10px;
                font-weight: 700;
                letter-spacing: 1px;
            }
            
            .signup-header p {
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
            
            .password-strength-container {
                margin-top: 8px;
            }
            
            .password-strength-bar {
                height: 5px;
                background-color: #e9ecef;
                border-radius: 5px;
                margin-bottom: 5px;
                overflow: hidden;
            }
            
            .password-strength-progress {
                height: 100%;
                width: 0;
                transition: width 0.3s ease, background-color 0.3s ease;
            }
            
            .password-strength-text {
                font-size: 0.8rem;
                font-style: italic;
                display: flex;
                align-items: center;
            }
            
            .password-strength-text i {
                margin-right: 5px;
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
            
            .btn-signup {
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
            
            .btn-signup::before {
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
            
            .btn-signup:hover {
                color: var(--dark-color);
                border-color: var(--accent-color);
            }
            
            .btn-signup:hover::before {
                left: 0;
            }
            
            .btn-signup i {
                margin-right: 8px;
                transition: transform 0.3s ease;
            }
            
            .btn-signup:hover i {
                transform: translateX(5px);
            }
            
            .login-link {
                text-align: center;
                margin-top: 25px;
                font-style: italic;
                color: var(--text-color);
                position: relative;
                padding-top: 15px;
            }
            
            .login-link::before {
                content: '✦';
                position: absolute;
                top: -5px;
                left: 50%;
                transform: translateX(-50%);
                font-size: 14px;
                color: var(--accent-color);
            }
            
            .login-link a {
                color: var(--primary-color);
                font-weight: 600;
                text-decoration: none;
                position: relative;
                transition: all 0.3s ease;
            }
            
            .login-link a::after {
                content: '';
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 0;
                height: 2px;
                background-color: var(--accent-color);
                transition: width 0.3s ease;
            }
            
            .login-link a:hover {
                color: var(--accent-color);
            }
            
            .login-link a:hover::after {
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
            
            .form-check-label a {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            
            .form-check-label a:hover {
                color: var(--accent-color);
                text-decoration: underline;
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
                .signup-container {
                    padding: 15px;
                    margin: 20px auto;
                }
                
                .signup-card {
                    padding: 25px;
                }
                
                .signup-header h1 {
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
        </style>
    </head>
    <body> 
        <div class="container signup-container">
            <div class="signup-card vintage-corner" id="signup-card">
                <div class="corner-decoration top-left">❦</div>
                <div class="corner-decoration top-right">❦</div>
                <div class="corner-decoration bottom-left">❦</div>
                <div class="corner-decoration bottom-right">❦</div>
                
                
                <div class="signup-header">
                    <h1>Đăng ký tài khoản</h1>
                    <p>Hãy tham gia cùng chúng tôi để khám phá thêm nhiều điều thú vị</p>
                </div>
                
                <!-- Hiển thị thông báo lỗi nếu có -->
                <% if(request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                
                <form action="RegisterServlet" method="POST" id="signupForm">
                    <!-- Họ và tên -->
                    <div class="form-group">
                        <label for="fullName" class="form-label">
                            <i class="fas fa-user"></i> Họ và tên
                        </label>
                        <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Nhập họ và tên đầy đủ" required>
                        <div class="error-message" id="fullNameError">
                            <i class="fas fa-exclamation-circle"></i> Vui lòng nhập họ và tên hợp lệ
                        </div>
                    </div>
                    
                    <!-- Email -->
                    <div class="form-group">
                        <label for="email" class="form-label">
                            <i class="fas fa-envelope"></i> Email
                        </label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="example@domain.com" required>
                        <div class="error-message" id="emailError">
                            <i class="fas fa-exclamation-circle"></i> Vui lòng nhập email hợp lệ
                        </div>
                    </div>
                    
                    <!-- Số điện thoại -->
                    <div class="form-group">
                        <label for="phone" class="form-label">
                            <i class="fas fa-phone"></i> Số điện thoại
                        </label>
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="0xxxxxxxxx" required>
                        <div class="error-message" id="phoneError">
                            <i class="fas fa-exclamation-circle"></i> Vui lòng nhập số điện thoại hợp lệ (10 số, bắt đầu bằng 0)
                        </div>
                    </div>
                    
                    <div class="separator">
                        <div class="separator-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                    </div>
                    
                    <!-- Mật khẩu -->
                    <div class="form-group">
                        <label for="password" class="form-label">
                            <i class="fas fa-key"></i> Mật khẩu
                        </label>
                        <div class="position-relative">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Tạo mật khẩu mạnh" required>
                            <button type="button" class="password-toggle" onclick="togglePassword('password')">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="password-strength-container">
                            <div class="password-strength-bar">
                                <div class="password-strength-progress" id="passwordStrengthBar"></div>
                            </div>
                            <div class="password-strength-text" id="passwordStrengthText"></div>
                        </div>
                        <div class="error-message" id="passwordError">
                            <i class="fas fa-exclamation-circle"></i> Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt
                        </div>
                    </div>
                    
                    <!-- Xác nhận mật khẩu -->
                    <div class="form-group">
                        <label for="confirmPassword" class="form-label">
                            <i class="fas fa-check-circle"></i> Xác nhận mật khẩu
                        </label>
                        <div class="position-relative">
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                            <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="error-message" id="confirmPasswordError">
                            <i class="fas fa-exclamation-circle"></i> Mật khẩu xác nhận không khớp
                        </div>
                    </div>
                    
                    <!-- Điều khoản -->
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="terms" required>
                        <label class="form-check-label" for="terms">
                            Tôi đồng ý với <a href="#">điều khoản sử dụng</a> và <a href="#">chính sách bảo mật</a>
                        </label>
                        <div class="error-message" id="termsError">
                            <i class="fas fa-exclamation-circle"></i> Bạn cần đồng ý với điều khoản để tiếp tục
                        </div>
                    </div>
                    
                    <!-- Nút đăng ký -->
                    <button type="submit" class="btn btn-signup">
                        <i class="fas fa-user-plus"></i> Tạo tài khoản
                    </button>
                    
                    <!-- Link đăng nhập -->
                    <div class="login-link">
                        Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Bootstrap JS và Popper.js -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Hiệu ứng loading ban đầu
                const signupCard = document.getElementById('signup-card');
                
                // Thêm hiệu ứng shimmer khi đang tải
                signupCard.classList.add('shimmer');
                
                // Hiển thị form sau khi tải xong
                setTimeout(() => {
                    document.body.classList.add('loaded');
                    signupCard.classList.remove('shimmer');
                    signupCard.classList.add('visible');
                }, 600);
                
                // Kiểm tra và hiển thị thông báo thành công nếu có
                <% String successMessage = (String) request.getAttribute("success");
                   if (successMessage != null) { %>
                    Swal.fire({
                        title: 'Đăng ký thành công!',
                        text: '<%= successMessage %>',
                        icon: 'success',
                        confirmButtonText: 'Đăng nhập ngay',
                        confirmButtonColor: '#8b735a',
                        showConfirmButton: true,
                        timer: 5000,
                        timerProgressBar: true,
                        backdrop: `
                            rgba(244, 241, 234, 0.8)
                            url("https://www.transparenttextures.com/patterns/old-paper.png")
                        `
                    }).then(function(result) {
                        if (result.isConfirmed) {
                            window.location.href = 'login';
                        } else {
                            window.location.href = 'login';
                        }
                    });
                <% } %>
                
                // Validate họ tên
                const fullNameInput = document.getElementById('fullName');
                const fullNameError = document.getElementById('fullNameError');
                
                fullNameInput.addEventListener('input', function() {
                    const value = this.value.trim();
                    if (value.length < 2 || !/^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễếệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\s]+$/.test(value)) {
                        fullNameError.classList.add('show');
                        this.style.borderColor = 'var(--error-color)';
                    } else {
                        fullNameError.classList.remove('show');
                        this.style.borderColor = '';
                    }
                });
                
                // Validate email
                const emailInput = document.getElementById('email');
                const emailError = document.getElementById('emailError');
                
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
                
                // Validate số điện thoại
                const phoneInput = document.getElementById('phone');
                const phoneError = document.getElementById('phoneError');
                
                phoneInput.addEventListener('input', function() {
                    // Chỉ cho phép nhập số
                    this.value = this.value.replace(/[^0-9]/g, '');
                    
                    const value = this.value.trim();
                    const phoneRegex = /^(0[3|5|7|8|9])+([0-9]{8})$/;
                    
                    if (!phoneRegex.test(value)) {
                        phoneError.classList.add('show');
                        this.style.borderColor = 'var(--error-color)';
                    } else {
                        phoneError.classList.remove('show');
                        this.style.borderColor = '';
                    }
                });
                
                // Kiểm tra độ mạnh mật khẩu
                const passwordInput = document.getElementById('password');
                const passwordError = document.getElementById('passwordError');
                const passwordStrengthBar = document.getElementById('passwordStrengthBar');
                const passwordStrengthText = document.getElementById('passwordStrengthText');
                
                passwordInput.addEventListener('input', function() {
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
                        passwordStrengthBar.style.width = (strength * 20) + '%';
                        
                        if (strength === 0) {
                            passwordStrengthBar.style.backgroundColor = '#f8d7da';
                            passwordStrengthText.innerHTML = '<i class="fas fa-exclamation-circle text-danger"></i> Mật khẩu quá yếu';
                            passwordStrengthText.style.color = 'var(--error-color)';
                        } else if (strength <= 2) {
                            passwordStrengthBar.style.backgroundColor = '#f56565';
                            passwordStrengthText.innerHTML = '<i class="fas fa-exclamation-triangle text-danger"></i> Mật khẩu yếu';
                            passwordStrengthText.style.color = '#f56565';
                        } else if (strength === 3) {
                            passwordStrengthBar.style.backgroundColor = '#ed8936';
                            passwordStrengthText.innerHTML = '<i class="fas fa-info-circle text-warning"></i> Mật khẩu trung bình';
                            passwordStrengthText.style.color = '#ed8936';
                        } else if (strength === 4) {
                            passwordStrengthBar.style.backgroundColor = '#48bb78';
                            passwordStrengthText.innerHTML = '<i class="fas fa-check-circle text-success"></i> Mật khẩu mạnh';
                            passwordStrengthText.style.color = '#48bb78';
                        } else {
                            passwordStrengthBar.style.backgroundColor = '#38a169';
                            passwordStrengthText.innerHTML = '<i class="fas fa-shield-alt text-success"></i> Mật khẩu rất mạnh';
                            passwordStrengthText.style.color = '#38a169';
                        }
                        
                        // Hiển thị lỗi nếu mật khẩu yếu
                        if (strength <= 2) {
                            passwordError.classList.add('show');
                            this.style.borderColor = 'var(--error-color)';
                        } else {
                            passwordError.classList.remove('show');
                            this.style.borderColor = '';
                        }
                    } else {
                        passwordStrengthBar.style.width = '0';
                        passwordStrengthText.innerHTML = '';
                        passwordError.classList.remove('show');
                        this.style.borderColor = '';
                    }
                });
                
                // Kiểm tra xác nhận mật khẩu
                const confirmPasswordInput = document.getElementById('confirmPassword');
                const confirmPasswordError = document.getElementById('confirmPasswordError');
                
                confirmPasswordInput.addEventListener('input', function() {
                    const passwordValue = passwordInput.value;
                    const confirmValue = this.value;
                    
                    if (confirmValue && confirmValue !== passwordValue) {
                        confirmPasswordError.classList.add('show');
                        this.style.borderColor = 'var(--error-color)';
                    } else {
                        confirmPasswordError.classList.remove('show');
                        this.style.borderColor = '';
                    }
                });
                
                // Kiểm tra điều khoản
                const termsCheckbox = document.getElementById('terms');
                const termsError = document.getElementById('termsError');
                
                termsCheckbox.addEventListener('change', function() {
                    if (!this.checked) {
                        termsError.classList.add('show');
                    } else {
                        termsError.classList.remove('show');
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
            });
            
            // Hàm toggle password
            function togglePassword(inputId) {
                const input = document.getElementById(inputId);
                const icon = input.nextElementSibling.querySelector('i');
                
                if (input.type === "password") {
                    input.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    input.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }
            
            // Validate form trước khi submit
            document.getElementById('signupForm').addEventListener('submit', function(event) {
                let hasError = false;
                
                // Kiểm tra họ tên
                const fullName = document.getElementById('fullName').value.trim();
                if (fullName.length < 2 || !/^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễếệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\s]+$/.test(fullName)) {
                    document.getElementById('fullNameError').classList.add('show');
                    document.getElementById('fullName').style.borderColor = 'var(--error-color)';
                    hasError = true;
                }
                
                // Kiểm tra email
                const email = document.getElementById('email').value.trim();
                const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if (!emailRegex.test(email)) {
                    document.getElementById('emailError').classList.add('show');
                    document.getElementById('email').style.borderColor = 'var(--error-color)';
                    hasError = true;
                }
                
                // Kiểm tra số điện thoại
                const phone = document.getElementById('phone').value.trim();
                const phoneRegex = /^(0[3|5|7|8|9])+([0-9]{8})$/;
                if (!phoneRegex.test(phone)) {
                    document.getElementById('phoneError').classList.add('show');
                    document.getElementById('phone').style.borderColor = 'var(--error-color)';
                    hasError = true;
                }
                
                // Kiểm tra mật khẩu
                const password = document.getElementById('password').value;
                let passwordStrength = 0;
                
                // Kiểm tra độ dài
                if (password.length >= 8) passwordStrength += 1;
                
                // Kiểm tra chữ hoa
                if (/[A-Z]/.test(password)) passwordStrength += 1;
                
                // Kiểm tra chữ thường
                if (/[a-z]/.test(password)) passwordStrength += 1;
                
                // Kiểm tra số
                if (/[0-9]/.test(password)) passwordStrength += 1;
                
                // Kiểm tra ký tự đặc biệt
                if (/[^A-Za-z0-9]/.test(password)) passwordStrength += 1;
                
                if (passwordStrength <= 2) {
                    document.getElementById('passwordError').classList.add('show');
                    document.getElementById('password').style.borderColor = 'var(--error-color)';
                    hasError = true;
                }
                
                // Kiểm tra xác nhận mật khẩu
                const confirmPassword = document.getElementById('confirmPassword').value;
                if (password !== confirmPassword) {
                    document.getElementById('confirmPasswordError').classList.add('show');
                    document.getElementById('confirmPassword').style.borderColor = 'var(--error-color)';
                    hasError = true;
                }
                
                // Kiểm tra điều khoản
                const terms = document.getElementById('terms').checked;
                if (!terms) {
                    document.getElementById('termsError').classList.add('show');
                    hasError = true;
                }
                
                // Nếu có lỗi, ngăn form submit và hiển thị thông báo
                if (hasError) {
                    event.preventDefault();
                    
                    // Cuộn lên đầu trang để hiển thị lỗi
                    window.scrollTo({
                        top: 0,
                        behavior: 'smooth'
                    });
                    
                    // Hiển thị thông báo lỗi tổng hợp
                    Swal.fire({
                        title: 'Lỗi!',
                        text: 'Vui lòng kiểm tra lại thông tin đăng ký',
                        icon: 'error',
                        confirmButtonText: 'Đã hiểu',
                        confirmButtonColor: 'var(--primary-color)',
                        background: 'var(--secondary-color)',
                        backdrop: `
                            rgba(155, 44, 44, 0.2)
                            url("https://www.transparenttextures.com/patterns/old-paper.png")
                        `
                    });
                } else {
                    // Nếu không có lỗi, hiển thị thông báo đang xử lý
                    Swal.fire({
                        title: 'Đang xử lý...',
                        text: 'Vui lòng đợi trong giây lát',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        },
                        background: 'var(--secondary-color)',
                        backdrop: `
                            rgba(244, 241, 234, 0.8)
                            url("https://www.transparenttextures.com/patterns/old-paper.png")
                        `
                    });
                }
            });
            
            // Thêm hiệu ứng khi hover vào nút đăng ký
            document.querySelector('.btn-signup').addEventListener('mouseenter', function() {
                const icon = this.querySelector('i');
                icon.classList.add('fa-fade');
            });
            
            document.querySelector('.btn-signup').addEventListener('mouseleave', function() {
                const icon = this.querySelector('i');
                icon.classList.remove('fa-fade');
            });
        </script>
    </body>
</html>

