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
                    <a href="/order/index" class="btn btn-success text-white fw-bold">
                        <i class="fa-solid fa-plus"></i>
                        Bán hàng
                    </a>
                </div>
            </div>
            <div class="border p-3 mt-3">
                <div class="row">
                    <div class="col-3">
                        <h5>Manage Orders</h5>
                    </div>
                </div>
                <div class="d-flex flex-column justify-content-between" style="height: calc(100vh - 232px);">
                    <table class="table mt-4 table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên khách hàng</th>
                            <th>Số lượng</th>
                            <th>Tổng tiền</th>
                            <th>Phương thức thanh toán</th>
                            <th>Thời gian</th>
                            <th>Người tạo</th>
                            <th>Trạng thái</th>
                            <th>Tương tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${list}" var="item" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${item.customer.fullName}</td>
                                <td>${item.quantity}</td>
                                <td>
                                    <fmt:formatNumber value="${item.totalMoney}" type="currency" pattern="#,###"
                                                      currencySymbol="₫" groupingUsed="true"/> đ
                                </td>
                                <td>
                                        ${item.payment}
                                </td>
                                <td>
                                    ${item.timeCreate}
                                </td>
                                <td>${item.user.fullName}</td>
                                <td>${item.status ? "Hoàn thành" : "Chưa hoàn thành"}</td>
                                <td style="width: 1px;" class="text-nowrap">
                                    <a class="btn btn-primary" href="/order/detail/${item.id}">Xem chi tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <li class="page-item">
                                <a class="page-link"
                                    <c:if test="${currentPage > 1}">
                                        <c:if test="${!isSearch || isSearch == null}">
                                            href="/order/list?page=${currentPage - 1}"
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
                                                        href="/order/list?page=${i}"
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
                                            href="/order/list?page=${currentPage + 1}"
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