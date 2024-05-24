<%@page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <script src="https://unpkg.com/html5-qrcode"></script>
    <script>
        function showNotification(message, type) {
            console.log('okkkkk')
            let color = null;
            if (type == 'error') {
                color = "#c0392b"
            } else {
                color = '#2ecc71'
            }
            Toastify({
                text: message,
                duration: 3000,
                close: true,
                gravity: "top",
                position: "right",
                stopOnFocus: true,
                style: {
                    background: color, // Màu đỏ đậm hơn
                    color: "#fff", // Màu trắng cho độ tương phản
                    padding: "15px 20px",
                    borderRadius: "5px",
                    boxShadow: "0px 2px 5px rgba(0, 0, 0, 0.15)",
                    fontFamily: "sans-serif",
                    fontSize: "16px"
                },
                onClick: function () {
                }
            }).showToast();
        }
    </script>
</head>
<body>
<c:if test="${not empty successMessage}">
    <script type="text/javascript">
        showNotification("${successMessage}", "success");
    </script>
</c:if>
<c:if test="${not empty errorMessage}">
    <script type="text/javascript">
        showNotification("${errorMessage}", "error");
    </script>
</c:if>
<div class="container-fluid vh-100 vw-100 d-flex align-items-center justify-content-center">
    <form action="/login" method="post">
        <div class="bg-danger d-flex justify-content-evenly flex-column shadow-lg p-3 mb-5 bg-body rounded-4"
             style="width: 450px; height: 380px;">
            <h1 class="mx-auto">Sign in</h1>
            <div class="mb-3 row mx-1">
                <label class="col-sm-3 col-form-label">Tài khoản:</label>
                <div class="col-sm">
                    <!-- Email -->
                    <input type="text" class="form-control" name="username" value="${request.username}">
                    <!-- Email -->
                </div>
            </div>
            <div class="mb-3 row mx-1">
                <label for="inputPassword" class="col-sm-3 col-form-label">Password:</label>
                <div class="col-sm">
                    <!-- Password -->
                    <input type="password" class="form-control" name="password" autocomplete="on" value="${request.password}">
                    <!-- Password -->
                </div>
            </div>
            <c:if test="${not empty error}">
                <small style="color: red">${error}</small>
            </c:if>
            <div class="d-flex">
                <button class="btn btn-primary text-uppercase mx-auto btn-md px-4" type="submit">Đăng
                    nhập</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>