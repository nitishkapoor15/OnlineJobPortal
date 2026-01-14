<!-- ========================================
     FILE: user/dashboard.jsp
     ======================================== -->
<%@ page
	import="com.jobportal.dao.*, com.jobportal.model.*, java.util.*"%>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    JobDAO jobDAO = new JobDAO();
    ApplicationDAO appDAO = new ApplicationDAO();
    List<Job> recentJobs = jobDAO.getAllActiveJobs();
    if (recentJobs.size() > 5) {
        recentJobs = recentJobs.subList(0, 5);
    }
    int userId = (Integer) session.getAttribute("userId");
    List<Application> myApplications = appDAO.getApplicationsByUser(userId);
%>
<!DOCTYPE html>
<html>
<head>
<title>Job Seeker Dashboard</title>
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
						<li class="nav-item"><a class="nav-link active"
							href="dashboard.jsp">Dashboard</a></li>
						<li class="nav-item"><a class="nav-link"
							href="search-jobs.jsp">Search Jobs</a></li>
						<li class="nav-item"><a class="nav-link"
							href="my-applications.jsp">My Applications</a></li>
					</ul>
				</div>
			</div>

			<div class="col-md-9">
				<h2 class="mb-4">Dashboard</h2>

				<div class="row mb-4">
					<div class="col-md-4">
						<div class="stats-card">
							<h3><%= myApplications.size() %></h3>
							<p>Total Applications</p>
						</div>
					</div>
					<div class="col-md-4">
						<div class="stats-card"
							style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
							<h3><%= jobDAO.getTotalJobsCount() %></h3>
							<p>Available Jobs</p>
						</div>
					</div>
				</div>

				<h4 class="mb-3">Recent Job Postings</h4>
				<div class="row">
					<% for (Job job : recentJobs) { %>
					<div class="col-md-6 mb-3">
						<div class="card job-card">
							<div class="card-body">
								<h5 class="card-title"><%= job.getJobTitle() %></h5>
								<p class="company-name mb-1"><%= job.getCompanyName() %></p>
								<p class="location mb-3">
									📍
									<%= job.getLocation() %></p>
								<a href="job-details.jsp?id=<%= job.getJobId() %>"
									class="btn btn-primary btn-sm">View Details</a>
							</div>
						</div>
					</div>
					<% } %>
				</div>

				<div class="text-center mt-3">
					<a href="search-jobs.jsp" class="btn btn-outline-primary">View
						All Jobs</a>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
