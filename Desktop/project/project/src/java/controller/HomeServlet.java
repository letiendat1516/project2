//Author:DAT, HUY
package controller;

import dal.OrderDetailDAO;
import dal.ProductDAO;
import model.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO(); // Khởi tạo OrderDetailDAO

        // Lấy danh sách sản phẩm nổi bật
        List<Product> featuredProducts = productDAO.getFeaturedProducts();

        // Lấy số lượng bán cho sản phẩm nổi bật
        for (Product product : featuredProducts) {
            int soldCount = 0;
            try {
                soldCount = orderDetailDAO.getProductSalesCount(product.getProductId());
            } catch (Exception ex) {
                Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            product.setSoldCount(soldCount);
        }

        request.setAttribute("featuredProducts", featuredProducts);

        // Nếu không có sản phẩm nổi bật hoặc số lượng ít, bổ sung bằng sản phẩm mới nhất
        if (featuredProducts == null || featuredProducts.size() < 6) {
            // Lấy sản phẩm mới nhất để hiển thị (nếu cần)
            List<Product> newestProducts = productDAO.getNewestProducts(6 - (featuredProducts != null ? featuredProducts.size() : 0));

            // Lấy số lượng bán cho sản phẩm mới nhất
            for (Product product : newestProducts) {
                int soldCount = 0;
                try {
                    soldCount = orderDetailDAO.getProductSalesCount(product.getProductId());
                } catch (Exception ex) {
                    Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                product.setSoldCount(soldCount);
            }

            request.setAttribute("newestProducts", newestProducts);
        }

        // Chuyển hướng đến trang index.jsp
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
