<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- ================= HEADER ================= -->
<div class="header">
    <h5 class="mb-0">Dashboard Overview</h5>
    <div class="d-flex align-items-center gap-2">
        <span>Welcome, <strong>${sessionScope.user.firstName}</strong></span>
        <c:if
						test="${not empty sessionScope.user.profilePicURL}">
						<img src="${sessionScope.user.profilePicURL}" alt="profile" class="rounded-circle" />

					</c:if> <c:if test="${empty sessionScope.user.profilePicURL}">
						<img src="https://via.placeholder.com/40" class="rounded-circle" />
					</c:if>
    </div>
</div>