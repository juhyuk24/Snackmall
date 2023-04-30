<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="css/styles.css" rel="stylesheet" />
</head>
<body>
	<!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="index.jsp">Snack Mall</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                    	<li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                        <li class="nav-item"><a class="nav-link" href="allproducts.jsp">All products</a></li>
                    </ul>
                    <form class="d-flex">
                    	<button onClick="location.href='adminRefund.jsp'" class="btn btn-outline-dark" type="button">
                           	주문/환불관리
                        </button>
                    	<button onClick="location.href='manageProduct.jsp'" class="btn btn-outline-dark" type="button">
                           	상품관리
                        </button>
                    	<button onClick="location.href='logoutPro.jsp'" class="btn btn-outline-dark" type="button">
                            로그아웃
                        </button>
                    </form>
                </div>
            </div>
        </nav>
</body>
</html>