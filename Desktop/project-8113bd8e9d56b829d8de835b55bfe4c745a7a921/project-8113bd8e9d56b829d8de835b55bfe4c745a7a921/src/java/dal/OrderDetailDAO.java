package dal;

import context.DBContext;
import model.OrderDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO {
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
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
    public List<OrderDetail> getByOrderId(int orderId) throws SQLException, Exception {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT * FROM OrderDetails WHERE order_id = ?";
        
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
                
                details.add(detail);
            }
        } finally {
            closeResources();
        }
        return details;
    }
}
