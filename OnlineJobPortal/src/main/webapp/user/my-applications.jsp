
<!-- ========================================
     FILE: user/my-applications.jsp
     ======================================== -->
<%@ page
	import="com.jobportal.dao.*, com.jobportal.model.*, java.util.*"%>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    int userId = (Integer) session.getAttribute("userId");
    ApplicationDAO appDAO = new ApplicationDAO();
    List<Application> applications = appDAO.getApplicationsByUser(userId);
%>
<!DOCTYPE html>
<html>
<head>
<title>My Applications</title>
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
						<li class="nav-item"><a class="nav-link"
							href="search-jobs.jsp">Search Jobs</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="my-applications.jsp">My Applications</a></li>
					</ul>
				</div>
			</div>

			<div class="col-md-9">
				<h2 class="mb-4">My Applications</h2>

				<% if (request.getParameter("success") != null) { %>
				<div class="alert alert-success"><%= request.getParameter("success") %></div>
				<% } %>

				<% if (applications.isEmpty()) { %>
				<div class="alert alert-info">
					You haven't applied to any jobs yet. <a href="search-jobs.jsp">Browse
						available jobs</a>
				</div>
				<% } else { %>
				<% for (Application app : applications) { %>
				<div class="card mb-3">
					<div class="card-body">
						<div class="row">
							<div class="col-md-8">
								<h5 class="card-title"><%= app.getJobTitle() %></h5>
								<p class="text-muted mb-1"><%= app.getCompanyName() %></p>
								<p class="text-muted mb-2">
									Applied:
									<%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(app.getAppliedDate()) %></p>
								<% 
                                    String statusClass = "";
                                    if ("pending".equals(app.getStatus())) statusClass = "bg-warning";
                                    else if ("reviewed".equals(app.getStatus())) statusClass = "bg-info";
                                    else if ("accepted".equals(app.getStatus())) statusClass = "bg-success";
                                    else if ("rejected".equals(app.getStatus())) statusClass = "bg-danger";
                                    %>
								<span class="badge <%= statusClass %>"><%= app.getStatus().toUpperCase() %></span>
							</div>
							<div class="col-md-4 text-end">
								<a href="job-details.jsp?id=<%= app.getJobId() %>"
									class="btn btn-outline-primary">View Job</a>
								<% if (app.getResumePath() != null) { %>
								<a
									href="<%= request.getContextPath() %>/<%= app.getResumePath() %>"
									class="btn btn-outline-secondary mt-2" target="_blank">View
									Resume</a>
								<% } %>
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