package controller;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.UserDAO;
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
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin_orders"})
public class AdminOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if (action == null) {
                action = "list"; // Mặc định hiển thị danh sách đơn hàng
            }

            switch (action) {
                case "list":
                    listOrders(request, response);
                    break;
                case "view":
                    viewOrderDetails(request, response);
                    break;
                case "delete":
                    deleteOrder(request, response);
                    break;
                default:
                    listOrders(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/admin_orders.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "update":
                    updateOrder(request, response);
                    break;
                case "update-status":
                    updateOrderStatus(request, response);
                    break;
                default:
                    listOrders(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/admin_orders.jsp").forward(request, response);
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, Exception, ServletException, IOException {

        OrderDAO orderDAO = new OrderDAO();
        UserDAO userDAO = new UserDAO();

        // Xử lý phân trang
        int page = 1;
        int recordsPerPage = 10;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Lấy danh sách đơn hàng với phân trang
        List<Order> orders = orderDAO.getAllWithPagination(page, recordsPerPage);

        // Tạo map lưu thông tin user cho mỗi đơn hàng
        Map<Integer, String> userNames = new HashMap<>();
        Map<Integer, String> userEmails = new HashMap<>();

        // Lấy thêm thông tin người dùng cho mỗi đơn
        for (Order order : orders) {
            User orderUser = userDAO.getUserById(order.getUserId());
            if (orderUser != null) {
                userNames.put(order.getOrderId(), orderUser.getFullName());
                userEmails.put(order.getOrderId(), orderUser.getEmail());
            }
        }

        int noOfRecords = orderDAO.countAll();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

        request.setAttribute("orders", orders);
        request.setAttribute("userNames", userNames);
        request.setAttribute("userEmails", userEmails);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);

        request.getRequestDispatcher("/admin_orders.jsp").forward(request, response);
    }

    private void viewOrderDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, Exception, ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("id"));

        OrderDAO orderDAO = new OrderDAO();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        UserDAO userDAO = new UserDAO();

        Order order = orderDAO.getById(orderId);
        List<OrderDetail> orderDetails = orderDetailDAO.getByOrderId(orderId);

        // Lấy thông tin user liên quan đến đơn hàng
        if (order != null) {
            User orderUser = userDAO.getUserById(order.getUserId());
            if (orderUser != null) {
                // Truyền thông tin user riêng biệt vào request attribute
                request.setAttribute("orderUserName", orderUser.getFullName());
                request.setAttribute("orderUserEmail", orderUser.getEmail());
                request.setAttribute("orderUserPhone", orderUser.getPhone());
            }
        }

        request.setAttribute("order", order);
        request.setAttribute("orderDetails", orderDetails);

        request.getRequestDispatcher("/admin-order-detail.jsp").forward(request, response);
    }

    private void updateOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, Exception, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        String shippingName = request.getParameter("shippingName");
        String shippingPhone = request.getParameter("shippingPhone");
        String shippingAddress = request.getParameter("shippingAddress");

        OrderDAO orderDAO = new OrderDAO();
        Order order = orderDAO.getById(orderId);

        if (order != null) {
            order.setStatus(status);
            order.setShippingName(shippingName);
            order.setShippingPhone(shippingPhone);
            order.setShippingAddress(shippingAddress);

            orderDAO.update(order);

            // Chuyển hướng về trang chi tiết
            response.sendRedirect(request.getContextPath() + "/admin_orders?action=view&id=" + orderId);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin_orders");
        }
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, Exception, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        OrderDAO orderDAO = new OrderDAO();
        orderDAO.updateStatus(orderId, status);

        // Chuyển hướng về trang trước đó
        String referer = request.getHeader("Referer");
        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin_orders");
        }
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, Exception, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));

        OrderDAO orderDAO = new OrderDAO();
        orderDAO.delete(orderId);

        // Chuyển hướng về danh sách đơn hàng
        response.sendRedirect(request.getContextPath() + "/admin_orders");
    }
}
