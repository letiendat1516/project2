package dal;

import context.DBContext;
import model.OrderDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Order;

public class OrderDetailDAO {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

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

    // Thêm chi tiết đơn hàng
    public boolean insert(OrderDetail detail) throws SQLException, Exception {
        String sql = "INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price) "
                + "VALUES (?, ?, ?, ?)";

        try {
            Connection conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);

            ps.setInt(1, detail.getOrderId());
            ps.setInt(2, detail.getProductId());
            ps.setInt(3, detail.getQuantity());
            ps.setBigDecimal(4, detail.getUnitPrice());

            return ps.executeUpdate() > 0;
        } finally {
            closeResources();
        }
    }

    // Lấy chi tiết đơn hàng theo order_id
// Lấy chi tiết đơn hàng theo order_id
    public List<OrderDetail> getByOrderId(int orderId) throws SQLException, Exception {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT od.*, p.name as product_name, p.image_url as product_image "
                + "FROM OrderDetails od "
                + "JOIN Products p ON od.product_id = p.product_id "
                + "WHERE od.order_id = ?";

        try {
            Connection conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderDetailId(rs.getInt("order_detail_id"));
                detail.setOrderId(rs.getInt("order_id"));
                detail.setProductId(rs.getInt("product_id"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setUnitPrice(rs.getBigDecimal("unit_price"));

                // Thêm thông tin sản phẩm
                detail.setProductName(rs.getString("product_name"));
                detail.setProductImage(rs.getString("product_image"));

                details.add(detail);
            }
        } finally {
            closeResources();
        }
        return details;
    }

    // Lấy chi tiết đơn hàng từ cơ sở dữ liệu
    public Order getOrderDetails(int orderId) throws SQLException, Exception {
        String sql = "SELECT * FROM Orders WHERE order_id = ?";
        Order order = null;

        try {
            Connection conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);  // BẢNG ĐỎ: Lỗi ở đây
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

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
        } finally {
            closeResources();
        }

        return order;
    }

}
