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
<c:if test="${not empty errorMessage}">
    <script type="text/javascript">
        showNotification("${errorMessage}", "error");
    </script>
</c:if>
<div class="container-fluid d-flex" style="height: calc(100vh - 16px);">
    <jsp:include page="../navbar.jsp"/>
    <div style="width: calc(100vw - 274px); margin-left: 242px">
        <jsp:include page="../sub-nav.jsp"/>
        <div class="mt-3 container">
            <div class="row border p-3 d-flex">
                <div class="col-6">
                    <button type="button" class="btn btn-success" data-bs-toggle="modal"
                            data-bs-target="#modal-them">
                        <i class="fa-solid fa-plus"></i>
                        Thêm màu sắc
                    </button>
                </div>
<%--                Model thêm màu sắc--%>
                <div class="modal fade" id="modal-them" tabindex="-1"
                     aria-labelledby="exampleModalLabel"
                     aria-hidden="true">
                    <form action="/color/store" method="post">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Thêm màu sắc</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label class="form-label">Tên màu sắc:</label>
                                        <input type="text" class="form-control" name="colorName">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Mô tả:</label>
                                        <input type="text" class="form-control" name="description">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        Close
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        Save changes
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="border p-3 mt-3">
                <div class="row">
                    <div class="col">
                        <h5>Manage Color</h5>
                    </div>
                </div>
                <div class="d-flex flex-column justify-content-between" style="height: calc(100vh - 232px);">
                    <c:if test="${not empty listColors}">
                        <table class="table mt-4 table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>Mã</th>
                                <th>Tên màu</th>
                                <th>Mô tả</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listColors}" var="item">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.colorName}</td>
                                    <td>${item.description}</td>
                                    <td style="width: 1px;" class="text-nowrap">
                                        <a type="button" class="btn btn-primary" data-bs-toggle="modal"
                                           data-bs-target="#detail-san-pham${item.id}">Xem
                                        </a>
                                        <a type="button" class="btn btn-warning" data-bs-toggle="modal"
                                           data-bs-target="#update-san-pham${item.id}">Sửa</a>
                                        <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                                                data-bs-target="#delete-san-pham${item.id}">Xoá
                                        </button>
                                    </td>
                                </tr>
                                <!-- Modal sửa sản phẩm chi tiết-->
                                <div class="modal fade" id="update-san-pham${item.id}" tabindex="-1"
                                     aria-labelledby="exampleModalLabel"
                                     aria-hidden="true">
                                    <form action="/color/update/${item.id}" method="post">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Xem màu sắc</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                            aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="mb-3">
                                                        <label class="form-label">id:</label>
                                                        <input type="text" readonly class="form-control" name="id" value="${item.id}">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Tên màu:</label>
                                                        <input type="text" class="form-control"
                                                               value="${item.colorName}" name="colorName">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Mô tả:</label>
                                                        <input type="text" class="form-control"
                                                               value="${item.description}" name="description">
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                        Close
                                                    </button>
                                                    <button type="submit" class="btn btn-primary">Save changes</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <!-- Modal xem sản phẩm chi tiết-->
                                <div class="modal fade" id="detail-san-pham${item.id}" tabindex="-1"
                                     aria-labelledby="exampleModalLabel"
                                     aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Xem màu sắc</h5>
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
                                                    <label class="form-label">Tên màu:</label>
                                                    <input type="text" class="form-control" readonly
                                                           value="${item.colorName}">
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Mô tả:</label>
                                                    <input type="text" class="form-control" readonly
                                                           value="${item.description}">
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
                                                    xoá không?
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
                                                href="/color/list?page=${currentPage - 1}"
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
                                                   href="/color/list?page=${i}"
                                                >${i}</a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                </li>
                                <li class="page-item">
                                    <a class="page-link"
                                            <c:if test="${currentPage < totalPages}">
                                                href="/color/list?page=${currentPage + 1}"
                                            </c:if>
                                    >Next</a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                    <c:if test="${empty listColors}">
                        <p class="fst-italic mt-4">Không có bản ghi nào.</p>
                    </c:if>
                </div>
            </div>
        </div>


    </div>
</div>
</body>
</html>