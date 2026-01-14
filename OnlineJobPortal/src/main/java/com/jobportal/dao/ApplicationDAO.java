package com.jobportal.dao;

import com.jobportal.model.Application;
import com.jobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {
    
    public boolean submitApplication(Application application) {
        String sql = "INSERT INTO applications (job_id, user_id, cover_letter, resume_path) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, application.getJobId());
            pstmt.setInt(2, application.getUserId());
            pstmt.setString(3, application.getCoverLetter());
            pstmt.setString(4, application.getResumePath());
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Application> getApplicationsByUser(int userId) {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.*, j.job_title, j.company_name FROM applications a " +
                    "JOIN jobs j ON a.job_id = j.job_id WHERE a.user_id = ? " +
                    "ORDER BY a.applied_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Application app = extractApplicationFromResultSet(rs);
                app.setJobTitle(rs.getString("job_title"));
                app.setCompanyName(rs.getString("company_name"));
                applications.add(app);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return applications;
    }
    
    public List<Application> getAllApplications() {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.*, j.job_title, j.company_name, u.full_name, u.email " +
                    "FROM applications a " +
                    "JOIN jobs j ON a.job_id = j.job_id " +
                    "JOIN users u ON a.user_id = u.user_id " +
                    "ORDER BY a.applied_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Application app = extractApplicationFromResultSet(rs);
                app.setJobTitle(rs.getString("job_title"));
                app.setCompanyName(rs.getString("company_name"));
                app.setApplicantName(rs.getString("full_name"));
                app.setApplicantEmail(rs.getString("email"));
                applications.add(app);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return applications;
    }
    
    public List<Application> getApplicationsByJob(int jobId) {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.*, u.full_name, u.email FROM applications a " +
                    "JOIN users u ON a.user_id = u.user_id WHERE a.job_id = ? " +
                    "ORDER BY a.applied_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, jobId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Application app = extractApplicationFromResultSet(rs);
                app.setApplicantName(rs.getString("full_name"));
                app.setApplicantEmail(rs.getString("email"));
                applications.add(app);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return applications;
    }
    
    public boolean hasUserApplied(int jobId, int userId) {
        String sql = "SELECT COUNT(*) FROM applications WHERE job_id = ? AND user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, jobId);
            pstmt.setInt(2, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public boolean updateApplicationStatus(int applicationId, String status) {
        String sql = "UPDATE applications SET status = ? WHERE application_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, applicationId);
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int getTotalApplicationsCount() {
        String sql = "SELECT COUNT(*) FROM applications";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    private Application extractApplicationFromResultSet(ResultSet rs) throws SQLException {
        Application app = new Application();
        app.setApplicationId(rs.getInt("application_id"));
        app.setJobId(rs.getInt("job_id"));
        app.setUserId(rs.getInt("user_id"));
        app.setCoverLetter(rs.getString("cover_letter"));
        app.setResumePath(rs.getString("resume_path"));
        app.setStatus(rs.getString("status"));
        app.setAppliedDate(rs.getTimestamp("applied_date"));
        return app;
    }
}