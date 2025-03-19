//Author: DAT

package controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/uploads/products/*")
public class FileServlet extends HttpServlet {
    
    private static final String UPLOAD_DIR = "D:/KingdomsToys/uploads/products";
    
    @Override
    public void init() throws ServletException {
        super.init();
        // Đảm bảo thư mục tồn tại
        File directory = new File(UPLOAD_DIR);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy tên file từ URL
        String requestedFile = request.getPathInfo();
        
        if (requestedFile == null || requestedFile.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Loại bỏ dấu "/" đầu tiên
        if (requestedFile.startsWith("/")) {
            requestedFile = requestedFile.substring(1);
        }
        
        // Kiểm tra path traversal
        if (requestedFile.contains("..") || requestedFile.contains("\\")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        // Tạo đường dẫn đầy đủ đến file
        Path filePath = Paths.get(UPLOAD_DIR, requestedFile);
        File file = filePath.toFile();
        
        // Kiểm tra file tồn tại
        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Xác định content type dựa trên phần mở rộng của file
        String contentType = getServletContext().getMimeType(file.getName());
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        
        // Thiết lập header
        response.setContentType(contentType);
        response.setContentLengthLong(file.length());
        
        // Thêm header cache để tăng hiệu suất
        response.setHeader("Cache-Control", "public, max-age=86400"); // Cache 1 ngày
        response.setHeader("Expires", getHttpExpiresDateString(86400000)); // 1 ngày
        
        try {
            // Gửi file
            Files.copy(filePath, response.getOutputStream());
        } catch (IOException e) {
            getServletContext().log("Error serving file: " + filePath, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    // Phương thức hỗ trợ tạo chuỗi ngày hết hạn cho HTTP header
    private String getHttpExpiresDateString(long futureMillis) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss z", Locale.US);
        dateFormat.setTimeZone(TimeZone.getTimeZone("GMT"));
        return dateFormat.format(new Date(System.currentTimeMillis() + futureMillis));
    }
}
