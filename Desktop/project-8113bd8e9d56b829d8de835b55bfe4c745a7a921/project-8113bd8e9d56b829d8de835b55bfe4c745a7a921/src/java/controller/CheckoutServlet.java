package controller;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import model.CartItem;
import model.Order;
import model.OrderDetail;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.IOException;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Kiểm tra đăng nhập
        if (user == null) {
            session.setAttribute("redirectURL", "checkout");
            response.sendRedirect("login.jsp");
            return;
        }

        // Chuyển tới trang checkout.jsp để người dùng xác nhận thông tin
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Lấy dữ liệu giỏ hàng từ form
            String cartData = request.getParameter("cartData");
            if (cartData == null || cartData.isEmpty()) {
                request.setAttribute("errorMessage", "Giỏ hàng trống. Vui lòng thêm sản phẩm vào giỏ hàng.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }

            // Chuyển đổi JSON thành đối tượng Java
            Gson gson = new Gson();
            Type cartListType = new TypeToken<List<CartItem>>(){}.getType();
            List<CartItem> cart = gson.fromJson(cartData, cartListType);
            
            if (cart == null || cart.isEmpty()) {
                request.setAttribute("errorMessage", "Giỏ hàng trống. Vui lòng thêm sản phẩm vào giỏ hàng.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }

            // Tạo đơn hàng mới
            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setTotalPrice(calculateTotal(cart));
            order.setStatus("Pending");
            order.setCreatedAt(new Date());

            // Lấy thông tin giao hàng từ form
            String address = request.getParameter("address");
            if (address != null && !address.trim().isEmpty()) {
                // Lưu thông tin giao hàng nếu cần
                // Có thể cập nhật địa chỉ người dùng nếu cần
            }

            // Lưu đơn hàng và lấy order ID
            OrderDAO orderDAO = new OrderDAO();
            int orderId = orderDAO.insert(order);

            if (orderId > 0) {
                // Tạo chi tiết đơn hàng cho từng sản phẩm trong giỏ hàng
                OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
                ProductDAO productDAO = new ProductDAO();

                for (CartItem item : cart) {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrderId(orderId);
                    detail.setProductId(item.getProductId());
                    detail.setQuantity(item.getQuantity());
                    detail.setUnitPrice(item.getPrice());

                    // Lưu chi tiết đơn hàng
                    orderDetailDAO.insert(detail);

                    // Cập nhật số lượng tồn kho
                    productDAO.updateStock(item.getProductId(), item.getQuantity());
                }

                // Thông báo thành công và xóa giỏ hàng
                session.setAttribute("orderSuccess", true);
                session.setAttribute("orderId", orderId);
                session.setAttribute("clearCart", true); // Để xóa cart trong localStorage

                // Chuyển hướng đến trang xác nhận đơn hàng
                response.sendRedirect("order-confirmation.jsp?id=" + orderId);
            } else {
                // Xử lý lỗi khi không tạo được đơn hàng
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi tạo đơn hàng. Vui lòng thử lại sau.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }

    // Tính tổng tiền đơn hàng
    private BigDecimal calculateTotal(List<CartItem> cart) {
        BigDecimal total = BigDecimal.ZERO;
        
        for (CartItem item : cart) {
            total = total.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
        }
        
        return total;
    }
}
