//Author: DAT, KHANH, LINH
package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import model.Category;
import model.Product;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin_products"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class AdminProductServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            showProductManagement(request, response);
        } else {
            switch (action) {
                case "get":
                    getProduct(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                case "toggleFeatured":
                    toggleFeaturedProduct(request, response);
                    break;
                case "showAll":
                    showAllProducts(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        switch (action) {
            case "add":
                addProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void showProductManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("search");
        String categoryIdStr = request.getParameter("category");
        String pageStr = request.getParameter("page");

        int page = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                // Giữ mặc định page = 1
            }
        }

        Integer categoryId = null;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
                // Bỏ qua nếu không hợp lệ
            }
        }

        final int PRODUCTS_PER_PAGE = 10;

        // Sử dụng tham số showAll = false để phân trang
        List<Product> products = productDAO.getProductsForAdminWithPagination(
                page, PRODUCTS_PER_PAGE, searchTerm, categoryId, false
        );

        int totalProducts = productDAO.countProductsWithFilter(searchTerm, categoryId);
        int totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);

        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("selectedCategory", categoryId);

        request.getRequestDispatcher("/admin_products.jsp")
                .forward(request, response);
    }

    private void showAllProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("search");
        String categoryIdStr = request.getParameter("category");

        Integer categoryId = null;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
                // Bỏ qua nếu không hợp lệ
            }
        }

        // Sử dụng tham số showAll = true để hiển thị tất cả sản phẩm
        List<Product> products = productDAO.getProductsForAdminWithPagination(
                1, Integer.MAX_VALUE, searchTerm, categoryId, true
        );

        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", 1);
        request.setAttribute("totalPages", 1);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("selectedCategory", categoryId);
        request.setAttribute("showingAll", true);

        request.getRequestDispatcher("/admin_products.jsp")
                .forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            boolean isFeatured = request.getParameter("isFeatured") != null;

            // Xử lý upload file
            Part filePart = request.getPart("imageFile");
            String imageUrl = "";

            if (filePart != null && filePart.getSize() > 0) {
                imageUrl = handleFileUpload(filePart, request);
            }

            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setStockQuantity(stockQuantity);
            product.setCategoryId(categoryId);
            product.setImageUrl(imageUrl);
            product.setIsFeatured(isFeatured);

            int productId = productDAO.addProduct(product);

            if (productId > 0) {
                request.getSession().setAttribute("successMessage", "Thêm sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Thêm sản phẩm thất bại!");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin_products");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            boolean isFeatured = request.getParameter("isFeatured") != null;

            Product product = productDAO.getProductById(productId);

            if (product != null) {
                product.setName(name);
                product.setDescription(description);
                product.setPrice(price);
                product.setStockQuantity(stockQuantity);
                product.setCategoryId(categoryId);
                product.setIsFeatured(isFeatured);

                Part filePart = request.getPart("imageFile");
                if (filePart != null && filePart.getSize() > 0) {
                    // Nếu có ảnh cũ, xóa ảnh cũ trước khi thêm ảnh mới
                    if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) {
                        deleteProductImage(product.getImageUrl(), request);
                    }

                    String imageUrl = handleFileUpload(filePart, request);
                    product.setImageUrl(imageUrl);
                }

                if (productDAO.updateProduct(product)) {
                    request.getSession().setAttribute("successMessage", "Cập nhật sản phẩm thành công!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Cập nhật sản phẩm thất bại!");
                }
            } else {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy sản phẩm!");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin_products");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));

            // Lấy thông tin sản phẩm để xóa file ảnh (nếu có)
            Product product = productDAO.getProductById(productId);
            if (product != null && product.getImageUrl() != null && !product.getImageUrl().isEmpty()) {
                deleteProductImage(product.getImageUrl(), request);
            }

            if (productDAO.deleteProduct(productId)) {
                request.getSession().setAttribute("successMessage", "Xóa sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("errorMessage", "Xóa sản phẩm thất bại!");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin_products");
    }

    private void toggleFeaturedProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(productId);

            if (product != null) {
                boolean newStatus = !product.getIsFeatured();
                if (productDAO.updateFeaturedStatus(productId, newStatus)) {
                    String message = newStatus ? "Đã đánh dấu sản phẩm là nổi bật!" : "Đã bỏ đánh dấu sản phẩm nổi bật!";
                    request.getSession().setAttribute("successMessage", message);
                } else {
                    request.getSession().setAttribute("errorMessage", "Cập nhật trạng thái thất bại!");
                }
            } else {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy sản phẩm!");
            }

        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin_products");
    }

    private void getProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(productId);

            if (product != null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(gson.toJson(product));
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    // Các phương thức xử lý file
    private String handleFileUpload(Part filePart, HttpServletRequest request) throws IOException {
        String fileName = getSubmittedFileName(filePart);

        if (fileName == null || fileName.isEmpty()) {
            return "";
        }

        // Tạo tên file ngẫu nhiên để tránh trùng lặp
        String extension = fileName.substring(fileName.lastIndexOf("."));
        String newFileName = UUID.randomUUID().toString() + extension;

        // Đường dẫn lưu file - sử dụng đường dẫn tương đối trong ứng dụng web
        String uploadPath = getUploadPath(request);

        // Đảm bảo thư mục tồn tại
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Lưu file
        Path path = Paths.get(uploadPath, newFileName);
        Files.copy(filePart.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

        // Trả về đường dẫn tương đối để lưu trong database
        return "uploads/products/" + newFileName;
    }

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    private String getUploadPath(HttpServletRequest request) {
        // Sử dụng đường dẫn cố định giống như trong FileServlet
        String uploadDir = "D:/KingdomsToys/uploads/products";

        // Đảm bảo thư mục tồn tại
        File directory = new File(uploadDir);
        if (!directory.exists()) {
            directory.mkdirs();
        }

        return uploadDir;
    }

    private void deleteProductImage(String imageUrl, HttpServletRequest request) {
        if (imageUrl != null && !imageUrl.isEmpty()) {
            try {
                // Lấy tên file từ đường dẫn
                String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

                // Tạo đường dẫn đầy đủ đến file
                Path filePath = Paths.get("D:/KingdomsToys/uploads/products", fileName);

                // Xóa file
                Files.deleteIfExists(filePath);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
