package controller;

import dal.CategoryDAO;
import model.Category;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CategoryServlet", urlPatterns = {"/admin_categories"})
public class CategoryServlet extends HttpServlet {

    private static final String ACTION_LIST = "list";
    private static final String ACTION_ADD = "add";
    private static final String ACTION_EDIT = "edit";
    private static final String ACTION_UPDATE = "update";
    private static final String ACTION_DELETE = "delete";

    private static final int MAX_CATEGORY_NAME_LENGTH = 100;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = ACTION_LIST;
        }

        CategoryDAO categoryDAO = new CategoryDAO();
        HttpSession session = request.getSession();

        try {
            switch (action) {
                case ACTION_LIST:
                    listCategories(request, response, categoryDAO);
                    break;
                case ACTION_ADD:
                    addCategory(request, response, categoryDAO, session);
                    break;
                case ACTION_UPDATE:
                    updateCategory(request, response, categoryDAO, session);
                    break;
                case ACTION_DELETE:
                    deleteCategory(request, response, categoryDAO, session);
                    break;
                default:
                    listCategories(request, response, categoryDAO);
            }
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin_categories");
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response, CategoryDAO categoryDAO)
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategoriesWithProductCount();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin_categories.jsp").forward(request, response);
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response, CategoryDAO categoryDAO, HttpSession session)
            throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");

        // Validate category name
        if (categoryName == null || categoryName.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Tên danh mục không được để trống");
            response.sendRedirect(request.getContextPath() + "/admin_categories");
            return;
        }

        categoryName = categoryName.trim();

        if (categoryName.length() > MAX_CATEGORY_NAME_LENGTH) {
            session.setAttribute("errorMessage", "Tên danh mục không được vượt quá " + MAX_CATEGORY_NAME_LENGTH + " ký tự");
            response.sendRedirect(request.getContextPath() + "/admin_categories");
            return;
        }

        // Check if category name exists
        if (categoryDAO.isCategoryNameExists(categoryName)) {
            session.setAttribute("errorMessage", "Tên danh mục đã tồn tại");
            response.sendRedirect(request.getContextPath() + "/admin_categories");
            return;
        }

        // Add category
        int categoryId = categoryDAO.addCategory(categoryName);
        if (categoryId > 0) {
            session.setAttribute("successMessage", "Thêm danh mục thành công");
        } else {
            session.setAttribute("errorMessage", "Thêm danh mục thất bại");
        }

        response.sendRedirect(request.getContextPath() + "/admin_categories");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response, CategoryDAO categoryDAO, HttpSession session)
            throws ServletException, IOException {
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String categoryName = request.getParameter("categoryName");

            // Validate category name
            if (categoryName == null || categoryName.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Tên danh mục không được để trống");
                response.sendRedirect(request.getContextPath() + "/admin_categories");
                return;
            }

            categoryName = categoryName.trim();

            if (categoryName.length() > MAX_CATEGORY_NAME_LENGTH) {
                session.setAttribute("errorMessage", "Tên danh mục không được vượt quá " + MAX_CATEGORY_NAME_LENGTH + " ký tự");
                response.sendRedirect(request.getContextPath() + "/admin_categories");
                return;
            }

            // Check if category exists
            Category existingCategory = categoryDAO.getCategoryById(categoryId);
            if (existingCategory == null) {
                session.setAttribute("errorMessage", "Danh mục không tồn tại");
                response.sendRedirect(request.getContextPath() + "/admin_categories");
                return;
            }

            // Check if new name exists in other categories
            if (categoryDAO.isCategoryNameExistsExcept(categoryName, categoryId)) {
                session.setAttribute("errorMessage", "Tên danh mục đã tồn tại");
                response.sendRedirect(request.getContextPath() + "/admin_categories");
                return;
            }

            // Update category
            boolean success = categoryDAO.updateCategory(categoryId, categoryName);
            if (success) {
                session.setAttribute("successMessage", "Cập nhật danh mục thành công");
            } else {
                session.setAttribute("errorMessage", "Cập nhật danh mục thất bại");
            }

            response.sendRedirect(request.getContextPath() + "/admin_categories");

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "ID danh mục không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin_categories");
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response, CategoryDAO categoryDAO, HttpSession session)
            throws ServletException, IOException {
        try {
            // Lấy category ID từ request
            int categoryId = Integer.parseInt(request.getParameter("id"));

            // Thực hiện xóa category
            boolean result = categoryDAO.deleteCategory(categoryId);

            if (result) {
                // Xóa thành công
                session.setAttribute("successMessage", "Xóa danh mục thành công");
            } else {
                // Xóa thất bại - có thể do danh mục không tồn tại hoặc đang được sử dụng
                session.setAttribute("errorMessage", "Không thể xóa danh mục. Danh mục không tồn tại hoặc đang được sử dụng bởi sản phẩm");
            }

        } catch (NumberFormatException e) {
            // Lỗi khi parse categoryId
            session.setAttribute("errorMessage", "ID danh mục không hợp lệ");
        } catch (Exception e) {
            // Các lỗi khác
            session.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình xóa danh mục");
            e.printStackTrace();
        } finally {
            // Redirect về trang danh sách category
            response.sendRedirect(request.getContextPath() + "/admin_categories");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Category Management Servlet";
    }
}
