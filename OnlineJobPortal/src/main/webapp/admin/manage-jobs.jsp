<!-- ========================================
     FILE: admin/manage-jobs.jsp
     ======================================== -->
<%@ page
	import="java.util.*, com.jobportal.dao.*, com.jobportal.model.*"%>
<%
    if (session == null || session.getAttribute("userId") == null || 
        !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    JobDAO jobDAO = new JobDAO();
    List<Job> jobs = jobDAO.getAllActiveJobs();
%>
<!DOCTYPE html>
<html>
<head>
<title>Manage Jobs</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div class="container-fluid">
			<a class="navbar-brand" href="dashboard.jsp">Job Portal Admin</a>
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
						<li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
						<li class="nav-item"><a class="nav-link" href="add-job.jsp">Post
								New Job</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="manage-jobs.jsp">Manage Jobs</a></li>
						<li class="nav-item"><a class="nav-link"
							href="view-applications.jsp">View Applications</a></li>
					</ul>
				</div>
			</div>

			<div class="col-md-9">
				<h2 class="mb-4">Manage Jobs</h2>

				<% if (request.getParameter("success") != null) { %>
				<div class="alert alert-success"><%= request.getParameter("success") %></div>
				<% } %>

				<% if (request.getParameter("error") != null) { %>
				<div class="alert alert-danger"><%= request.getParameter("error") %></div>
				<% } %>

				<div class="card">
					<div class="card-body">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>Job Title</th>
									<th>Company</th>
									<th>Location</th>
									<th>Posted Date</th>
									<th>Status</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
								<% for (Job job : jobs) { %>
								<tr>
									<td><%= job.getJobTitle() %></td>
									<td><%= job.getCompanyName() %></td>
									<td><%= job.getLocation() %></td>
									<td><%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(job.getPostedDate()) %></td>
									<td><span class="badge bg-success"><%= job.getStatus() %></span></td>
									<td><a
										href="<%= request.getContextPath() %>/user/job-details.jsp?id=<%= job.getJobId() %>"
										class="btn btn-sm btn-info">View</a>
										<form action="<%= request.getContextPath() %>/job"
											method="post" style="display: inline;">
											<input type="hidden" name="action" value="delete"> <input
												type="hidden" name="jobId" value="<%= job.getJobId() %>">
											<button type="submit" class="btn btn-sm btn-danger"
												onclick="return confirm('Are you sure?')">Delete</button>
										</form></td>
								</tr>
								<% } %>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

