<!-- ========================================
     FILE: admin/dashboard.jsp
     ======================================== -->
<%@ page import="com.jobportal.dao.*, com.jobportal.model.*"%>
<%
    if (session == null || session.getAttribute("userId") == null || 
        !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    JobDAO jobDAO = new JobDAO();
    ApplicationDAO appDAO = new ApplicationDAO();
    int totalJobs = jobDAO.getTotalJobsCount();
    int totalApplications = appDAO.getTotalApplicationsCount();
%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div class="container-fluid">
		<nav class="navbar navbar-expand-lg navbar-dark bg-primary **admin-navbar**">
    <a class="navbar-brand" href="dashboard.jsp">Job Portal Admin</a>
    </nav>
			
			<div class="d-flex">
				<span class="navbar-text me-3 text-white">Welcome, <%= session.getAttribute("username") %></span>
				<a href="<%= request.getContextPath() %>/logout"
					class="btn btn-light btn-sm">Logout</a>
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
						<li class="nav-item"><a class="nav-link" href="add-job.jsp">Post
								New Job</a></li>
						<li class="nav-item"><a class="nav-link"
							href="manage-jobs.jsp">Manage Jobs</a></li>
						<li class="nav-item"><a class="nav-link"
							href="view-applications.jsp">View Applications</a></li>
					</ul>
				</div>
			</div>

			<div class="col-md-9">
				<h2 class="mb-4">Dashboard Overview</h2>
				<div class="row">
					<div class="col-md-6">
						<div class="stats-card">
							<h3><%= totalJobs %></h3>
							<p>Active Jobs</p>
						</div>
					</div>
					<div class="col-md-6">
						<div class="stats-card"
							style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
							<h3><%= totalApplications %></h3>
							<p>Total Applications</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

