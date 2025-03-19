//Author: DAT
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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "UserOrdersServlet", urlPatterns = {"/my-orders"})
public class UserOrdersServlet extends HttpServlet {
    
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
        
        // Kiểm tra thông báo từ servlet khác
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");
        
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }
        
        try {
            // Lấy danh sách đơn hàng của người dùng
            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders = orderDAO.getByUserId(user.getUserId());
            
            // Đưa danh sách đơn hàng vào request
            request.setAttribute("orders", orders);
            
            // Chuyển đến trang danh sách đơn hàng
            request.getRequestDispatcher("my-orders.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(UserOrdersServlet.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi lấy danh sách đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
