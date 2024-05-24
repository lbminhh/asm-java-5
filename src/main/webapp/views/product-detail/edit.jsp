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
                    <a href="/product-detail/list?page=1&productID=${id}" class="btn btn-success text-white fw-bold">
                        Quay lại
                    </a>
                </div>
            </div>
            <div class="border p-3 mt-3">
                <div class="row" style="margin-bottom: 40px;">
                    <div class="col-3">
                        <h5>Sửa Chi tiết Sản Phẩm: ${product.productName}</h5>
                    </div>
                </div>
                <div class="d-flex justify-content-between flex-column" style="height: calc(100vh - 232px);">
                    <form action="/product-detail/update/${id}" method="post">
                        <div class="col-6">
                            <label class="form-label">Mã sản phẩm chi tiết:</label>
                            <input class="form-control" name="id" value="${id}">
                        </div>
                        <div class="col-6">
                            <label class="form-label">Tên sản phẩm:</label>
                            <select class="form-select" aria-label="Default select example" name="productID">
                                <option value="${product.id}" selected>${product.productName}</option>
                            </select>
                        </div>
                        <div class="col-6">
                            <label class="form-label">Giá:</label>
                            <input class="form-control" type="number" name="price" value="${request.price}">
                            <c:if test="${not empty errors['price']}">
                                <small style="color: red">${errors['price']}</small>
                            </c:if>
                        </div>
                        <div class="col-6">
                            <label class="form-label">Số lượng:</label>
                            <input class="form-control" type="number" name="quantity" value="${request.quantity}">
                            <c:if test="${not empty errors['quantity']}">
                                <small style="color: red">${errors['quantity']}</small>
                            </c:if>
                        </div>
                        <div class="col-6">
                            <label class="form-label">Màu sắc:</label>
                            <select class="form-select" aria-label="Default select example" name="colorID">
                                <option value="${null}">--Lựa chọn--</option>
                                <c:forEach items="${listColors}" var="item">
                                    <option value="${item.id}" ${request.colorID == item.id ? "selected" : ""}>
                                            ${item.colorName}
                                    </option>
                                </c:forEach>
                            </select>
                            <c:if test="${not empty errors['colorID']}">
                                <small style="color: red">${errors['colorID']}</small>
                            </c:if>
                        </div>
                        <div class="col-6">
                            <label class="form-label">Kích cỡ:</label>
                            <select class="form-select" aria-label="Default select example" name="sizeID">
                                <option value="${null}">--Lựa chọn--</option>
                                <c:forEach items="${listSizes}" var="item">
                                    <option value="${item.id}" ${request.sizeID == item.id ? "selected" : ""}>
                                            ${item.sizeName}
                                    </option>
                                </c:forEach>
                            </select>
                            <c:if test="${not empty errors['sizeID']}">
                                <small style="color: red">${errors['sizeID']}</small>
                            </c:if>
                        </div>
                        <div class="col-6">
                            <label class="form-label">Trạng thái:</label>
                            <select class="form-select" aria-label="Default select example" name="status">
                                <option value="${true}" ${request.status ? "selected" : ""}>Hoạt động</option>
                                <option value="${false}" ${request.status == false ? "selected" : ""}>Ngưng hoạt động</option>
                            </select>
                            <c:if test="${not empty errors['status']}">
                                <small style="color: red">${errors['status']}</small>
                            </c:if>
                        </div>
                        <div class="col align-self-start mt-2">
                            <button class="btn btn-success">Thêm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
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
</html>