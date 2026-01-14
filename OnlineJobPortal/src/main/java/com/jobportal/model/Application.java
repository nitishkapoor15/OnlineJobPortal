package com.jobportal.model;

import java.sql.Timestamp;

public class Application {
    private int applicationId;
    private int jobId;
    private int userId;
    private String coverLetter;
    private String resumePath;
    private String status;
    private Timestamp appliedDate;
    
    // Additional fields for JOIN queries
    private String jobTitle;
    private String companyName;
    private String applicantName;
    private String applicantEmail;
    
    public Application() {}
    
    public Application(int applicationId, int jobId, int userId, String coverLetter, 
                      String resumePath, String status) {
        this.applicationId = applicationId;
        this.jobId = jobId;
        this.userId = userId;
        this.coverLetter = coverLetter;
        this.resumePath = resumePath;
        this.status = status;
    }
    
    // Getters and Setters
    public int getApplicationId() {
        return applicationId;
    }
    
    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }
    
    public int getJobId() {
        return jobId;
    }
    
    public void setJobId(int jobId) {
        this.jobId = jobId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getCoverLetter() {
        return coverLetter;
    }
    
    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }
    
    public String getResumePath() {
        return resumePath;
    }
    
    public void setResumePath(String resumePath) {
        this.resumePath = resumePath;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getAppliedDate() {
        return appliedDate;
    }
    
    public void setAppliedDate(Timestamp appliedDate) {
        this.appliedDate = appliedDate;
    }
    
    public String getJobTitle() {
        return jobTitle;
    }
    
    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }
    
    public String getCompanyName() {
        return companyName;
    }
    
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
    
    public String getApplicantName() {
        return applicantName;
    }
    
    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }
    
    public String getApplicantEmail() {
        return applicantEmail;
    }
    
    public void setApplicantEmail(String applicantEmail) {
        this.applicantEmail = applicantEmail;
    }
}