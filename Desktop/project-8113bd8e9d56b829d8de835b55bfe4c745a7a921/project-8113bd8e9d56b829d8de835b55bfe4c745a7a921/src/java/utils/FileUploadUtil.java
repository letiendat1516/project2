package utils;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

public class FileUploadUtil {
    
    /**
     * Lấy tên file từ Part
     * @param part Part chứa file
     * @return Tên file hoặc null nếu không có file
     */
    public static String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
    
    /**
     * Lưu file và trả về đường dẫn tương đối
     * @param part Part chứa file
     * @param context ServletContext để lấy đường dẫn thực
     * @return Đường dẫn tương đối của file đã lưu
     * @throws IOException nếu có lỗi khi lưu file
     */
    public static String saveFile(Part part, ServletContext context) throws IOException {
        String fileName = getSubmittedFileName(part);
        
        if (fileName == null || fileName.isEmpty()) {
            return "";
        }
        
        // Tạo tên file ngẫu nhiên để tránh trùng lặp
        String extension = fileName.substring(fileName.lastIndexOf("."));
        String newFileName = UUID.randomUUID().toString() + extension;
        
        // Đường dẫn lưu file
        String uploadPath = context.getRealPath("/uploads/products");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // Lưu file
        Path path = Paths.get(uploadPath, newFileName);
        Files.copy(part.getInputStream(), path);
        
        // Trả về đường dẫn tương đối
        return "uploads/products/" + newFileName;
    }
    
    /**
     * Xóa file từ đường dẫn
     * @param imageUrl Đường dẫn tương đối của file
     * @param context ServletContext để lấy đường dẫn thực
     * @return true nếu xóa thành công, false nếu có lỗi
     */
    public static boolean deleteFile(String imageUrl, ServletContext context) {
        if (imageUrl != null && !imageUrl.isEmpty()) {
            try {
                String fullPath = context.getRealPath("/" + imageUrl);
                return Files.deleteIfExists(Paths.get(fullPath));
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }
        return false;
    }
    
    /**
     * Kiểm tra file có phải là ảnh không
     * @param fileName Tên file
     * @return true nếu là file ảnh, false nếu không phải
     */
    public static boolean isImageFile(String fileName) {
        String extension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        return extension.equals("jpg") || extension.equals("jpeg") 
            || extension.equals("png") || extension.equals("gif");
    }
    
    /**
     * Tạo tên file ngẫu nhiên với extension giữ nguyên
     * @param originalFileName Tên file gốc
     * @return Tên file mới
     */
    public static String generateUniqueFileName(String originalFileName) {
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        return UUID.randomUUID().toString() + extension;
    }
    
    /**
     * Lấy kích thước file tối đa cho phép (10MB)
     * @return Kích thước tối đa theo byte
     */
    public static long getMaxFileSize() {
        return 10 * 1024 * 1024; // 10MB
    }
    
    /**
     * Kiểm tra kích thước file có vượt quá giới hạn không
     * @param fileSize Kích thước file cần kiểm tra
     * @return true nếu file vượt quá giới hạn, false nếu không
     */
    public static boolean isFileSizeExceeded(long fileSize) {
        return fileSize > getMaxFileSize();
    }
}
