<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Job Portal - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/">Job Portal</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/login.jsp">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-primary text-white ms-2 px-4" href="<%= request.getContextPath() %>/register.jsp">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container text-center">
            <h1 class="display-4 fw-bold mb-4">Find Your Dream Job Today</h1>
            <p class="lead mb-5">Connect with top employers and explore thousands of job opportunities</p>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card p-4">
                        <form action="<%= request.getContextPath() %>/search" method="get">
                            <div class="row g-3">
                                <div class="col-md-5">
                                    <input type="text" class="form-control form-control-lg" name="keyword" placeholder="Job title or keyword">
                                </div>
                                <div class="col-md-4">
                                    <input type="text" class="form-control form-control-lg" name="location" placeholder="Location">
                                </div>
                                <div class="col-md-3">
                                    <button type="submit" class="btn btn-primary btn-lg w-100">Search</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Why Choose Us?</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card h-100 text-center p-4">
                        <div class="card-body">
                            <h3 class="mb-3">🔍</h3>
                            <h5 class="card-title">Easy Job Search</h5>
                            <p class="card-text">Search and filter jobs by title, location, and company with our intuitive interface.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card h-100 text-center p-4">
                        <div class="card-body">
                            <h3 class="mb-3">⚡</h3>
                            <h5 class="card-title">Quick Apply</h5>
                            <p class="card-text">Apply to multiple jobs with just a few clicks. Upload your resume once and apply everywhere.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card h-100 text-center p-4">
                        <div class="card-body">
                            <h3 class="mb-3">📊</h3>
                            <h5 class="card-title">Track Applications</h5>
                            <p class="card-text">Monitor the status of your job applications in real-time from your dashboard.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-5 bg-light">
        <div class="container text-center">
            <h2 class="mb-4">Ready to Get Started?</h2>
            <p class="lead mb-4">Join thousands of job seekers and employers today!</p>
            <a href="<%= request.getContextPath() %>/register.jsp" class="btn btn-primary btn-lg px-5">Create Free Account</a>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <p class="mb-0">&copy; Online Job Portal. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>