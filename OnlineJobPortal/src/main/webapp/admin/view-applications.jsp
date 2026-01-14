<!-- ========================================
     FILE: admin/view-applications.jsp
     ======================================== -->
<%@ page
	import="java.util.*, com.jobportal.dao.*, com.jobportal.model.*"%>
<%
    if (session == null || session.getAttribute("userId") == null || 
        !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    ApplicationDAO appDAO = new ApplicationDAO();
    List<Application> applications = appDAO.getAllApplications();
%>
<!DOCTYPE html>
<html>
<head>
<title>View Applications</title>
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
						<li class="nav-item"><a class="nav-link"
							href="manage-jobs.jsp">Manage Jobs</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="view-applications.jsp">View Applications</a></li>
					</ul>
				</div>
			</div>

			<div class="col-md-9">
				<h2 class="mb-4">All Applications</h2>

				<% if (request.getParameter("success") != null) { %>
				<div class="alert alert-success"><%= request.getParameter("success") %></div>
				<% } %>

				<div class="card">
					<div class="card-body">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>Applicant</th>
									<th>Job Title</th>
									<th>Company</th>
									<th>Applied Date</th>
									<th>Status</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
								<% for (Application app : applications) { %>
								<tr>
									<td><%= app.getApplicantName() %><br>
									<small class="text-muted"><%= app.getApplicantEmail() %></small></td>
									<td><%= app.getJobTitle() %></td>
									<td><%= app.getCompanyName() %></td>
									<td><%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(app.getAppliedDate()) %></td>
									<td><span class="badge bg-warning"><%= app.getStatus() %></span></td>
									<td>
										<% if (app.getResumePath() != null) { %> <a
										href="<%= request.getContextPath() %>/<%= app.getResumePath() %>"
										class="btn btn-sm btn-primary" target="_blank">View Resume</a>
										<% } %>
										<form action="<%= request.getContextPath() %>/application"
											method="post" style="display: inline;">
											<input type="hidden" name="action" value="updateStatus">
											<input type="hidden" name="applicationId"
												value="<%= app.getApplicationId() %>"> <select
												name="status"
												class="form-select form-select-sm d-inline-block w-auto"
												onchange="this.form.submit()">
												<option value="pending"
													<%= "pending".equals(app.getStatus()) ? "selected" : "" %>>Pending</option>
												<option value="reviewed"
													<%= "reviewed".equals(app.getStatus()) ? "selected" : "" %>>Reviewed</option>
												<option value="accepted"
													<%= "accepted".equals(app.getStatus()) ? "selected" : "" %>>Accepted</option>
												<option value="rejected"
													<%= "rejected".equals(app.getStatus()) ? "selected" : "" %>>Rejected</option>
											</select>
										</form>
									</td>
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