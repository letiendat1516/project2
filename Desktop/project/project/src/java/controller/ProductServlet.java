//Author: DAT, KHANH, LINH
package controller;

import dal.OrderDetailDAO;
import dal.ProductDAO;
import model.Product;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO(); // Khởi tạo OrderDetailDAO

        // Cập nhật số lượng bán cho tất cả sản phẩm
        try {
            productDAO.updateSoldCounts(); // Cập nhật số lượng bán
        } catch (Exception e) {
            System.err.println("Error updating sold counts: " + e.getMessage());
            e.printStackTrace();
        }

        // Lấy tham số phân trang (nếu có)
        String pageStr = request.getParameter("page");
        int page = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                // Giữ page = 1 nếu có lỗi
            }
        }

        // Lấy tham số lọc theo danh mục (nếu có)
        String categoryIdStr = request.getParameter("category");
        Integer categoryId = null;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
                // Bỏ qua nếu có lỗi
            }
        }

        // Lấy tham số sắp xếp (nếu có)
        String sortBy = request.getParameter("sort");

        // Số sản phẩm trên mỗi trang
        final int PRODUCTS_PER_PAGE = 12;

        // Lấy tổng số sản phẩm (để tính số trang)
        int totalProducts;

        // Lấy danh sách sản phẩm theo điều kiện lọc
        List<Product> products;

        if (categoryId != null) {
            // Lọc theo danh mục VÀ sắp xếp
            products = productDAO.getProductsByCategoryAndSort(categoryId, sortBy);
            totalProducts = productDAO.getTotalProductsByCategory(categoryId);
            
            // Phân trang thủ công nếu cần
            int startIndex = (page - 1) * PRODUCTS_PER_PAGE;
            int endIndex = Math.min(startIndex + PRODUCTS_PER_PAGE, products.size());
            
            if (startIndex < products.size()) {
                products = products.subList(startIndex, endIndex);
            } else {
                products = List.of(); // Trả về danh sách rỗng nếu trang không hợp lệ
            }
        } else {
            // Lấy tất cả sản phẩm
            products = productDAO.getAllProductsWithPagination(page, PRODUCTS_PER_PAGE, sortBy);
            totalProducts = productDAO.getTotalProducts();
        }

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);

        // Lấy danh sách sản phẩm nổi bật để hiển thị ở đầu trang
        List<Product> featuredProducts = productDAO.getFeaturedProducts();

        // Lấy số lượng bán cho tất cả sản phẩm
        // Lưu số lượng bán vào mỗi sản phẩm
        for (Product product : products) {
            int soldCount = 0;
            try {
                soldCount = orderDetailDAO.getProductSalesCount(product.getProductId());
            } catch (Exception ex) {
                Logger.getLogger(ProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            product.setSoldCount(soldCount);
        }

        // Cũng làm tương tự cho featuredProducts
        for (Product product : featuredProducts) {
            int soldCount = 0;
            try {
                soldCount = orderDetailDAO.getProductSalesCount(product.getProductId());
            } catch (Exception ex) {
                Logger.getLogger(ProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            product.setSoldCount(soldCount);
        }

        // Lấy danh sách tất cả các danh mục từ database
        Map<Integer, String> categories = productDAO.getAllCategories();
        
        // Đếm số lượng sản phẩm theo từng danh mục
        Map<Integer, Integer> categoryCounts = productDAO.countProductsByCategory();

        // Đặt các thuộc tính vào request
        request.setAttribute("products", products);
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("categories", categories);
        request.setAttribute("categoryCounts", categoryCounts);
        request.setAttribute("sortBy", sortBy);

        // Chuyển hướng đến trang product.jsp
        request.getRequestDispatcher("product.jsp").forward(request, response);
    }

    // Phương thức để cập nhật số lượng bán cho tất cả sản phẩm
    private void updateSoldCountsForAllProducts(ProductDAO productDAO) throws Exception {
        productDAO.updateSoldCounts(); // Gọi phương thức cập nhật số lượng bán
    }
}
