package controller;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import model.Order;
import model.OrderDetail;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/order-detail"})
public class OrderDetailServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Lấy ID đơn hàng từ request
        String orderIdParam = request.getParameter("id");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect("my-orders");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            OrderDAO orderDAO = new OrderDAO();
            Order order = orderDAO.getById(orderId);
            
            // Kiểm tra xem đơn hàng có tồn tại và thuộc về người dùng hiện tại không
            if (order == null || order.getUserId() != user.getUserId()) {
                response.sendRedirect("my-orders");
                return;
            }
            
            // Lấy chi tiết đơn hàng
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            List<OrderDetail> orderDetails = orderDetailDAO.getByOrderId(orderId);
            
            // Lấy thông tin sản phẩm cho mỗi chi tiết đơn hàng
            for (OrderDetail detail : orderDetails) {
                // Giả sử có một ProductDAO để lấy thông tin sản phẩm
                // ProductDAO productDAO = new ProductDAO();
                // Product product = productDAO.getById(detail.getProductId());
                // detail.setProductName(product.getName());
                // detail.setProductImage(product.getImageUrl());
                
                // Nếu bạn đã có thông tin này từ OrderDetailDAO, không cần đoạn code trên
            }
            
            // Đưa thông tin vào request
            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);
            request.setAttribute("user", user);
            
            // Chuyển đến trang chi tiết đơn hàng
            request.getRequestDispatcher("order-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("my-orders");
        } catch (Exception e) {
            Logger.getLogger(OrderDetailServlet.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi lấy chi tiết đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
