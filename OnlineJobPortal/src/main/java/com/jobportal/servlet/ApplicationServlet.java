package com.jobportal.servlet;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.model.Application;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/application")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 20
)
public class ApplicationServlet extends HttpServlet {
    private ApplicationDAO applicationDAO;
    private static final String UPLOAD_DIR = "uploads/resumes";
    
    @Override
    public void init() {
        applicationDAO = new ApplicationDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        if ("apply".equals(action)) {
            applyForJob(request, response, session);
        } else if ("updateStatus".equals(action)) {
            updateApplicationStatus(request, response, session);
        }
    }
    
    private void applyForJob(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws ServletException, IOException {
        
        int jobId = Integer.parseInt(request.getParameter("jobId"));
        int userId = (Integer) session.getAttribute("userId");
        String coverLetter = request.getParameter("coverLetter");
        Part filePart = request.getPart("resume");
        
        if (applicationDAO.hasUserApplied(jobId, userId)) {
            response.sendRedirect(request.getContextPath() + "/user/job-details.jsp?id=" + jobId + "&error=You have already applied for this job");
            return;
        }
        
        String resumePath = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = getFileName(filePart);
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            String uniqueFileName = userId + "_" + System.currentTimeMillis() + "_" + fileName;
            String filePath = uploadPath + File.separator + uniqueFileName;
            
            filePart.write(filePath);
            resumePath = UPLOAD_DIR + "/" + uniqueFileName;
        }
        
        Application application = new Application();
        application.setJobId(jobId);
        application.setUserId(userId);
        application.setCoverLetter(coverLetter);
        application.setResumePath(resumePath);
        
        boolean applied = applicationDAO.submitApplication(application);
        
        if (applied) {
            response.sendRedirect(request.getContextPath() + "/user/my-applications.jsp?success=Application submitted successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/job-details.jsp?id=" + jobId + "&error=Failed to submit application");
        }
    }
    
    private void updateApplicationStatus(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws IOException {
        
        String role = (String) session.getAttribute("role");
        
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            return;
        }
        
        int applicationId = Integer.parseInt(request.getParameter("applicationId"));
        String status = request.getParameter("status");
        
        boolean updated = applicationDAO.updateApplicationStatus(applicationId, status);
        
        if (updated) {
            response.sendRedirect(request.getContextPath() + "/admin/view-applications.jsp?success=Status updated successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/view-applications.jsp?error=Failed to update status");
        }
    }
    
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        
        return "unknown";
    }
}