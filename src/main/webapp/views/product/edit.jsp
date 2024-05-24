<%@page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>

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
                onClick: function () { }
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
<div class="container-fluid d-flex" style="height: calc(100vh - 16px);">
    <jsp:include page="../navbar.jsp"/>
    <div style="width: calc(100vw - 274px); margin-left: 242px">
        <jsp:include page="../sub-nav.jsp"/>
        <div class="mt-3 container">
            <div class="row border p-3 d-flex">
                <div class="col-6">
                    <a href="/product/list?page=1" class="btn btn-success text-white fw-bold">
                        Quay lại
                    </a>
                </div>
            </div>
            <div class="border p-3 mt-3">
                <div class="row" style="margin-bottom: 40px;">
                    <div class="col-3">
                        <h5>Sửa Sản Phẩm ${product.id}</h5>
                    </div>
                </div>
                <div class="d-flex justify-content-between flex-column" style="height: calc(100vh - 232px);">
                    <form action="/product/update/${product.id}" method="post">
                        <div class="col-6">
                            <label class="form-label">Tên sản phẩm:</label>
                            <input type="text" class="form-control" name="productName" value="${product.productName}">
                        </div>
                        <div class="col-6">
                            <label class="form-label">Trạng thái:</label>
                            <select class="form-select" aria-label="Default select example" name="status">
                                <option value="${true}" ${product.status ? "selected" : ""}>Hoạt động</option>
                                <option value="${false}" ${!product.status ? "selected" : ""}>Ngưng hoạt động</option>
                            </select>
                        </div>
                        <div class="col-6">
                            <label class="form-label">Hãng:</label>
                            <select class="form-select" aria-label="Default select example" name="brandID">
                                <c:forEach items="${listBrands}" var="item">
                                    <option value="${item.id}" ${product.brand.id == item.id ? "selected" : ""}>${item.brandName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-6">
                            <label class="form-label">Thể loại:</label>
                            <select class="form-select" aria-label="Default select example" name="cateID">
                                <c:forEach items="${listCategories}" var="item">
                                    <option value="${item.id}" ${product.category.id == item.id ? "selected" : ""}>${item.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col align-self-start mt-2">
                            <button class="btn btn-primary" type="submit">Sửa</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>