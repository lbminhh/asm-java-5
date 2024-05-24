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
<div class="container-fluid d-flex" style="height: calc(100vh - 16px);">
    <jsp:include page="../navbar.jsp"/>
    <div style="width: calc(100vw - 274px); margin-left: 242px">
        <jsp:include page="../sub-nav.jsp"/>
        <div class="mt-3 container">
            <div class="row border p-3 d-flex">
                <div class="col-6">
                    <button onclick="handleChangeViewProductDetail()" class="btn btn-success text-white fw-bold">
                        <i class="fa-solid fa-plus"></i>
                        Thêm sản phẩm chi tiết
                    </button>
                </div>
            </div>
            <div class="border p-3 mt-3">
                <div class="row">
                    <div class="col">
                        <h5>Manage Product Detail</h5>
                    </div>
                    <div class="col-9">
                        <form action="/product-detail/list">
                            <div class="d-flex">
                                <div class="d-flex">
                                    <input type="hidden" name="page" value="${1}">
                                    <span class="form-label">Sản phẩm:</span>
                                    <select class="form-select" aria-label="Default select example" name="productID">
                                        <option value="${null}">--Lựa chọn--</option>
                                        <c:forEach items="${listProducts}" var="item">
                                            <option value="${item.id}" ${productID == item.id ? "selected" : ""}>${item.productName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="d-flex mx-3">
                                    <input type="hidden" name="page" value="${1}">
                                    <span class="form-label">Màu sắc:</span>
                                    <select class="form-select" aria-label="Default select example" name="colorID">
                                        <option value="">--Lựa chọn--</option>
                                        <c:forEach items="${listColors}" var="item">
                                            <option value="${item.id}" ${colorID == item.id ? "selected" : ""}>${item.colorName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="d-flex">
                                    <input type="hidden" name="page" value="${1}">
                                    <span class="form-label">Kích cỡ:</span>
                                    <select class="form-select" aria-label="Default select example" name="sizeID">
                                        <option value="">--Lựa chọn--</option>
                                        <c:forEach items="${listSizes}" var="item">
                                            <option value="${item.id}" ${sizeID == item.id ? "selected" : ""}>${item.sizeName}</option>
                                        </c:forEach>
                                    </select>
                                    <button class="btn btn-primary" type="submit">Tìm</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="d-flex flex-column justify-content-between" style="height: calc(100vh - 232px);">
                    <c:if test="${not empty listProductDetail}">
                        <table class="table mt-4 table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>Mã sản phẩm</th>
                                <th>Tên sản phẩm</th>
                                <th>Giá</th>
                                <th>Màu sắc</th>
                                <th>Kích cỡ</th>
                                <th>Số lượng tồn</th>
                                <th>Trạng thái</th>
                                <th>Tương tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listProductDetail}" var="item">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.productName}</td>
                                    <td>
                                        <fmt:formatNumber value="${item.price}" type="currency" pattern="#,###"
                                                          currencySymbol="₫" groupingUsed="true"/> đ
                                    </td>
                                    <td>${item.colorName}</td>
                                    <td>${item.sizeName}</td>
                                    <td>
                                            ${item.quantity == null ? 0 : item.quantity}
                                    </td>
                                    <td>${item.status ? "Đang hoạt động" : "Ngừng hoạt động"}</td>
                                    <td style="width: 1px;" class="text-nowrap">
                                        <a type="button" class="btn btn-primary" data-bs-toggle="modal"
                                           data-bs-target="#detail-san-pham${item.id}">Xem
                                        </a>
                                        <a class="btn btn-warning" href="/product-detail/edit/${item.id}">Sửa</a>
                                    </td>
                                </tr>
                                <!-- Modal xem sản phẩm chi tiết-->
                                <div class="modal fade" id="detail-san-pham${item.id}" tabindex="-1"
                                     aria-labelledby="exampleModalLabel"
                                     aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Xem sản phẩm</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="mb-3">
                                                    <label class="form-label">id:</label>
                                                    <input type="text" class="form-control" readonly value="${item.id}"
                                                           disabled>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Tên sản phẩm:</label>
                                                    <input type="text" class="form-control" readonly
                                                           value="${item.productName}">
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Số lượng tồn:</label>
                                                    <input type="text" class="form-control" readonly
                                                           value="${item.quantity == null ? 0 : item.quantity}">
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Trạng thái:</label>
                                                    <input type="text" class="form-control" readonly
                                                           value="${item.status ? "Đang hoạt động" : "Ngừng hoạt động"}">
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                    Close
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Modal xác nhận xoá-->
                                <div class="modal fade" id="delete-san-pham${item.id}" tabindex="-1"
                                     aria-labelledby="exampleModalLabel"
                                     aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Bạn có chắc chắn muốn
                                                    xoá ${item.productName} không?
                                                </h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                    Close
                                                </button>
                                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Xoá
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            </tbody>
                        </table>
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item">
                                    <a class="page-link"
                                            <c:if test="${currentPage > 1}">
                                                href="/product-detail/list?page=${currentPage - 1}&productID=${productID}&colorID=${colorID}&sizeID=${sizeID}"
                                            </c:if>
                                       tabindex="-1"
                                       aria-disabled="true">
                                        Previous
                                    </a>
                                </li>

                                <li class="page-item">
                                    <c:if test="${totalPages != null}">
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item">
                                    <a class="page-link"
                                       href="/product-detail/list?page=${i}&productID=${productID}&colorID=${colorID}&sizeID=${sizeID}"
                                    >${i}</a>
                                </li>
                                </c:forEach>
                                </c:if>
                                </li>
                                <li class="page-item">
                                    <a class="page-link"
                                            <c:if test="${currentPage < totalPages}">
                                                href="/product-detail/list?page=${currentPage + 1}&productID=${productID}&colorID=${colorID}&sizeID=${sizeID}"
                                            </c:if>
                                    >Next</a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                    <c:if test="${empty listProductDetail}">
                        <p class="fst-italic mt-4">Không có bản ghi nào.</p>
                    </c:if>
                </div>
            </div>
        </div>


    </div>
</div>
</body>
<script>
    function handleChangeViewProductDetail() {
        var productID = document.querySelector('select[name="productID"]').value;
        if (!productID) {
            showNotification("Vui lòng chọn sản phẩm", "error");
            return;
        }
        let href = `http://localhost:8080/product-detail/create?productID=` + productID;
        console.log(href)
        window.location.href = href
    }
</script>
</html>