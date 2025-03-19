//Author: DAT, KHANH, LINH
package controller;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;

public class Search extends HttpServlet {
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
    String s = request.getParameter("txt");
    String source = request.getParameter("source"); // Thêm tham số để biết nguồn
    
    if (s == null || s.trim().isEmpty()) {
        response.sendRedirect("products");
        return;
    }
    
    ProductDAO productDAO = new ProductDAO();
    List<Product> searchResults = productDAO.SearchProduct(s);
    
    if ("index".equals(source)) {
        // Nếu tìm kiếm từ trang chủ
        request.setAttribute("products", searchResults);
        request.setAttribute("searchQuery", s);
        request.getRequestDispatcher("product.jsp").forward(request, response);
    } else {
        // Nếu tìm kiếm từ trang product hoặc mặc định
        request.setAttribute("products", searchResults);
        request.setAttribute("searchQuery", s);
        request.getRequestDispatcher("product.jsp").forward(request, response);
    }
}


    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
