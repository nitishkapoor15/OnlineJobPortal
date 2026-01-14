package com.jobportal.dao;

import com.jobportal.model.Job;
import com.jobportal.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {
    
    public boolean addJob(Job job) {
        String sql = "INSERT INTO jobs (job_title, company_name, location, job_description, requirements, salary_range, posted_by) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, job.getJobTitle());
            pstmt.setString(2, job.getCompanyName());
            pstmt.setString(3, job.getLocation());
            pstmt.setString(4, job.getJobDescription());
            pstmt.setString(5, job.getRequirements());
            pstmt.setString(6, job.getSalaryRange());
            pstmt.setInt(7, job.getPostedBy());
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Job> getAllActiveJobs() {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT * FROM jobs WHERE status = 'active' ORDER BY posted_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                jobs.add(extractJobFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return jobs;
    }
    
    public Job getJobById(int jobId) {
        String sql = "SELECT * FROM jobs WHERE job_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, jobId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractJobFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public List<Job> searchJobs(String keyword, String location) {
        List<Job> jobs = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM jobs WHERE status = 'active'");
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (job_title LIKE ? OR company_name LIKE ?)");
        }
        
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND location LIKE ?");
        }
        
        sql.append(" ORDER BY posted_date DESC");
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword + "%";
                pstmt.setString(paramIndex++, searchPattern);
                pstmt.setString(paramIndex++, searchPattern);
            }
            
            if (location != null && !location.trim().isEmpty()) {
                pstmt.setString(paramIndex, "%" + location + "%");
            }
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                jobs.add(extractJobFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return jobs;
    }
    
    public boolean updateJob(Job job) {
        String sql = "UPDATE jobs SET job_title = ?, company_name = ?, location = ?, job_description = ?, requirements = ?, salary_range = ?, status = ? WHERE job_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, job.getJobTitle());
            pstmt.setString(2, job.getCompanyName());
            pstmt.setString(3, job.getLocation());
            pstmt.setString(4, job.getJobDescription());
            pstmt.setString(5, job.getRequirements());
            pstmt.setString(6, job.getSalaryRange());
            pstmt.setString(7, job.getStatus());
            pstmt.setInt(8, job.getJobId());
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteJob(int jobId) {
        String sql = "DELETE FROM jobs WHERE job_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, jobId);
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int getTotalJobsCount() {
        String sql = "SELECT COUNT(*) FROM jobs WHERE status = 'active'";
        
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
    
    private Job extractJobFromResultSet(ResultSet rs) throws SQLException {
        Job job = new Job();
        job.setJobId(rs.getInt("job_id"));
        job.setJobTitle(rs.getString("job_title"));
        job.setCompanyName(rs.getString("company_name"));
        job.setLocation(rs.getString("location"));
        job.setJobDescription(rs.getString("job_description"));
        job.setRequirements(rs.getString("requirements"));
        job.setSalaryRange(rs.getString("salary_range"));
        job.setPostedBy(rs.getInt("posted_by"));
        job.setStatus(rs.getString("status"));
        job.setPostedDate(rs.getTimestamp("posted_date"));
        return job;
    }
}