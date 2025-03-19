//Author: DAT, DANG
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
    // Định nghĩa email admin được bảo vệ
    private static final String PROTECTED_ADMIN_EMAIL = "tiendat1516@gmail.com";

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
                    
                    // Kiểm tra xem người dùng cần xóa có phải là admin được bảo vệ không
                    User userToDelete = userDAO.getUserById(userId);
                    if (userToDelete != null && PROTECTED_ADMIN_EMAIL.equals(userToDelete.getEmail())) {
                        request.setAttribute("errorMessage", "Không thể xóa tài khoản Admin được bảo vệ.");
                    } else {
                        boolean success = userDAO.deleteUser(userId);
                        
                        if (success) {
                            request.setAttribute("successMessage", "Xóa người dùng thành công.");
                        } else {
                            request.setAttribute("errorMessage", "Không thể xóa người dùng.");
                        }
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
                
                // Biến để theo dõi việc bảo vệ tài khoản admin
                boolean isProtectedAccount = false;
                boolean attemptedRoleChange = false;
                boolean attemptedStatusChange = false;
                
                // Kiểm tra nếu đang cập nhật tài khoản admin được bảo vệ
                if ("update".equals(action) && userIdStr != null && !userIdStr.isEmpty()) {
                    User existingUser = userDAO.getUserById(Integer.parseInt(userIdStr));
                    if (existingUser != null && PROTECTED_ADMIN_EMAIL.equals(existingUser.getEmail())) {
                        isProtectedAccount = true;
                        
                        // Kiểm tra nếu có nỗ lực thay đổi vai trò
                        if (roleId != User.ROLE_ADMIN) {
                            attemptedRoleChange = true;
                            roleId = User.ROLE_ADMIN; // Đảm bảo vẫn giữ vai trò admin
                        }
                        
                        // Kiểm tra nếu có nỗ lực thay đổi trạng thái active
                        if (!isActive) {
                            attemptedStatusChange = true;
                            isActive = true; // Đảm bảo vẫn active
                        }
                    }
                }
                
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
                    
                    // Kiểm tra lại một lần nữa nếu là admin được bảo vệ
                    if (PROTECTED_ADMIN_EMAIL.equals(existingUser.getEmail())) {
                        isProtectedAccount = true;
                        
                        if (user.getRoleId() != User.ROLE_ADMIN) {
                            attemptedRoleChange = true;
                            user.setRoleId(User.ROLE_ADMIN); // Đảm bảo admin được bảo vệ luôn có vai trò admin
                        }
                        
                        if (!user.isIsActive()) {
                            attemptedStatusChange = true;
                            user.setIsActive(true); // Đảm bảo admin được bảo vệ luôn active
                        }
                    }
                    
                    if (password != null && !password.isEmpty()) {
                        user.setPassword(PasswordHash.hashPassword(password)); // Mã hóa mật khẩu mới
                    } else {
                        // Giữ lại mật khẩu cũ nếu không có mật khẩu mới
                        user.setPassword(existingUser.getPassword());
                    }
                    user.setCreatedAt(existingUser.getCreatedAt());
                    boolean success = userDAO.updateUser(user);
                    
                    if (success) {
                        if (isProtectedAccount) {
                            StringBuilder message = new StringBuilder("Cập nhật người dùng thành công.");
                            if (attemptedRoleChange) {
                                message.append(" Tài khoản Admin được bảo vệ không thể thay đổi vai trò.");
                            }
                            if (attemptedStatusChange) {
                                message.append(" Tài khoản Admin được bảo vệ không thể bị vô hiệu hóa.");
                            }
                            request.setAttribute("successMessage", message.toString());
                        } else {
                            request.setAttribute("successMessage", "Cập nhật người dùng thành công.");
                        }
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
