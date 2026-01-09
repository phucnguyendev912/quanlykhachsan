<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản lý tài khoản</title>

<!-- Bootstrap -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    rel="stylesheet">

<!-- Font Awesome -->
<link
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    rel="stylesheet">

<style>
body {
    background-color: #f4f6f9;
}

.card {
    border-radius: 14px;
}

.table th {
    background-color: #f8f9fa;
    vertical-align: middle;
}

.badge-role {
    font-size: 0.85rem;
    padding: 6px 10px;
}
</style>
</head>

<body>

<div class="container mt-5">
    <div class="card shadow-sm">
        <div
            class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0">
                <i class="fa-solid fa-users-gear me-2"></i>Quản lý tài khoản
            </h5>

            <a href="account?action=add" class="btn btn-light btn-sm">
                <i class="fa-solid fa-plus"></i> Thêm tài khoản
            </a>
        </div>

        <div class="card-body">
            <table
                class="table table-bordered table-hover align-middle text-center">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên đăng nhập</th>
                        <th>Mật khẩu</th>
                        <th>Quyền</th>
                        <th>User ID</th>
                        <th>Hành động</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="a" items="${lstAccount}">
                        <tr>
                            <td>${a.accountId}</td>

                            <td class="fw-semibold">${a.accountName}</td>

                            <!-- Không hiển thị mật khẩu thật -->
                            <td>${a.password}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${a.role.roleId == 1}">
                                        <span class="badge bg-danger badge-role">Khách hàng</span>
                                    </c:when>
                                    <c:when test="${a.role.roleId == 2}">
                                        <span class="badge bg-warning text-dark badge-role">Admin</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success badge-role">KHÁCH HÀNG</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${a.user.userId}</td>

                            <td>
                                <a href="account?action=edit&id=${a.accountId}"
                                   class="btn btn-warning btn-sm me-1">
                                    <i class="fa-solid fa-pen"></i>
                                </a>

                                <a href="account?action=delete&id=${a.accountId}"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?')">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty lstAccount}">
                        <tr>
                            <td colspan="6" class="text-muted">
                                Không có dữ liệu tài khoản
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
