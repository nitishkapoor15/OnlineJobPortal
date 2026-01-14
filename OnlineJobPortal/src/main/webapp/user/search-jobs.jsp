<!-- ========================================
     FILE: user/search-jobs.jsp
     ======================================== -->
<%@ page
	import="com.jobportal.dao.*, com.jobportal.model.*, java.util.*"%>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    JobDAO jobDAO = new JobDAO();
    List<Job> jobs = (List<Job>) request.getAttribute("jobs");
    String keyword = request.getParameter("keyword");
    String location = request.getParameter("location");
    
    if (jobs == null) {
        jobs = jobDAO.getAllActiveJobs();
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Search Jobs</title>
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

	<div class="container-fluid mt-4">
		<div class="row">
			<div class="col-md-3">
				<div class="sidebar">
					<ul class="nav flex-column">
						<li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="search-jobs.jsp">Search Jobs</a></li>
						<li class="nav-item"><a class="nav-link"
							href="my-applications.jsp">My Applications</a></li>
					</ul>
				</div>
			</div>

			<div class="col-md-9">
				<h2 class="mb-4">Search Jobs</h2>

				<div class="search-box">
					<form action="<%= request.getContextPath() %>/search" method="get">
						<div class="row g-3">
							<div class="col-md-5">
								<input type="text" class="form-control" name="keyword"
									placeholder="Job title or keyword"
									value="<%= keyword != null ? keyword : "" %>">
							</div>
							<div class="col-md-4">
								<input type="text" class="form-control" name="location"
									placeholder="Location"
									value="<%= location != null ? location : "" %>">
							</div>
							<div class="col-md-3">
								<button type="submit" class="btn btn-primary w-100">Search</button>
							</div>
						</div>
					</form>
				</div>

				<h5 class="mb-3"><%= jobs.size() %>
					Jobs Found
				</h5>

				<% if (jobs.isEmpty()) { %>
				<div class="alert alert-info">No jobs found matching your
					criteria.</div>
				<% } else { %>
				<% for (Job job : jobs) { %>
				<div class="card job-card">
					<div class="card-body">
						<div class="row">
							<div class="col-md-9">
								<h5 class="card-title"><%= job.getJobTitle() %></h5>
								<p class="company-name mb-1"><%= job.getCompanyName() %></p>
								<p class="location mb-2">
									📍
									<%= job.getLocation() %></p>
								<% if (job.getSalaryRange() != null && !job.getSalaryRange().isEmpty()) { %>
								<p class="text-success mb-2">
									💰
									<%= job.getSalaryRange() %></p>
								<% } %>
								<p class="text-muted"><%= job.getJobDescription().substring(0, Math.min(150, job.getJobDescription().length())) %>...
								</p>
							</div>
							<div class="col-md-3 text-end">
								<a href="job-details.jsp?id=<%= job.getJobId() %>"
									class="btn btn-primary">View Details</a>
								<p class="text-muted mt-2">
									<small>Posted: <%= new java.text.SimpleDateFormat("MMM dd").format(job.getPostedDate()) %></small>
								</p>
							</div>
						</div>
					</div>
				</div>
				<% } %>
				<% } %>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

