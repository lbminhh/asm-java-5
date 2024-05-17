<%@page language="java" pageEncoding="UTF-8" %>
<!-- Navs -->
<div class="bg-light p-2" style="width: 250px; min-height: calc(100vh - 56px);">
    <ul class="nav flex-column nav-pills">
        <li class="nav-item d-flex mb-5">
            <div class="m-auto rounded overflow-hidden" style="height: 50px; width: 70px;">
                <img class="w-100 h-100" src="/img/logo-market.jpg" alt="kh có">
            </div>
        </li>
        <li class="nav-item">
            <a class="nav-link">Bán hàng</a>
        </li>
        <li class="nav-item">
            <button class="nav-link" onclick="changeView(${"product"})">Quản lý sản phẩm</button>
        </li>
        <li class="nav-item">
            <a class="nav-link">Quản lý sản phẩm chi tiết</a>
        </li>
        <li class="nav-item">
            <a class="nav-link">Quản lý đơn hàng</a>
        </li>
    </ul>
</div>