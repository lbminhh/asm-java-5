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
<div class="container-fluid d-flex" style="height: calc(100vh - 16px);">
    <jsp:include page="../navbar.jsp"/>
    <div style="width: calc(100vw - 274px); margin-left: 242px">
        <jsp:include page="../sub-nav.jsp"/>
        <div class="mt-5 container">
            <div class="d-flex justify-content-end">
                <c:if test="${empty order}">
                    <button class="btn btn-primary"
                            data-bs-toggle="modal"
                            data-bs-target="#modelConfirmAddOrder">Tạo hoá đơn</button>
                    <form action="/order/create" method="post">
                        <input value="${userid}" type="hidden" name="userID">
                        <div
                                class="modal fade"
                                id="modelConfirmAddOrder"
                                tabindex="-1"
                                aria-labelledby="modelQrCodeLabel"
                                aria-hidden="true"
                        >
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                                            Bạn có muốn thêm hoá đơn không?
                                        </h1>
                                        <button
                                                type="button"
                                                class="btn-close"
                                                data-bs-dismiss="modal"
                                                aria-label="Close"
                                        ></button>
                                    </div>
                                    <div class="modal-footer">
                                        <button
                                                type="button"
                                                class="btn btn-secondary"
                                                data-bs-dismiss="modal"
                                        >
                                            Huỷ
                                        </button>
                                        <button type="submit" class="btn btn-primary">Đồng ý</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </c:if>
                <c:if test="${not empty order}">
                    <button class="btn btn-danger"
                            data-bs-toggle="modal"
                            data-bs-target="#modelConfirmDeleteOrder">Huỷ</button>
                    <form action="/order/delete/${order.id}">
                        <div
                                class="modal fade"
                                id="modelConfirmDeleteOrder"
                                tabindex="-1"
                                aria-labelledby="modelQrCodeLabel"
                                aria-hidden="true"
                        >
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                                            Bạn có muốn huỷ hoá đơn này không?
                                        </h1>
                                        <button
                                                type="button"
                                                class="btn-close"
                                                data-bs-dismiss="modal"
                                                aria-label="Close"
                                        ></button>
                                    </div>
                                    <div class="modal-footer">
                                        <button
                                                type="button"
                                                class="btn btn-secondary"
                                                data-bs-dismiss="modal"
                                        >
                                            Huỷ
                                        </button>
                                        <button type="submit" class="btn btn-primary">Đồng ý</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </c:if>
            </div>
        </div>
        <div class="mt-5 mt-2 d-flex justify-content-between">
            <h3>Mã hoá đơn: ${not empty order.id ? order.id : "###"}</h3>
            <div>
                <button
                        class="btn btn-primary"
                        data-bs-toggle="modal"
                        data-bs-target="#modelQrCode"
                        onclick="openCamera()"
                >
                    Quét QR
                </button>
                <!-- Model QR -->
                <div
                        class="modal fade"
                        id="modelQrCode"
                        tabindex="-1"
                        aria-labelledby="modelQrCodeLabel"
                        aria-hidden="true"
                >
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">
                                    #Quét QR
                                </h1>
                                <button
                                        type="button"
                                        class="btn-close"
                                        data-bs-dismiss="modal"
                                        aria-label="Close"
                                ></button>
                            </div>
                            <div class="modal-body">
                                <div id="qr-code"></div>
                            </div>
                            <div class="modal-footer">
                                <button
                                        type="button"
                                        class="btn btn-secondary"
                                        data-bs-dismiss="modal"
                                        onclick="closeCamera()"
                                >
                                    Close
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <button
                        class="btn btn-primary"
                        data-bs-toggle="modal"
                        data-bs-target="#exampleModal"
                >
                    Thêm sản phẩm
                </button>
                <!-- Modal SP -->
                <div
                        class="modal fade"
                        id="exampleModal"
                        tabindex="-1"
                        aria-labelledby="exampleModalLabel"
                        aria-hidden="true"
                >
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">
                                    #Sản phẩm
                                </h1>
                                <button
                                        type="button"
                                        class="btn-close"
                                        data-bs-dismiss="modal"
                                        aria-label="Close"
                                ></button>
                            </div>
                            <div class="modal-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <label class="form-label">Hãng:</label>
                                        <select
                                                class="form-select"
                                                aria-label="Default select example"
                                        >
                                            <option selected>--Lựa chọn--</option>
                                            <option value="1">One</option>
                                            <option value="2">Two</option>
                                            <option value="3">Three</option>
                                        </select>
                                    </div>
                                    <div>
                                        <label class="form-label">Thể loại:</label>
                                        <select
                                                class="form-select"
                                                aria-label="Default select example"
                                        >
                                            <option selected>--Lựa chọn--</option>
                                            <option value="1">One</option>
                                            <option value="2">Two</option>
                                            <option value="3">Three</option>
                                        </select>
                                    </div>
                                    <div>
                                        <label class="form-label">Màu sắc:</label>
                                        <select
                                                class="form-select"
                                                aria-label="Default select example"
                                        >
                                            <option selected>--Lựa chọn--</option>
                                            <option value="1">One</option>
                                            <option value="2">Two</option>
                                            <option value="3">Three</option>
                                        </select>
                                    </div>
                                    <div>
                                        <label class="form-label">Kích cỡ:</label>
                                        <select
                                                class="form-select"
                                                aria-label="Default select example"
                                        >
                                            <option selected>--Lựa chọn--</option>
                                            <option value="1">One</option>
                                            <option value="2">Two</option>
                                            <option value="3">Three</option>
                                        </select>
                                    </div>
                                </div>
                                <hr/>
                                <div>
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Tên sản phẩm</th>
                                            <th scope="col">Giá</th>
                                            <th scope="col">Màu sắc</th>
                                            <th scope="col">Kích cỡ</th>
                                            <th scope="col">Hãng</th>
                                            <th scope="col">Thể loại</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listProductCard}" var="item" varStatus="loop">
                                                <tr>
                                                    <th scope="row">${ loop.index + 1}</th>
                                                    <td>${ item.productName }</td>
                                                    <td>${ item.price }</td>
                                                    <td>${ item.colorName }</td>
                                                    <td>${ item.sizeName }</td>
                                                    <td>${ item.brandName }</td>
                                                    <td>${ item.categoryName }</td>
                                                    <td>${ item.quantity }</td>
                                                    <td>
                                                        <button class="btn btn-primary"
                                                                onclick="openMyModal2('modelAddOrderDetail${loop.index}')">Thêm</button>
                                                    </td>
                                                    <div
                                                            class="modal bg-dark bg-opacity-50"
                                                            id="modelAddOrderDetail${loop.index}"
                                                            tabindex="-1"
                                                            aria-labelledby="modelQrCodeLabel"
                                                            aria-hidden="true"
                                                    >
                                                        <div class="modal-dialog modal-dialog-centered">
                                                            <form class="form-add-product-order" action="/order-detail/create" method="post">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                                                                            Sản phẩm: ${item.productName}
                                                                        </h1>
                                                                        <button
                                                                                type="button"
                                                                                class="btn-close"
                                                                                data-bs-dismiss="modal"
                                                                                aria-label="Close"
                                                                        ></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Màu sắc</label>
                                                                            <input class="form-control" disabled type="text" value="${item.colorName}">
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Kích cỡ</label>
                                                                            <input class="form-control" disabled type="text" value="${item.sizeName}">
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Giá</label>
                                                                            <input class="form-control" disabled type="text" value="${item.price}">
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Số lượng</label>
                                                                            <input class="form-control" type="number" name="quantity">
                                                                        </div>
                                                                        <input type="hidden" name="orderID" value="${order.id}">
                                                                        <input type="hidden" name="productDetailID" value="${item.productDetailID}">
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button
                                                                                type="button"
                                                                                class="btn btn-secondary"
                                                                                data-bs-dismiss="modal"
                                                                        >
                                                                            Huỷ
                                                                        </button>
                                                                        <button type="submit" class="btn btn-primary">Đồng ý</button>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button
                                        type="button"
                                        class="btn btn-secondary"
                                        data-bs-dismiss="modal"
                                >
                                    Close
                                </button>
                                <button type="button" class="btn btn-primary">
                                    Save changes
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <c:if test="${not empty listOrderDetails}">
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Tên sản phẩm</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Tổng tiền</th>
                        <th scope="col">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listOrderDetails}" var="item">
                            <tr>
                                <th scope="row">1</th>
                                <td class="text-wrap">
                                    <h4>${item.productName}</h4>
                                    <div class="text-wrap" style="width: 110px">
                                        <span>Kích cỡ: ${item.sizeName}</span>
                                        <span>Màu sắc: ${item.colorName}</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="d-flex">
                                        <form action="/order-detail/update/${item.id}" method="post">
                                            <input type="hidden" value="${item.productDetailID}" name="productDetailID">
                                            <input type="hidden" value="${order.id}" name="orderID">
                                            <input type="hidden" value="${1}" name="quantity">
                                            <input type="hidden" value="minus" name="method">
                                            <button class="btn btn-outline-dark" ${item.quantity == 1 ? "disabled" : ""}>-</button>
                                        </form>
                                        <span style="margin: 6px 8px 0;">${item.quantity}</span>
                                        <form action="/order-detail/update/${item.id}" method="post">
                                            <input type="hidden" value="${item.productDetailID}" name="productDetailID">
                                            <input type="hidden" value="${order.id}" name="orderID">
                                            <input type="hidden" value="${1}" name="quantity">
                                            <input type="hidden" value="plus" name="method">
                                            <button class="btn btn-outline-dark">+</button>
                                        </form>
                                    </div>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${item.totalMoney}" type="currency" pattern="#,###"
                                                      currencySymbol="₫" groupingUsed="true"/> đ
                                </td>
                                <td>
                                    <button class="btn btn-danger"
                                            data-bs-toggle="modal"
                                            data-bs-target="#modelConfirmDeleteOrderDetail${item.id}">Xoá</button>
                                    <form action="/order-detail/delete/${item.id}">
                                        <div
                                                class="modal fade"
                                                id="modelConfirmDeleteOrderDetail${item.id}"
                                                tabindex="-1"
                                                aria-labelledby="modelQrCodeLabel"
                                                aria-hidden="true"
                                        >
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                                                            Bạn có muốn xoá không?
                                                        </h1>
                                                        <button
                                                                type="button"
                                                                class="btn-close"
                                                                data-bs-dismiss="modal"
                                                                aria-label="Close"
                                                        ></button>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button
                                                                type="button"
                                                                class="btn btn-secondary"
                                                                data-bs-dismiss="modal"
                                                        >
                                                            Huỷ
                                                        </button>
                                                        <button type="submit" class="btn btn-primary">Đồng ý</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty listOrderDetails}">
                <p class="fst-italic mt-4">Không có bản ghi nào.</p>
            </c:if>
        </div>
        <div class="mt-5">
            <div class="d-flex justify-content-between">
                <h3>#Khách hàng</h3>
                <button class="btn btn-primary"
                        data-bs-toggle="modal"
                        data-bs-target="#modelCustomer">Chọn</button>
                <!-- Modal KH -->
                <div
                        class="modal fade"
                        id="modelCustomer"
                        tabindex="-1"
                        aria-labelledby="exampleModalLabel"
                        aria-hidden="true"
                >
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">
                                    #Khách hàng
                                </h1>
                                <button
                                        type="button"
                                        class="btn-close"
                                        data-bs-dismiss="modal"
                                        aria-label="Close"
                                ></button>
                            </div>
                            <div class="modal-body">
                                <div>
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Tên khách hàng</th>
                                            <th scope="col">Số điện thoại</th>
                                            <th scope="col">Địa chỉ</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${listCustomers}" var="item" varStatus="loop">
                                            <tr>
                                                <th scope="row">${ loop.index + 1}</th>
                                                <td>${ item.fullName }</td>
                                                <td>${ item.phoneNumber }</td>
                                                <td>${ item.address }</td>
                                                <td>
                                                    <button class="btn btn-primary"
                                                            onclick="openMyModal2('modelCustomer${loop.index}')">Thêm</button>
                                                </td>
                                                <div
                                                        class="modal bg-dark bg-opacity-50"
                                                        id="modelCustomer${loop.index}"
                                                        tabindex="-1"
                                                        aria-labelledby="modelQrCodeLabel"
                                                        aria-hidden="true"
                                                >
                                                        <div class="modal-dialog modal-dialog-centered">
                                                            <form action="/order/update-customer/${order.id}" method="post">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h1 class="modal-title fs-5" id="exampleModalLabel">
                                                                            Bạn muốn thêm khách hàng này chứ
                                                                        </h1>
                                                                        <button
                                                                                type="button"
                                                                                class="btn-close"
                                                                                data-bs-dismiss="modal"
                                                                                aria-label="Close"
                                                                        ></button>
                                                                    </div>
                                                                    <input type="hidden" name="id" value="${item.id}">
                                                                    <input type="hidden" name="fullName" value="${item.fullName}">
                                                                    <input type="hidden" name="phoneNumber" value="${item.phoneNumber}">
                                                                    <input type="hidden" name="address" value="${item.address}">
                                                                    <div class="modal-footer">
                                                                        <button
                                                                                type="button"
                                                                                class="btn btn-secondary"
                                                                                data-bs-dismiss="modal"
                                                                        >
                                                                            Huỷ
                                                                        </button>
                                                                        <button type="submit" class="btn btn-primary">Đồng ý</button>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </div>
                                                </div>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button
                                        type="button"
                                        class="btn btn-secondary"
                                        data-bs-dismiss="modal"
                                >
                                    Close
                                </button>
                                <button type="button" class="btn btn-primary">
                                    Save changes
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <hr/>
            <div class="w-50">
               <form action="/order/update-customer/${order.id}" method="post">
                   <input type="hidden" name="id" value="${customer.id}">
                   <div>
                       <span>Tên khách hàng:</span>
                       <input type="text" class="form-control" name="fullName" value="${customer.fullName}"/>
                   </div>
                   <div>
                       <span>Số điện thoại:</span>
                       <input type="text" class="form-control" name="phoneNumber" value="${customer.phoneNumber}"/>
                   </div>
                   <div>
                       <span>Địa chỉ:</span>
                       <input type="text" class="form-control" name="address" value="${customer.address}"/>
                   </div>
                   <div class="">
                       <button class="btn btn-primary" type="submit">Lưu</button>
                   </div>
               </form>
            </div>
        </div>
        <div class="mt-5" style="height: 300px">
            <h3>#Thông tin thanh toán</h3>
            <hr/>
            <div class="w-50">
                <div>
                    <span>Tiền hàng:</span>
                    <span class="fw-bold text-danger"><fmt:formatNumber value="${order.totalMoney}" type="currency" pattern="#,###"
                                            currencySymbol="₫" groupingUsed="true"/> đ</span>
                </div>
                <div class="d-flex mt-3">
                    <span class="me-3">Phương thức thanh toán:</span>
                    <div class="form-check me-2">
                        <input
                                class="form-check-input"
                                type="radio"
                                name="payment"
                                id="flexRadioDefault1"
                                value="Tiền mặt"
                        />
                        <label class="form-check-label" for="flexRadioDefault1">
                            Tiền mặt
                        </label>
                    </div>
                    <div class="form-check">
                        <input
                                class="form-check-input"
                                type="radio"
                                name="payment"
                                id="flexRadioDefault2"
                                value="Chuyển khoản"
                        />
                        <label class="form-check-label" for="flexRadioDefault2">
                            Chuyển khoản
                        </label>
                    </div>
                </div>
                <div class="mt-3">
                    <button class="btn btn-success"
                            data-bs-toggle="modal"
                            data-bs-target="#modelConfirmCompleteOrder">Thanh toán</button>
                    <div
                            class="modal fade"
                            id="modelConfirmCompleteOrder"
                            tabindex="-1"
                            aria-labelledby="modelQrCodeLabel"
                            aria-hidden="true"
                    >
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">
                                        Bạn có muốn hoàn thành hoá đơn này không?
                                    </h1>
                                    <button
                                            type="button"
                                            class="btn-close"
                                            data-bs-dismiss="modal"
                                            aria-label="Close"
                                    ></button>
                                </div>
                                <div class="modal-footer">
                                    <button
                                            type="button"
                                            class="btn btn-secondary"
                                            data-bs-dismiss="modal"
                                    >
                                        Huỷ
                                    </button>
                                    <button class="btn btn-primary" onclick="submitFormCompleteOrder()">Đồng ý</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

    function openMyModal2(id) {
        console.log(id)
        let myModal = new
        bootstrap.Modal(document.getElementById(id), {});
        myModal.show();
    }
    let html5QrcodeScanner = new Html5QrcodeScanner(
        "qr-code",
        {fps: 10, qrbox: {width: 250, height: 250}},
        /* verbose= */ false);
    console.log("Component: " + document.getElementById('qr-code'))
    function onScanSuccess(decodedText, decodedResult) {
        if (isNaN(decodedText)) {
            alert("QR không phù hợp");
            return;
        }

        submitFormCreateOrderDetail(decodedText)
        html5QrcodeScanner.clear();
    }


    function closeCamera() {
        html5QrcodeScanner.clear();
    }

    function openCamera() {
        html5QrcodeScanner.render(onScanSuccess);
    }

    function onScanFailure(error) {
        // handle scan failure, usually better to ignore and keep scanning.
        // for example:
        console.warn(`Code scan error = ${error}`);
    }

    function submitFormCreateOrderDetail(productDetailID) {
        var orderDetailRequest = {
            productDetailID: Number(productDetailID),
            quantity: 1,
            orderID: `${order.id}`
        };

        console.log(orderDetailRequest)

        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/order-detail/qr-code',
            data: JSON.stringify(orderDetailRequest),
            contentType: 'application/json',
            success: function() {
                alert("Thêm thành công");
                window.location.href = `http://localhost:8080/order/detail?id=${order.id}`
            },
            error: function(error) {
                alert('Error: ' + error);
            }
        });
    }

    function submitFormCompleteOrder() {
        var payment = document.getElementsByName('payment');
        var payment_value;
        for(var i = 0; i < payment.length; i++){
            if(payment[i].checked){
                payment_value = payment[i].value;
            }
        }
        if(!payment_value) {
            alert("Vui lòng chọn phương thức thanh toán!");
            return;
        }

        var orderRequest = {
            quantity: `${order.quantity}`,
            status: true,
            payment: payment_value,
            totalMoney: `${order.totalMoney}`,
            customerID: `${customer.id}`,
            userID: `${user.id}`
        };

        $.ajax({
            type: 'POST',
            url: `http://localhost:8080/order/comlete/${order.id}`,
            data: JSON.stringify(orderRequest),
            contentType: 'application/json',
            success: function() {
                alert("Hoá đơn đã đc hoàn thành!");
                window.location.href = `http://localhost:8080/order/index`
            },
            error: function(error) {
                alert('Error: ' + error);
            }
        });
    }

    const forms = document.querySelectorAll('.form-add-product-order');
    console.log(forms)

    // Lặp qua từng form và gắn sự kiện 'submit'
    forms.forEach(form => {
        form.addEventListener('submit', function(event) {
            // Lấy giá trị của input
            const input = form.querySelector('input[name="quantity"]');
            const value = parseFloat(input.value);
            console.log('Value: ' + value)
            return;
            // console.log(value)
            //
            // event.preventDefault();
            // // Kiểm tra giá trị có lớn hơn 0 không
            // if (isNaN(value) || value <= 0) {
            //     event.preventDefault()
            //     alert('Giá trị phải lớn hơn 0');
            //     return
            // }
            console.log(form)
            event.preventDefault();
            return;


        });
    });

</script>
</html>