package dal;

import model.Order;
import context.DBContext; // Giả sử bạn có class DBContext để kết nối database

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    // Phương thức đóng kết nối
    private void closeResources() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

// Cập nhật phương thức insert để lưu thông tin giao hàng
    public int insert(Order order) throws SQLException, Exception {
        int orderId = 0;
        String sql = "INSERT INTO Orders (user_id, total_price, status, created_at, shipping_address, shipping_phone, shipping_name) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            Connection conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, order.getUserId());
            ps.setBigDecimal(2, order.getTotalPrice());
            ps.setString(3, order.getStatus());
            ps.setTimestamp(4, new Timestamp(order.getCreatedAt().getTime()));
            ps.setString(5, order.getShippingAddress());
            ps.setString(6, order.getShippingPhone());
            ps.setString(7, order.getShippingName());

            ps.executeUpdate();

            // Lấy order_id vừa được tạo
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }
        } finally {
            closeResources();
        }
        return orderId;
    }

    // Lấy đơn hàng theo ID
    public Order getById(int orderId) throws SQLException, Exception {
        Order order = null;
        String sql = "SELECT * FROM Orders WHERE order_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getBigDecimal("total_price"));
                order.setStatus(rs.getString("status"));
                order.setCreatedAt(rs.getTimestamp("created_at"));

                // Lấy thông tin giao hàng
                order.setShippingName(rs.getString("shipping_name"));
                order.setShippingPhone(rs.getString("shipping_phone"));
                order.setShippingAddress(rs.getString("shipping_address"));
            }
        }
        return order;
    }

    // Lấy tất cả đơn hàng của một user
    public List<Order> getByUserId(int userId) throws SQLException, Exception {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE user_id = ? ORDER BY created_at DESC";

        try {
            Connection conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getBigDecimal("total_price"));
                order.setStatus(rs.getString("status"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                orders.add(order);
            }
        } finally {
            closeResources();
        }
        return orders;
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateStatus(int orderId, String status) throws SQLException, Exception {
        String sql = "UPDATE Orders SET status = ? WHERE order_id = ?";
        int rowsAffected = 0;

        try {
            Connection conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            rowsAffected = ps.executeUpdate();
        } finally {
            closeResources();
        }
        return rowsAffected > 0;
    }

    // Cập nhật toàn bộ thông tin đơn hàng
    public boolean update(Order order) throws SQLException, Exception {
        String sql = "UPDATE Orders SET user_id = ?, total_price = ?, status = ?, "
                + "created_at = ? WHERE order_id = ?";
        int rowsAffected = 0;

        try {
            Connection conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);

            ps.setInt(1, order.getUserId());
            ps.setBigDecimal(2, order.getTotalPrice());
            ps.setString(3, order.getStatus());
            ps.setTimestamp(4, new Timestamp(order.getCreatedAt().getTime()));
            ps.setInt(5, order.getOrderId());

            rowsAffected = ps.executeUpdate();
        } finally {
            closeResources();
        }
        return rowsAffected > 0;
    }

    // Xóa đơn hàng
    public boolean delete(int orderId) throws SQLException, Exception {
        String sql = "DELETE FROM Orders WHERE order_id = ?";
        int rowsAffected = 0;

        try {
            Connection conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rowsAffected = ps.executeUpdate();
        } finally {
            closeResources();
        }
        return rowsAffected > 0;
    }

    // Lấy tất cả đơn hàng với phân trang
    public List<Order> getAllWithPagination(int page, int pageSize) throws SQLException, Exception {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY created_at DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            Connection conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getBigDecimal("total_price"));
                order.setStatus(rs.getString("status"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                orders.add(order);
            }
        } finally {
            closeResources();
        }
        return orders;
    }

    // Đếm tổng số đơn hàng
    public int countAll() throws SQLException, Exception {
        String sql = "SELECT COUNT(*) FROM Orders";
        int count = 0;

        try {
            Connection conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } finally {
            closeResources();
        }
        return count;
    }

    // Lấy tổng doanh thu
    public BigDecimal getTotalRevenue() throws SQLException, Exception {
        String sql = "SELECT SUM(total_price) FROM Orders WHERE status = 'Delivered'";
        BigDecimal totalRevenue = BigDecimal.ZERO;

        try {
            Connection conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                totalRevenue = rs.getBigDecimal(1);
                if (totalRevenue == null) {
                    totalRevenue = BigDecimal.ZERO;
                }
            }
        } finally {
            closeResources();
        }
        return totalRevenue;
    }

}
