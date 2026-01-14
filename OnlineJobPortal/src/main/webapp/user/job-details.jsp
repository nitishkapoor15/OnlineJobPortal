<!-- ========================================
     FILE: user/job-details.jsp
     ======================================== -->
<%@ page import="com.jobportal.dao.*, com.jobportal.model.*"%>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    int jobId = Integer.parseInt(request.getParameter("id"));
    int userId = (Integer) session.getAttribute("userId");
    
    JobDAO jobDAO = new JobDAO();
    ApplicationDAO appDAO = new ApplicationDAO();
    Job job = jobDAO.getJobById(jobId);
    boolean hasApplied = appDAO.hasUserApplied(jobId, userId);
%>
<!DOCTYPE html>
<html>
<head>
<title><%= job.getJobTitle() %> - Job Details</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
		<div class="container-fluid">
			<a class="navbar-brand" href="dashboard.jsp">Job Portal</a>
			<div class="d-flex">
				<span class="navbar-text me-3">Welcome, <%= session.getAttribute("username") %></span>
				<a href="<%= request.getContextPath() %>/logout"
					class="btn btn-outline-primary btn-sm">Logout</a>
			</div>
		</div>
	</nav>

	<div class="container mt-4 mb-5">
		<a href="search-jobs.jsp" class="btn btn-secondary mb-3">← Back to
			Jobs</a>

		<% if (request.getParameter("error") != null) { %>
		<div class="alert alert-danger"><%= request.getParameter("error") %></div>
		<% } %>

		<div class="card">
			<div class="card-body p-5">
				<div class="row mb-4">
					<div class="col-md-8">
						<h2 class="mb-3"><%= job.getJobTitle() %></h2>
						<h5 class="text-primary"><%= job.getCompanyName() %></h5>
						<p class="text-muted">
							📍
							<%= job.getLocation() %></p>
						<% if (job.getSalaryRange() != null && !job.getSalaryRange().isEmpty()) { %>
						<p class="text-success">
							💰
							<%= job.getSalaryRange() %></p>
						<% } %>
						<p class="text-muted">
							Posted:
							<%= new java.text.SimpleDateFormat("MMMM dd, yyyy").format(job.getPostedDate()) %></p>
					</div>
					<div class="col-md-4 text-end">
						<% if (hasApplied) { %>
						<button class="btn btn-success btn-lg" disabled>✓ Applied</button>
						<% } else { %>
						<button class="btn btn-primary btn-lg" data-bs-toggle="modal"
							data-bs-target="#applyModal">Apply Now</button>
						<% } %>
					</div>
				</div>

				<hr>

				<h4 class="mt-4 mb-3">Job Description</h4>
				<p style="white-space: pre-wrap;"><%= job.getJobDescription() %></p>

				<h4 class="mt-4 mb-3">Requirements</h4>
				<p style="white-space: pre-wrap;"><%= job.getRequirements() %></p>
			</div>
		</div>
	</div>

	<!-- Apply Modal -->
	<div class="modal fade" id="applyModal" tabindex="-1">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						Apply for
						<%= job.getJobTitle() %></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<form action="<%= request.getContextPath() %>/application"
					method="post" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="action" value="apply"> <input
							type="hidden" name="jobId" value="<%= jobId %>">

						<div class="mb-3">
							<label class="form-label">Cover Letter</label>
							<textarea class="form-control" name="coverLetter" rows="5"
								placeholder="Tell us why you're a good fit for this role..."></textarea>
						</div>

						<div class="mb-3">
							<label class="form-label">Upload Resume (PDF, DOC, DOCX)</label>
							<input type="file" class="form-control" name="resume"
								accept=".pdf,.doc,.docx" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Cancel</button>
						<button type="submit" class="btn btn-primary">Submit
							Application</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

