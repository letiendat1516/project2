package controller;

import dal.OrderDAO;
import model.Order;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "CancelOrderServlet", urlPatterns = {"/cancel-order"})
public class CancelOrderServlet extends HttpServlet {
    
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
            
            // Kiểm tra xem đơn hàng có tồn tại, thuộc về người dùng hiện tại và có thể hủy không
            if (order == null || order.getUserId() != user.getUserId() || !order.getStatus().equals("Pending")) {
                session.setAttribute("errorMessage", "Không thể hủy đơn hàng này!");
                response.sendRedirect("my-orders");
                return;
            }
            
            // Hủy đơn hàng
            boolean success = orderDAO.updateStatus(orderId, "Cancelled");
            
            if (success) {
                session.setAttribute("successMessage", "Đơn hàng #" + orderId + " đã được hủy thành công!");
            } else {
                session.setAttribute("errorMessage", "Có lỗi xảy ra khi hủy đơn hàng. Vui lòng thử lại sau.");
            }
            
            // Chuyển hướng về trang danh sách đơn hàng
            response.sendRedirect("my-orders");
        } catch (NumberFormatException e) {
            response.sendRedirect("my-orders");
        } catch (Exception e) {
            Logger.getLogger(CancelOrderServlet.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi hủy đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
