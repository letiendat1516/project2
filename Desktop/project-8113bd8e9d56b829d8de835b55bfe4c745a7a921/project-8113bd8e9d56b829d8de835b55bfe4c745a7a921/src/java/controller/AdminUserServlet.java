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
import java.util.Date;
import java.util.List;

@WebServlet(name = "AdminUserServlet", urlPatterns = {"/admin_users"})
public class AdminUserServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Đảm bảo tiếng Việt hiển thị đúng
        request.setCharacterEncoding("UTF-8");
        
        // Lấy session và kiểm tra quyền truy cập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Lấy thông tin người dùng hiện tại
        User currentUser = (User) session.getAttribute("user");
        
        // Đặt thuộc tính cho JSP biết vai trò của người dùng hiện tại
        request.setAttribute("isAdmin", currentUser.isAdmin());
        request.setAttribute("isStaff", currentUser.isStaff());
        
        String action = request.getParameter("action");
        
        try {
            if ("edit".equals(action)) {
                // Lấy thông tin người dùng cần sửa
                int userId = Integer.parseInt(request.getParameter("id"));
                User user = userDAO.getUserById(userId);
                request.setAttribute("editUser", user);
            } else if ("delete".equals(action)) {
                // Xóa người dùng - Chỉ admin mới có quyền xóa
                if (!currentUser.isAdmin()) {
                    request.setAttribute("errorMessage", "Bạn không có quyền xóa người dùng.");
                } else {
                    int userId = Integer.parseInt(request.getParameter("id"));
                    boolean success = userDAO.deleteUser(userId);
                    
                    if (success) {
                        request.setAttribute("successMessage", "Xóa người dùng thành công.");
                    } else {
                        request.setAttribute("errorMessage", "Không thể xóa người dùng.");
                    }
                }
            }
            
            // Lấy danh sách người dùng và hiển thị
            List<User> userList = userDAO.getAllUsers();
            request.setAttribute("userList", userList);
            
            request.getRequestDispatcher("admin_users.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("admin_users.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Đảm bảo tiếng Việt hiển thị đúng
        request.setCharacterEncoding("UTF-8");
        
        // Lấy session và kiểm tra quyền truy cập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Lấy thông tin người dùng hiện tại
        User currentUser = (User) session.getAttribute("user");
        
        // Đặt thuộc tính cho JSP biết vai trò của người dùng hiện tại
        request.setAttribute("isAdmin", currentUser.isAdmin());
        request.setAttribute("isStaff", currentUser.isStaff());

        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action) || "update".equals(action)) {
                // Lấy thông tin từ form
                String userIdStr = request.getParameter("userId");
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String password = request.getParameter("password");
                int roleId = Integer.parseInt(request.getParameter("roleId"));
                boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
                
                // Kiểm tra quyền cập nhật role - Chỉ admin mới có quyền thay đổi role
                if (currentUser.isStaff()) {
                    // Nếu là staff, không được phép thay đổi role
                    if ("add".equals(action)) {
                        // Khi thêm mới, staff chỉ được phép tạo user thông thường
                        roleId = User.ROLE_USER;
                    } else if ("update".equals(action)) {
                        // Khi cập nhật, staff không được phép thay đổi role, phải giữ nguyên role cũ
                        User existingUser = userDAO.getUserById(Integer.parseInt(userIdStr));
                        roleId = existingUser.getRoleId();
                    }
                }
                
                User user = new User();
                if (userIdStr != null && !userIdStr.isEmpty()) {
                    user.setUserId(Integer.parseInt(userIdStr));
                }
                user.setFullName(fullName);
                user.setEmail(email);
                user.setPhone(phone);
                user.setRoleId(roleId);
                user.setIsActive(isActive);
                
                if ("add".equals(action)) {
                    // Thêm người dùng mới
                    if (password != null && !password.isEmpty()) {
                        user.setPassword(PasswordHash.hashPassword(password)); // Mã hóa mật khẩu trước khi lưu
                    } else {
                        request.setAttribute("errorMessage", "Mật khẩu không được để trống khi thêm người dùng mới.");
                        List<User> userList = userDAO.getAllUsers();
                        request.setAttribute("userList", userList);
                        request.getRequestDispatcher("admin_users.jsp").forward(request, response);
                        return;
                    }
                    user.setCreatedAt(new Date());
                    int userId = userDAO.register(user);
                    if (userId > 0) {
                        request.setAttribute("successMessage", "Thêm người dùng mới thành công.");
                    } else {
                        request.setAttribute("errorMessage", "Không thể thêm người dùng mới.");
                    }
                } else {
                    // Cập nhật người dùng đã tồn tại
                    User existingUser = userDAO.getUserById(user.getUserId());
                    if (password != null && !password.isEmpty()) {
                        user.setPassword(PasswordHash.hashPassword(password)); // Mã hóa mật khẩu mới
                    } else {
                        // Giữ lại mật khẩu cũ nếu không có mật khẩu mới
                        user.setPassword(existingUser.getPassword());
                    }
                    user.setCreatedAt(existingUser.getCreatedAt());
                    boolean success = userDAO.updateUser(user);
                    if (success) {
                        request.setAttribute("successMessage", "Cập nhật người dùng thành công.");
                    } else {
                        request.setAttribute("errorMessage", "Không thể cập nhật người dùng.");
                    }
                }
            }
            
            // Lấy danh sách người dùng mới nhất và hiển thị
            List<User> userList = userDAO.getAllUsers();
            request.setAttribute("userList", userList);
            
            request.getRequestDispatcher("admin_users.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("admin_users.jsp").forward(request, response);
        }
    }
}
