package com.jobportal.servlet;

import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/job")
public class JobServlet extends HttpServlet {
    private JobDAO jobDAO;
    
    @Override
    public void init() {
        jobDAO = new JobDAO();
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
        
        String role = (String) session.getAttribute("role");
        
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            return;
        }
        
        if ("add".equals(action)) {
            addJob(request, response, session);
        } else if ("update".equals(action)) {
            updateJob(request, response);
        } else if ("delete".equals(action)) {
            deleteJob(request, response);
        }
    }
    
    private void addJob(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws ServletException, IOException {
        
        String jobTitle = request.getParameter("jobTitle");
        String companyName = request.getParameter("companyName");
        String location = request.getParameter("location");
        String jobDescription = request.getParameter("jobDescription");
        String requirements = request.getParameter("requirements");
        String salaryRange = request.getParameter("salaryRange");
        
        if (jobTitle == null || companyName == null || location == null || 
            jobDescription == null || requirements == null ||
            jobTitle.trim().isEmpty() || companyName.trim().isEmpty() || 
            location.trim().isEmpty() || jobDescription.trim().isEmpty() || 
            requirements.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All required fields must be filled");
            request.getRequestDispatcher("/admin/add-job.jsp").forward(request, response);
            return;
        }
        
        Job job = new Job();
        job.setJobTitle(jobTitle.trim());
        job.setCompanyName(companyName.trim());
        job.setLocation(location.trim());
        job.setJobDescription(jobDescription.trim());
        job.setRequirements(requirements.trim());
        job.setSalaryRange(salaryRange != null ? salaryRange.trim() : null);
        job.setPostedBy((Integer) session.getAttribute("userId"));
        
        boolean added = jobDAO.addJob(job);
        
        if (added) {
            response.sendRedirect(request.getContextPath() + "/admin/manage-jobs.jsp?success=Job posted successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to post job");
            request.getRequestDispatcher("/admin/add-job.jsp").forward(request, response);
        }
    }
    
    private void updateJob(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int jobId = Integer.parseInt(request.getParameter("jobId"));
        String jobTitle = request.getParameter("jobTitle");
        String companyName = request.getParameter("companyName");
        String location = request.getParameter("location");
        String jobDescription = request.getParameter("jobDescription");
        String requirements = request.getParameter("requirements");
        String salaryRange = request.getParameter("salaryRange");
        String status = request.getParameter("status");
        
        Job job = new Job();
        job.setJobId(jobId);
        job.setJobTitle(jobTitle.trim());
        job.setCompanyName(companyName.trim());
        job.setLocation(location.trim());
        job.setJobDescription(jobDescription.trim());
        job.setRequirements(requirements.trim());
        job.setSalaryRange(salaryRange != null ? salaryRange.trim() : null);
        job.setStatus(status);
        
        boolean updated = jobDAO.updateJob(job);
        
        if (updated) {
            response.sendRedirect(request.getContextPath() + "/admin/manage-jobs.jsp?success=Job updated successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/manage-jobs.jsp?error=Failed to update job");
        }
    }
    
    private void deleteJob(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        int jobId = Integer.parseInt(request.getParameter("jobId"));
        boolean deleted = jobDAO.deleteJob(jobId);
        
        if (deleted) {
            response.sendRedirect(request.getContextPath() + "/admin/manage-jobs.jsp?success=Job deleted successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/manage-jobs.jsp?error=Failed to delete job");
        }
    }
}