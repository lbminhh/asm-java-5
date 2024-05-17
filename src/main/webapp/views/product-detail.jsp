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
</head>
<body>
<div class="container-fluid d-flex" style="height: calc(100vh - 16px);">
    <jsp:include page="navbar.jsp"/>
    <div style="width: calc(100vw - 274px);">
        <jsp:include page="sub-nav.jsp"/>
        <div class="mt-3 container">
            <div class="row border p-3 d-flex">
                <div class="col-6">
                    <button type="button" class="btn btn-success text-white fw-bold" data-bs-toggle="modal"
                            data-bs-target="#add-san-pham">
                        <i class="fa-solid fa-plus"></i>
                        Thêm sản phẩm chi tiết
                    </button>
                </div>

                <!-- Modal thêm sản phẩm -->
                <div class="modal fade" id="add-san-pham" tabindex="-1" aria-labelledby="exampleModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <form action="/product/add" method="post">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Thêm sản phẩm chi tiết</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    
                                    <div class="mb-3">
                                        <label class="form-label">Mã sản phẩm:</label>
                                        <input type="text" class="form-control"
                                               placeholder="Please enter here..." name="productCode">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Tên sản phẩm:</label>
                                        <input type="text" class="form-control"
                                               placeholder="Please enter here..." name="productName">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Trạng thái:</label>
                                        <select class="form-select" name="status">
                                            <option selected>--Lựa chọn--</option>
                                            <option value="${true}">
                                                Đang hoạt động
                                            </option>
                                            <option value="${false}">
                                                Ngừng hoạt động
                                            </option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Mô tả:</label>
                                        <textarea class="form-control" id="exampleFormControlTextarea1" rows="3"
                                        ></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="formFile" class="form-label">URL ảnh:</label>
                                        <input class="form-control" type="text">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                    >Close
                                    </button>
                                    <button type="submit" class="btn btn-primary">Save
                                        changes
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="border p-3 mt-3">
                <div class="row">
                    <div class="col-3">
                        <h5>Manage Products</h5>
                    </div>
                    <div class="col-4 d-flex justify-content-end">
                        <form action="/product/search" class="d-flex">
                            <span class="form-label my-auto me-2">Tìm sản phẩm:</span>
                            <input type="text" class="form-control"
                                   placeholder="Please product name here..." name="value" value="${valueSearch}">
                            <button class="btn btn-primary" type="submit">Tìm</button>
                        </form>
                    </div>
                </div>
                <div class="d-flex flex-column justify-content-between" style="height: calc(100vh - 232px);">
                    <table class="table mt-4 table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>Mã sản phẩm</th>
                            <th>Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Số lượng tồn</th>
                            <th>Trạng thái</th>
                            <th>Tương tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${list}" var="item">
                            <tr>
                                <td>${item.productCode}</td>
                                <td>
                                    <div class="border rounded bg-light overflow-hidden d-flex align-items-center justify-content-center shadow"
                                         style="height: 60px; width: 70px;">
                                        <img>
                                    </div>
                                </td>
                                <td>${item.productName}</td>
                                <td>
                                        ${item.totalQuantity == null ? 0 : item.totalQuantity}
                                </td>
                                <td>${item.status ? "Đang hoạt động" : "Ngừng hoạt động"}</td>
                                <td style="width: 1px;" class="text-nowrap">
                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                            data-bs-target="#detail-san-pham${item.id}">Xem
                                    </button>
                                    <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                            data-bs-target="#update-san-pham${item.id}">Sửa
                                    </button>
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                                            data-bs-target="#delete-san-pham${item.id}">Xoá
                                    </button>
                                </td>
                            </tr>
                            <!-- Modal sửa sản phẩm -->
                            <div class="modal fade" id="update-san-pham${item.id}" tabindex="-1"
                                 aria-labelledby="exampleModalLabel"
                                 aria-hidden="true">
                                <div class="modal-dialog">
                                    <form action="/product/update/${item.id}" method="post">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Sửa sản phẩm</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="mb-3">
                                                    <label class="form-label">Code:</label>
                                                    <input type="text" class="form-control"
                                                           placeholder="Please enter here..." readonly
                                                           value="${item.productCode}" name="productCode">
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Tên sản phẩm:</label>
                                                    <input type="text" class="form-control"
                                                           placeholder="Please enter here..."
                                                           value="${item.productName}" name="productName">
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Trạng thái:</label>
                                                    <select class="form-select" name="status">
                                                        <option value="${true}" ${item.status ? "selected" : ""}>
                                                            Đang hoạt động
                                                        </option>
                                                        <option value="${false}" ${!item.status ? "selected" : ""}>
                                                            Ngừng hoạt động
                                                        </option>
                                                    </select>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="form-label" class="form-label">Ảnh</label>
                                                    <div>
                                                        <img alt="" style="height: 60px;">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                                >Close
                                                </button>
                                                <button type="submit" class="btn btn-primary">Save
                                                    changes
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Modal xem sản phẩm-->
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
                                                <label class="form-label">Code:</label>
                                                <input type="text" class="form-control" readonly
                                                       value="${item.productCode}" disabled>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Tên sản phẩm:</label>
                                                <input type="text" class="form-control" readonly
                                                       value="${item.productName}">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Số lượng tồn:</label>
                                                <input type="text" class="form-control" readonly
                                                       value="${item.totalQuantity == null ? 0 : item.totalQuantity}">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Trạng thái:</label>
                                                <input type="text" class="form-control" readonly
                                                       value="${item.status ? "Đang hoạt động" : "Ngừng hoạt động"}">
                                            </div>
                                            <div class="mb-3">
                                                <label for="form-label" class="form-label">Ảnh</label>
                                                <div>
                                                    <img alt="" style="height: 60px;">
                                                </div>
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
                                                xoá ${item.productCode} không?
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
                                            <c:if test="${!isSearch || isSearch == null}">
                                                href="/product/list?page=${currentPage - 1}"
                                            </c:if>
                                        </c:if>
                                        <c:if test="${currentPage > 1}">
                                            <c:if test="${isSearch && isSearch != null}">
                                                href="/product/list/search?page=${currentPage - 1}&value=${valueSearch}"
                                            </c:if>
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
                                        <c:if test="${!isSearch || isSearch == null}">
                                            href="/product/list?page=${i}"
                                        </c:if>
                                        <c:if test="${isSearch && isSearch != null}">
                                            href="/product/list/search?page=${i}&value=${valueSearch}"
                                        </c:if>
                                >${i}</a>
                            </li>
                            </c:forEach>
                            </c:if>
                            </li>
                            <li class="page-item">
                                <a class="page-link"
                                        <c:if test="${currentPage < totalPages}">
                                            <c:if test="${!isSearch || isSearch == null}">
                                                href="/product/list?page=${currentPage + 1}"
                                            </c:if>
                                        </c:if>
                                        <c:if test="${currentPage < totalPages}">
                                            <c:if test="${isSearch && isSearch != null}">
                                                href="/product/list/search?page=${currentPage + 1}&value=${valueSearch}"
                                            </c:if>
                                        </c:if>
                                >Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>


    </div>
</div>
</body>

</html>