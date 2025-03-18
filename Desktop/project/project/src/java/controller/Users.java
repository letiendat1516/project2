package controller;

import dal.UserDAO;
import model.User;
import utils.PasswordHash;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ProfileController", urlPatterns = {"/profile", "/editProfile", "/updateProfile"})
public class Users extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (loggedInUser == null) {
            response.sendRedirect("login");
            return;
        }
        
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(loggedInUser.getUserId());
            String roleName = userDAO.getRoleName(user.getRoleId());
            
            request.setAttribute("user", user);
            request.setAttribute("roleName", roleName);
            
            if (path.equals("/profile")) {
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            } else if (path.equals("/editProfile")) {
                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi truy xuất dữ liệu người dùng: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (loggedInUser == null) {
            response.sendRedirect("login");
            return;
        }
        
        if (path.equals("/updateProfile")) {
            try {
                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserById(loggedInUser.getUserId());
                
                // Lấy dữ liệu từ form
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");
                
                // Kiểm tra email đã tồn tại
                if (!email.equals(user.getEmail()) && userDAO.isEmailExists(email)) {
                    request.setAttribute("errorMessage", "Email đã được sử dụng bởi tài khoản khác.");
                    request.setAttribute("user", user);
                    request.setAttribute("roleName", userDAO.getRoleName(user.getRoleId()));
                    request.getRequestDispatcher("editProfile.jsp").forward(request, response);
                    return;
                }
                
                // Kiểm tra số điện thoại đã tồn tại
                if (!phone.equals(user.getPhone()) && userDAO.isPhoneExists(phone)) {
                    request.setAttribute("errorMessage", "Số điện thoại đã được sử dụng bởi tài khoản khác.");
                    request.setAttribute("user", user);
                    request.setAttribute("roleName", userDAO.getRoleName(user.getRoleId()));
                    request.getRequestDispatcher("editProfile.jsp").forward(request, response);
                    return;
                }
                
                // Cập nhật đối tượng user
                user.setFullName(fullName);
                user.setEmail(email);
                user.setPhone(phone);
                user.setAddress(address);
                
                // Khi kiểm tra mật khẩu hiện tại
if (newPassword != null && !newPassword.isEmpty()) {
    // Lấy mật khẩu hiện tại đã mã hóa từ database
    String storedPassword = userDAO.getUserPassword(user.getUserId());
    
    // Xác thực mật khẩu người dùng nhập
    if (!PasswordHash.verifyPassword(currentPassword, storedPassword)) {
        request.setAttribute("errorMessage", "Mật khẩu hiện tại không đúng.");
        request.setAttribute("user", user);
        request.setAttribute("roleName", userDAO.getRoleName(user.getRoleId()));
        request.getRequestDispatcher("editProfile.jsp").forward(request, response);
        return;
    }
    
    // Mã hóa mật khẩu mới
    user.setPassword(PasswordHash.hashPassword(newPassword));
}

                
                // Cập nhật người dùng trong database
                boolean updated = userDAO.updateUser(user);
                
                if (updated) {
                    // Cập nhật người dùng trong session
                    session.setAttribute("user", user);
                    request.setAttribute("successMessage", "Cập nhật hồ sơ thành công!");
                } else {
                    request.setAttribute("errorMessage", "Không thể cập nhật hồ sơ. Vui lòng thử lại.");
                }
                
                // Lấy tên vai trò và chuyển hướng trở lại trang chỉnh sửa
                request.setAttribute("user", user);
                request.setAttribute("roleName", userDAO.getRoleName(user.getRoleId()));
                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
                
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Lỗi khi cập nhật hồ sơ: " + e.getMessage());
                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            }
        }
    }
}
