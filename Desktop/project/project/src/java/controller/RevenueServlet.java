package controller;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RevenueServlet", urlPatterns = {"/admin_revenue"})
public class RevenueServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            // Lấy khoảng thời gian cho thống kê (mặc định: 30 ngày gần nhất)
            String period = request.getParameter("period");
            if (period == null) {
                period = "month"; // Khoảng thời gian mặc định
            }

            OrderDAO orderDAO = new OrderDAO();
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            Calendar calendar = Calendar.getInstance();
            Date endDate = new Date();
            Date startDate = null;
            
            // Thiết lập ngày bắt đầu dựa trên khoảng thời gian được chọn
            switch (period) {
                case "week":
                    calendar.add(Calendar.DAY_OF_MONTH, -7);
                    startDate = calendar.getTime();
                    break;
                case "month":
                    calendar.add(Calendar.MONTH, -1);
                    startDate = calendar.getTime();
                    break;
                case "quarter":
                    calendar.add(Calendar.MONTH, -3);
                    startDate = calendar.getTime();
                    break;
                case "year":
                    calendar.add(Calendar.YEAR, -1);
                    startDate = calendar.getTime();
                    break;
                default:
                    calendar.add(Calendar.MONTH, -1);
                    startDate = calendar.getTime();
                    break;
            }

            // Lấy dữ liệu thống kê
            BigDecimal totalRevenue = orderDAO.getTotalRevenue();
            
            // Debug
            System.out.println("Tổng doanh thu: " + totalRevenue);
            
            try {
                List<Map<String, Object>> topProducts = orderDetailDAO.getTopSellingProductsByQuantity(10);
                request.setAttribute("topProducts", topProducts);
                System.out.println("Số lượng sản phẩm top: " + topProducts.size());
            } catch (Exception e) {
                System.out.println("Lỗi khi lấy top sản phẩm: " + e.getMessage());
                e.printStackTrace();
            }
            
            try {
                List<Map<String, Object>> revenueByCategory = orderDetailDAO.getRevenueByCategory();
                request.setAttribute("revenueByCategory", revenueByCategory);
                System.out.println("Số lượng danh mục: " + revenueByCategory.size());
            } catch (Exception e) {
                System.out.println("Lỗi khi lấy doanh thu theo danh mục: " + e.getMessage());
                e.printStackTrace();
            }
            
            try {
                List<Map<String, Object>> revenueByDate = orderDetailDAO.getRevenueByDateRange(startDate, endDate);
                request.setAttribute("revenueByDate", revenueByDate);
                System.out.println("Số lượng ngày có doanh thu: " + revenueByDate.size());
            } catch (Exception e) {
                System.out.println("Lỗi khi lấy doanh thu theo ngày: " + e.getMessage());
                e.printStackTrace();
            }
            
            try {
                Map<String, Integer> orderStatusStats = orderDAO.getOrderStatusStatistics();
                request.setAttribute("orderStatusStats", orderStatusStats);
                System.out.println("Trạng thái đơn hàng: " + orderStatusStats);
            } catch (Exception e) {
                System.out.println("Lỗi khi lấy thống kê trạng thái đơn hàng: " + e.getMessage());
                e.printStackTrace();
            }
            
            // Lấy năm hiện tại để thống kê theo tháng trong năm
            int currentYear = Calendar.getInstance().get(Calendar.YEAR);
            
            try {
                List<Map<String, Object>> monthlyRevenue = orderDAO.getMonthlyRevenue(currentYear);
                request.setAttribute("monthlyRevenue", monthlyRevenue);
                System.out.println("Số tháng có doanh thu: " + monthlyRevenue.size());
            } catch (Exception e) {
                System.out.println("Lỗi khi lấy doanh thu theo tháng: " + e.getMessage());
                e.printStackTrace();
            }
            
            // Thiết lập các thuộc tính để JSP render
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("currentYear", currentYear);
            
            // Thiết lập khoảng thời gian đã chọn
            request.setAttribute("selectedPeriod", period);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);

            // Chuyển hướng đến trang dashboard doanh thu JSP
            request.getRequestDispatcher("/admin_revenue.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("Lỗi chung: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin.jsp?error=true&message=" + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
