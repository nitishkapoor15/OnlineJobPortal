package com.jobportal.model;

import java.sql.Timestamp;

public class Job {
    private int jobId;
    private String jobTitle;
    private String companyName;
    private String location;
    private String jobDescription;
    private String requirements;
    private String salaryRange;
    private int postedBy;
    private String status;
    private Timestamp postedDate;
    
    public Job() {}
    
    public Job(int jobId, String jobTitle, String companyName, String location, 
               String jobDescription, String requirements, String salaryRange, String status) {
        this.jobId = jobId;
        this.jobTitle = jobTitle;
        this.companyName = companyName;
        this.location = location;
        this.jobDescription = jobDescription;
        this.requirements = requirements;
        this.salaryRange = salaryRange;
        this.status = status;
    }
    
    // Getters and Setters
    public int getJobId() {
        return jobId;
    }
    
    public void setJobId(int jobId) {
        this.jobId = jobId;
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
    
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    public String getJobDescription() {
        return jobDescription;
    }
    
    public void setJobDescription(String jobDescription) {
        this.jobDescription = jobDescription;
    }
    
    public String getRequirements() {
        return requirements;
    }
    
    public void setRequirements(String requirements) {
        this.requirements = requirements;
    }
    
    public String getSalaryRange() {
        return salaryRange;
    }
    
    public void setSalaryRange(String salaryRange) {
        this.salaryRange = salaryRange;
    }
    
    public int getPostedBy() {
        return postedBy;
    }
    
    public void setPostedBy(int postedBy) {
        this.postedBy = postedBy;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getPostedDate() {
        return postedDate;
    }
    
    public void setPostedDate(Timestamp postedDate) {
        this.postedDate = postedDate;
    }
}