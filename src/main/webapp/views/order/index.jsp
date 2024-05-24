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
        <div class="mt-5 mt-2 d-flex justify-content-between">
            <h3>Mã hoá đơn: ${not empty order.id ? order.id : "###"}</h3>
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
                                        <span style="margin: 6px 8px 0;">${item.quantity}</span>
                                    </div>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${item.totalMoney}" type="currency" pattern="#,###"
                                                      currencySymbol="₫" groupingUsed="true"/> đ
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

            </div>
            <hr/>
            <div class="w-50">
               <input type="hidden" name="id" value="${customer.id}">
               <div>
                   <span>Tên khách hàng:</span>
                   <input type="text" class="form-control" readonly name="fullName" value="${customer.fullName}"/>
               </div>
               <div>
                   <span>Số điện thoại:</span>
                   <input type="text" class="form-control" readonly name="phoneNumber" value="${customer.phoneNumber}"/>
               </div>
               <div>
                   <span>Địa chỉ:</span>
                   <input type="text" class="form-control" readonly name="address" value="${customer.address}"/>
               </div>
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
                    <span class="me-3">Phương thức thanh toán: ${order.payment}</span>
                </div>
                <div class="d-flex mt-3">
                    <span class="me-3">Người tạo: ${user.fullName}</span>
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
        // handle the scanned code as you like, for example:
        console.log(`Code matched = ${decodedText}`, decodedResult);
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