
<!-- ========================================
     FILE: admin/add-job.jsp
     ======================================== -->
<%
    if (session == null || session.getAttribute("userId") == null || 
        !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Post New Job</title>
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
						<li class="nav-item"><a class="nav-link active"
							href="add-job.jsp">Post New Job</a></li>
						<li class="nav-item"><a class="nav-link"
							href="manage-jobs.jsp">Manage Jobs</a></li>
						<li class="nav-item"><a class="nav-link"
							href="view-applications.jsp">View Applications</a></li>
					</ul>
				</div>
			</div>

			<div class="col-md-9">
				<h2 class="mb-4">Post New Job</h2>

				<% if (request.getAttribute("errorMessage") != null) { %>
				<div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
				<% } %>

				<div class="card">
					<div class="card-body">
						<form action="<%= request.getContextPath() %>/job" method="post">
							<input type="hidden" name="action" value="add">

							<div class="mb-3">
								<label class="form-label">Job Title *</label> <input type="text"
									class="form-control" name="jobTitle" required>
							</div>

							<div class="mb-3">
								<label class="form-label">Company Name *</label> <input
									type="text" class="form-control" name="companyName" required>
							</div>

							<div class="row">
								<div class="col-md-6 mb-3">
									<label class="form-label">Location *</label> <input type="text"
										class="form-control" name="location" required>
								</div>
								<div class="col-md-6 mb-3">
									<label class="form-label">Salary Range</label> <input
										type="text" class="form-control" name="salaryRange"
										placeholder="e.g., $50,000 - $70,000">
								</div>
							</div>

							<div class="mb-3">
								<label class="form-label">Job Description *</label>
								<textarea class="form-control" name="jobDescription" rows="5"
									required></textarea>
							</div>

							<div class="mb-3">
								<label class="form-label">Requirements *</label>
								<textarea class="form-control" name="requirements" rows="4"
									required></textarea>
							</div>

							<button type="submit" class="btn btn-primary">Post Job</button>
							<a href="manage-jobs.jsp" class="btn btn-secondary">Cancel</a>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

