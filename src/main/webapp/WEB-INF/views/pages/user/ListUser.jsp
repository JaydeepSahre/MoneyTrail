<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="${not empty theme ? theme : 'dark'}">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Users — MoneyTrail</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-icons.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css">
</head>
<body>
<div class="sidebar-backdrop" id="sidebarBackdrop"></div>
<div class="app-wrapper">
  <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>
  <div class="main-area">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
    <main class="page-content">

      <jsp:include page="/WEB-INF/views/components/alert.jsp"/>

      <div class="page-header">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"><i class="bi bi-house"></i></a></li>
            <li class="breadcrumb-item active">Users</li>
          </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
          <div>
            <h1 class="page-title"><i class="bi bi-people-fill"></i> Users</h1>
            <p class="page-subtitle">Manage platform users and their access roles</p>
          </div>
        </div>
      </div>

      <div class="card">
        <div class="card-header">
          <div class="card-title">
            All Users
            <span class="badge badge-neutral ms-2">${not empty userList ? userList.size() : 0}</span>
          </div>
          <div class="search-box" style="min-width:240px;">
            <i class="bi bi-search" style="color:var(--text-muted);font-size:13px;"></i>
            <input type="text" placeholder="Search users..." oninput="filterTable(this.value,'userTable')">
          </div>
        </div>
        <div class="card-body p-0">
          <c:choose>
            <c:when test="${empty userList}">
              <div class="empty-state">
                <div class="empty-state-icon"><i class="bi bi-people"></i></div>
                <p class="empty-state-title">No users found</p>
                <p class="empty-state-desc">Users who sign up will appear here.</p>
              </div>
            </c:when>
            <c:otherwise>
              <div class="table-responsive">
                <table class="table" id="userTable">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>User</th>
                      <th>Email</th>
                      <th>Role</th>
                      <th>Status</th>
                      <th class="text-center">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="u" items="${userList}" varStatus="st">
                      <tr>
                        <td class="text-muted-color text-sm">${st.index + 1}</td>
                        <td>
                          <div class="d-flex align-items-center gap-3">
                            <div class="vendor-initial" style="background:linear-gradient(135deg,var(--brand-400),var(--accent-500));color:#fff;">
                              ${not empty u.firstName ? u.firstName.substring(0,1).toUpperCase() : 'U'}
                            </div>
                            <div>
                              <div class="fw-600 text-sm">${u.firstName}</div>
                              <div class="text-xs text-muted-color">ID: #${u.userId}</div>
                            </div>
                          </div>
                        </td>
                        <td class="text-sm text-muted-color">${u.email}</td>
                        <td>
                          <span class="badge ${u.role == 'ADMIN' ? 'badge-accent' : 'badge-neutral'}">${u.role}</span>
                        </td>
                        <td>
                          <span class="badge ${u.active ? 'badge-success badge-dot' : 'badge-danger badge-dot'}">
                            ${u.active ? 'Active' : 'Inactive'}
                          </span>
                        </td>
                        <td class="text-center">
                          <div class="action-btns">
                            <a href="${pageContext.request.contextPath}/viewuser?userId=${u.userId}"
                               class="btn-icon edit" title="View User">
                              <i class="bi bi-eye"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/deleteuser?userId=${u.userId}"
                               class="btn-icon del" title="Delete"
                               onclick="return confirmDelete('${u.firstName}')">
                              <i class="bi bi-trash"></i>
                            </a>
					        <button 
							  class="btn-icon toggle-user-btn"
							  data-user-id="${u.userId}"
							  data-user-name="${u.firstName}"
							  data-active="${u.active}"
							  title="${u.active ? 'Deactivate' : 'Activate'}">
							
							  <i class="bi bi-${u.active ? 'person-dash' : 'person-check'}"></i>
							</button>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
              <div class="d-flex align-items-center justify-content-between px-5 py-3" style="border-top:1px solid var(--border-color);">
                <span class="text-sm text-muted-color">Showing ${userList.size()} user(s)</span>
                <div class="pagination">
                  <button class="page-btn" disabled><i class="bi bi-chevron-left"></i></button>
                  <button class="page-btn active">1</button>
                  <button class="page-btn" disabled><i class="bi bi-chevron-right"></i></button>
                </div>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

    </main>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
  </div>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
<script>const contextPath = '${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
<script src="${pageContext.request.contextPath}/js/theme-switcher.js"></script>
<script>
function filterTable(q, id) {
  document.querySelectorAll('#'+id+' tbody tr').forEach(r => {
    r.style.display = r.textContent.toLowerCase().includes(q.toLowerCase()) ? '' : 'none';
  });
}
</script>
</body>
</html>
