<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-theme="${not empty theme ? theme : 'dark'}">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sub-Categories — MoneyTrail</title>
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
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/listcategory">Categories</a></li>
            <li class="breadcrumb-item active">Sub-Categories</li>
          </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
          <div>
            <h1 class="page-title"><i class="bi bi-diagram-3-fill"></i> Sub-Categories</h1>
            <p class="page-subtitle">Detailed sub-groupings under your main categories</p>
          </div>
          <a href="${pageContext.request.contextPath}/addsubcategory" class="btn btn-primary">
            <i class="bi bi-plus-lg me-1"></i> Add Sub-Category
          </a>
        </div>
      </div>

      <div class="card">
        <div class="card-header">
          <div class="card-title">
            All Sub-Categories
            <span class="badge badge-neutral ms-2">${not empty subCategoryList ? subCategoryList.size() : 0}</span>
          </div>
          <div class="search-box" style="min-width:240px;">
            <i class="bi bi-search" style="color:var(--text-muted);font-size:13px;"></i>
            <input type="text" placeholder="Search sub-categories..." oninput="filterTable(this.value,'scTable')">
          </div>
        </div>
        <div class="card-body p-0">
          <c:choose>
            <c:when test="${empty subCategoryList}">
              <div class="empty-state">
                <div class="empty-state-icon"><i class="bi bi-diagram-3"></i></div>
                <p class="empty-state-title">No sub-categories yet</p>
                <p class="empty-state-desc">Sub-categories provide deeper granularity under each category.</p>
                <a href="${pageContext.request.contextPath}/addsubcategory" class="btn btn-primary mt-3">
                  <i class="bi bi-plus-lg me-1"></i> Add Sub-Category
                </a>
              </div>
            </c:when>
            <c:otherwise>
              <div class="table-responsive">
                <table class="table" id="scTable">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>Sub-Category Name</th>
                      <th>Parent Category</th>
                      <th class="text-center">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="sc" items="${subCategoryList}" varStatus="st">
                      <tr>
                        <td class="text-muted-color text-sm">${st.index + 1}</td>
                        <td>
                          <div class="d-flex align-items-center gap-3">
                            <div class="vendor-initial" style="background:var(--warning-50);color:var(--warning-600);">
                              <i class="bi bi-diagram-3" style="font-size:14px;"></i>
                            </div>
                            <div>
                              <div class="fw-600 text-sm">${sc.subCategoryName}</div>
                              <div class="text-xs text-muted-color">ID: #${sc.subCategoryId}</div>
                            </div>
                          </div>
                        </td>
                        <td>
                          <span class="badge badge-primary">
						    ${categoryMap[sc.categoryId]}
						  </span>
                        </td>
                        <td class="text-center">
                          <div class="action-btns">
                            <a href="${pageContext.request.contextPath}/editsubcategory?subCategoryId=${sc.subCategoryId}"
                               class="btn-icon edit" title="Edit">
                              <i class="bi bi-pencil"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/deletesubcategory?subCategoryId=${sc.subCategoryId}"
                               class="btn-icon del" title="Delete"
                               onclick="return confirmDelete('${sc.subCategoryName}')">
                              <i class="bi bi-trash"></i>
                            </a>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
              <div class="d-flex align-items-center justify-content-between px-5 py-3" style="border-top:1px solid var(--border-color);">
                <span class="text-sm text-muted-color">Showing ${subCategoryList.size()} sub-categor${subCategoryList.size() == 1 ? 'y' : 'ies'}</span>
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
<script src="${pageContext.request.contextPath}/js/app.js"></script>
<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
<script src="${pageContext.request.contextPath}/js/theme-switcher.js"></script>
<script>
function filterTable(q, id) {
  document.querySelectorAll('#'+id+' tbody tr').forEach(r => {
    r.style.display = r.textContent.toLowerCase().includes(q.toLowerCase()) ? '' : 'none';
  });
}
function confirmDelete(name) {
  return confirm('Delete sub-category "' + name + '"? This cannot be undone.');
}
</script>
</body>
</html>
