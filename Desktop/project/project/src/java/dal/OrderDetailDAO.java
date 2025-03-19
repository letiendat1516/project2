//Author: DAT

package dal;

import context.DBContext;
import java.math.BigDecimal;
import model.OrderDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Order;
import java.util.Date;

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
    /**
 * Lấy tổng doanh thu theo sản phẩm
 * @return Danh sách doanh thu của từng sản phẩm
 */
public List<Map<String, Object>> getRevenueByProduct() throws Exception {
    List<Map<String, Object>> result = new ArrayList<>();
    String sql = "SELECT p.product_id, p.name AS product_name, p.image_url, " +
                 "SUM(od.quantity) AS total_quantity, " +
                 "SUM(od.quantity * od.unit_price) AS total_revenue " +
                 "FROM OrderDetails od " +
                 "JOIN Products p ON od.product_id = p.product_id " +
                 "JOIN Orders o ON od.order_id = o.order_id " +
                 "WHERE o.status = N'Delivered' " +
                 "GROUP BY p.product_id, p.name, p.image_url " +
                 "ORDER BY total_revenue DESC";

    try {
        Connection conn = new DBContext().getConnection();
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("productId", rs.getInt("product_id"));
            item.put("productName", rs.getString("product_name"));
            item.put("imageUrl", rs.getString("image_url"));
            item.put("totalQuantity", rs.getInt("total_quantity"));
            item.put("totalRevenue", rs.getBigDecimal("total_revenue"));
            result.add(item);
        }
    } finally {
        closeResources();
    }
    return result;
}

/**
 * Lấy top N sản phẩm bán chạy nhất theo doanh thu
 * @param limit Số lượng sản phẩm cần lấy
 * @return Danh sách top sản phẩm bán chạy
 */
public List<Map<String, Object>> getTopSellingProducts(int limit) throws Exception {
    List<Map<String, Object>> result = new ArrayList<>();
    String sql = "SELECT TOP (?) p.product_id, p.name AS product_name, p.image_url, " +
                 "SUM(od.quantity) AS total_quantity, " +
                 "SUM(od.quantity * od.unit_price) AS total_revenue " +
                 "FROM OrderDetails od " +
                 "JOIN Products p ON od.product_id = p.product_id " +
                 "JOIN Orders o ON od.order_id = o.order_id " +
                 "WHERE o.status = N'Delivered' " +
                 "GROUP BY p.product_id, p.name, p.image_url " +
                 "ORDER BY total_revenue DESC";

    try {
        Connection conn = new DBContext().getConnection();
        ps = conn.prepareStatement(sql);
        ps.setInt(1, limit);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("productId", rs.getInt("product_id"));
            item.put("productName", rs.getString("product_name"));
            item.put("imageUrl", rs.getString("image_url"));
            item.put("totalQuantity", rs.getInt("total_quantity"));
            item.put("totalRevenue", rs.getBigDecimal("total_revenue"));
            result.add(item);
        }
    } finally {
        closeResources();
    }
    return result;
}

/**
 * Lấy doanh thu theo danh mục
 * @return Danh sách doanh thu theo từng danh mục
 */
public List<Map<String, Object>> getRevenueByCategory() throws Exception {
    List<Map<String, Object>> result = new ArrayList<>();
    String sql = "SELECT c.category_id, c.category_name, " +
                 "SUM(od.quantity) AS total_quantity, " +
                 "SUM(od.quantity * od.unit_price) AS total_revenue " +
                 "FROM OrderDetails od " +
                 "JOIN Products p ON od.product_id = p.product_id " +
                 "JOIN Categories c ON p.category_id = c.category_id " +
                 "JOIN Orders o ON od.order_id = o.order_id " +
                 "WHERE o.status = 'Delivered' " +
                 "GROUP BY c.category_id, c.category_name " +
                 "ORDER BY total_revenue DESC";

    try {
        Connection conn = new DBContext().getConnection();
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("categoryId", rs.getInt("category_id"));
            item.put("categoryName", rs.getString("category_name"));
            item.put("totalQuantity", rs.getInt("total_quantity"));
            item.put("totalRevenue", rs.getBigDecimal("total_revenue"));
            result.add(item);
        }
    } finally {
        closeResources();
    }
    return result;
}

/**
 * Lấy doanh thu theo khoảng thời gian
 * @param startDate Ngày bắt đầu
 * @param endDate Ngày kết thúc
 * @return Danh sách doanh thu trong khoảng thời gian
 */
public List<Map<String, Object>> getRevenueByDateRange(Date startDate, Date endDate) throws Exception {
    List<Map<String, Object>> result = new ArrayList<>();
    String sql = "SELECT CONVERT(DATE, o.created_at) AS order_date, " +
                 "SUM(od.quantity * od.unit_price) AS daily_revenue " +
                 "FROM OrderDetails od " +
                 "JOIN Orders o ON od.order_id = o.order_id " +
                 "WHERE o.status = N'Delivered' AND o.created_at BETWEEN ? AND ? " +
                 "GROUP BY CONVERT(DATE, o.created_at) " +
                 "ORDER BY order_date";

    try {
        Connection conn = new DBContext().getConnection();
        ps = conn.prepareStatement(sql);
        ps.setTimestamp(1, new Timestamp(startDate.getTime()));
        ps.setTimestamp(2, new Timestamp(endDate.getTime()));
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("date", rs.getDate("order_date"));
            item.put("revenue", rs.getBigDecimal("daily_revenue"));
            result.add(item);
        }
    } finally {
        closeResources();
    }
    return result;
}
/**
 * Lấy tổng doanh thu từ các đơn hàng đã giao
 * @return Doanh thu tổng
 */
public BigDecimal getTotalRevenue() throws SQLException, Exception {
    String sql = "SELECT SUM(od.quantity * od.unit_price) AS total_revenue " +
                 "FROM OrderDetails od " +
                 "JOIN Orders o ON od.order_id = o.order_id " +
                 "WHERE o.status = 'Delivered'";
    BigDecimal totalRevenue = BigDecimal.ZERO;

    try {
        Connection conn = new DBContext().getConnection();
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();

        if (rs.next()) {
            totalRevenue = rs.getBigDecimal("total_revenue");
            if (totalRevenue == null) {
                totalRevenue = BigDecimal.ZERO;
            }
        }
    } finally {
        closeResources();
    }
    return totalRevenue;
}

/**
 * Cập nhật số lượt bán cho tất cả sản phẩm dựa trên đơn hàng đã giao
 * @return true nếu cập nhật thành công
 */
public boolean updateProductSalesCount() throws Exception {
    String sql = "UPDATE Products SET sold_count = " +
                "(SELECT ISNULL(SUM(od.quantity), 0) " +
                "FROM OrderDetails od " +
                "JOIN Orders o ON od.order_id = o.order_id " +
                "WHERE od.product_id = Products.product_id AND o.status = 'Delivered')";
    
    try {
        Connection conn = new DBContext().getConnection();
        ps = conn.prepareStatement(sql);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } finally {
        closeResources();
    }
}

/**
 * Lấy số lượng bán ra của một sản phẩm cụ thể
 * @param productId ID của sản phẩm
 * @return Số lượng bán ra
 */
public int getProductSalesCount(int productId) throws Exception {
    String sql = "SELECT SUM(od.quantity) AS total_sold " +
                "FROM OrderDetails od " +
                "JOIN Orders o ON od.order_id = o.order_id " +
                "WHERE o.status = 'Delivered' AND od.product_id = ?";
    int totalSold = 0;

    try {
        Connection conn = new DBContext().getConnection();
        ps = conn.prepareStatement(sql);
        ps.setInt(1, productId);
        rs = ps.executeQuery();

        if (rs.next()) {
            totalSold = rs.getInt("total_sold");
            if (rs.wasNull()) {
                totalSold = 0;
            }
        }
    } finally {
        closeResources();
    }
    return totalSold;
}
/**
 * Lấy top N sản phẩm bán chạy nhất theo số lượng bán
 * @param limit Số lượng sản phẩm cần lấy
 * @return Danh sách top sản phẩm bán chạy
 */
public List<Map<String, Object>> getTopSellingProductsByQuantity(int limit) throws Exception {
    List<Map<String, Object>> result = new ArrayList<>();
    String sql = "SELECT TOP (?) p.product_id, p.name AS product_name, p.image_url, " +
                 "SUM(od.quantity) AS total_quantity, " +
                 "SUM(od.quantity * od.unit_price) AS total_revenue " +
                 "FROM OrderDetails od " +
                 "JOIN Products p ON od.product_id = p.product_id " +
                 "JOIN Orders o ON od.order_id = o.order_id " +
                 "WHERE o.status = N'Delivered' " +
                 "GROUP BY p.product_id, p.name, p.image_url " +
                 "ORDER BY total_quantity DESC"; // Thay đổi từ total_revenue thành total_quantity

    try {
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, limit);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("productId", rs.getInt("product_id"));
            item.put("productName", rs.getString("product_name"));
            item.put("imageUrl", rs.getString("image_url"));
            item.put("totalQuantity", rs.getInt("total_quantity"));
            item.put("totalRevenue", rs.getBigDecimal("total_revenue"));
            result.add(item);
        }
    } finally {
        // Đóng tài nguyên
    }
    return result;
}

public Map<Integer, Integer> getAllProductsSalesCount() throws Exception {
    Map<Integer, Integer> result = new HashMap<>();
    String sql = "SELECT p.product_id, ISNULL(SUM(od.quantity), 0) AS total_quantity " +
                 "FROM Products p " + 
                 "LEFT JOIN OrderDetails od ON p.product_id = od.product_id " +
                 "LEFT JOIN Orders o ON od.order_id = o.order_id AND o.status = 'Delivered' " +
                 "GROUP BY p.product_id";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            int productId = rs.getInt("product_id");
            int totalQuantity = rs.getInt("total_quantity");
            result.put(productId, totalQuantity);
        }
    }
    return result;
}


}
