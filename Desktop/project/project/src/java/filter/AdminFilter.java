//Author: DAT
package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;

@WebFilter(filterName = "AdminFilter", urlPatterns = {
    "/admin/*",
    "/admin.jsp",
    "/admin_categories",
    "/admin_products",
    "/admin_orders",
    "/admin_users",
    "/admin_revenue"
})
public class AdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Debug logging
        System.out.println("=== AdminFilter Debug ===");
        System.out.println("RequestURI: " + req.getRequestURI());
        
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("No session or user found");
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        System.out.println("User roleId: " + user.getRoleId());
        
        // Kiểm tra quyền admin bằng phương thức isAdmin()
        if (!user.isAdmin()&& !user.isStaff()) {
            System.out.println("Access denied - not an admin role");
            res.sendRedirect(req.getContextPath() + "/access-denied.jsp");
            return;
        }

        System.out.println("Access granted - proceeding to admin page");
        chain.doFilter(request, response);
    }
}
