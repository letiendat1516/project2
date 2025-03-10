package dal;

import context.DBContext;
import model.User;
import utils.PasswordHash;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class UserDAO {

    private DBContext db;

    public UserDAO() {
        db = new DBContext();
    }

    public boolean isEmailExists(String email) throws Exception {
        try (Connection conn = db.getConnection(); CallableStatement stmt = conn.prepareCall("{CALL sp_CheckEmailExists(?)}")) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        }
    }

    public boolean isPhoneExists(String phone) throws Exception {
        try (Connection conn = db.getConnection(); CallableStatement stmt = conn.prepareCall("{CALL sp_CheckPhoneExists(?)}")) {
            stmt.setString(1, phone);
            ResultSet rs = stmt.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        }
    }

    public int register(User user) throws Exception {
        try (Connection conn = db.getConnection(); CallableStatement stmt = conn.prepareCall("{CALL sp_RegisterUser(?, ?, ?, ?)}")) {

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getPassword());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("userId");
            }
            return -1;
        }
    }

    public User login(String email, String password) throws Exception {
        String sql = "EXEC sp_LoginUser @email=?, @password=?";

        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, PasswordHash.hashPassword(password));

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setRoleId(rs.getInt("role_id"));
                    user.setIsActive(rs.getBoolean("is_active"));
                    // Không set password vì lý do bảo mật
                    return user;
                }
            }
            return null;
        }
    }

    // Thêm phương thức để lấy role name từ role_id
    public String getRoleName(int roleId) throws Exception {
        String sql = "SELECT role_name FROM Roles WHERE role_id = ?";

        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, roleId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? rs.getString("role_name") : null;
            }
        }
    }

    // Thêm phương thức cập nhật thông tin user
public boolean updateUser(User user) throws Exception {
    String sql;
    PreparedStatement stmt;
    
    try (Connection conn = db.getConnection()) {
        // Nếu có mật khẩu mới, cập nhật cả mật khẩu
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            sql = "UPDATE Users SET full_name=?, email=?, phone=?, address=?, role_id=?, is_active=?, password=? WHERE user_id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getAddress());
            stmt.setInt(5, user.getRoleId());
            stmt.setBoolean(6, user.isIsActive());
            stmt.setString(7, user.getPassword());
            stmt.setInt(8, user.getUserId());
        } else {
            // Nếu không có mật khẩu mới, chỉ cập nhật các trường khác
            sql = "UPDATE Users SET full_name=?, email=?, phone=?, address=?, role_id=?, is_active=? WHERE user_id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getAddress());
            stmt.setInt(5, user.getRoleId());
            stmt.setBoolean(6, user.isIsActive());
            stmt.setInt(7, user.getUserId());
        }
        
        return stmt.executeUpdate() > 0;
    }
}

    /**
     * Lấy tổng số người dùng trong hệ thống
     *
     * @return Tổng số người dùng
     */
    public int getTotalUsers() throws Exception {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Users";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println("Error in getTotalUsers: " + e.getMessage());
        }

        return count;
    }

    /**
     * Lấy danh sách tất cả người dùng
     *
     * @return Danh sách người dùng
     */
    public List<User> getAllUsers() throws Exception {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.*, r.role_name FROM Users u LEFT JOIN Roles r ON u.role_id = r.role_id";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                // Không lấy mật khẩu vì lý do bảo mật

                // Xử lý role_id có thể null
                int roleId = rs.getInt("role_id");
                if (!rs.wasNull()) {
                    user.setRoleId(roleId);
                }

                user.setCreatedAt(rs.getTimestamp("created_at"));

                users.add(user);
            }

        } catch (SQLException e) {
            System.out.println("Error in getAllUsers: " + e.getMessage());
        }

        return users;
    }

    public boolean deleteUser(int userId) throws Exception {
        deleteUserPasswordResets(userId); // Xóa bản ghi liên quan trước

        String sql = "DELETE FROM Users WHERE user_id = ?";

        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    public User getUserById(int userId) throws Exception {
        String sql = "SELECT u.*, r.role_name FROM Users u LEFT JOIN Roles r ON u.role_id = r.role_id WHERE u.user_id = ?";

        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));

                    // Xử lý role_id có thể null
                    int roleId = rs.getInt("role_id");
                    if (!rs.wasNull()) {
                        user.setRoleId(roleId);
                    }

                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    user.setIsActive(rs.getBoolean("is_active"));
                    // Không lấy mật khẩu vì lý do bảo mật

                    return user;
                }
            }
            return null;
        }
    }

    public void deleteUserPasswordResets(int userId) throws Exception {
        String sql = "DELETE FROM password_resets WHERE user_id = ?";

        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        }
    }

}
