<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" data-theme="${not empty theme ? theme : 'dark'}">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Income — MoneyTrail</title>
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
            <li class="breadcrumb-item active">Income</li>
          </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
          <div>
            <h1 class="page-title"><i class="bi bi-arrow-down-circle-fill" style="color:var(--income-color);"></i> Income</h1>
            <p class="page-subtitle">View and manage all your income transactions</p>
          </div>
          <a href="${pageContext.request.contextPath}/addincome" class="btn btn-success">
            <i class="bi bi-plus-lg me-1"></i> Add Income
          </a>
        </div>
      </div>

      <!-- Summary Strip -->
      <c:if test="${not empty incomeList}">
        <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:var(--sp-4);margin-bottom:var(--sp-5);">
          <div class="card" style="border-left:3px solid var(--income-color);">
            <div class="card-body" style="padding:var(--sp-4);">
              <div style="font-size:var(--text-xs);font-weight:600;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.06em;">Total Income</div>
              <div style="font-size:var(--text-2xl);font-weight:700;color:var(--income-color);font-family:var(--font-mono);margin-top:4px;">
                ₹<fmt:formatNumber value="${totalIncomeAmount}" pattern="#,##0.00"/>
              </div>
            </div>
          </div>
          <div class="card">
            <div class="card-body" style="padding:var(--sp-4);">
              <div style="font-size:var(--text-xs);font-weight:600;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.06em;">Transactions</div>
              <div style="font-size:var(--text-2xl);font-weight:700;color:var(--text-primary);margin-top:4px;">${incomeList.size()}</div>
            </div>
          </div>
          <div class="card">
            <div class="card-body" style="padding:var(--sp-4);">
              <div style="font-size:var(--text-xs);font-weight:600;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.06em;">Avg. Income</div>
              <div style="font-size:var(--text-2xl);font-weight:700;color:var(--text-primary);font-family:var(--font-mono);margin-top:4px;">
                ₹<fmt:formatNumber value="${incomeList.size() > 0 ? totalIncomeAmount / incomeList.size() : 0}" pattern="#,##0.00"/>
              </div>
            </div>
          </div>
        </div>
      </c:if>

      <div class="card">
        <div class="card-header">
          <div class="card-title">
            All Income
            <span class="badge badge-neutral ms-2">${not empty incomeList ? incomeList.size() : 0}</span>
          </div>
          <div class="search-box" style="min-width:220px;">
            <i class="bi bi-search" style="color:var(--text-muted);font-size:13px;"></i>
            <input type="text" placeholder="Search income..." oninput="filterTable(this.value,'incTable')">
          </div>
        </div>
        <div class="card-body p-0">
          <c:choose>
            <c:when test="${empty incomeList}">
              <div class="empty-state">
                <div class="empty-state-icon" style="color:var(--income-color);background:var(--success-50);">
                  <i class="bi bi-arrow-down-circle-fill"></i>
                </div>
                <p class="empty-state-title">No income recorded</p>
                <p class="empty-state-desc">Add your income transactions to track earnings and build a complete financial picture.</p>
                <a href="${pageContext.request.contextPath}/addincome" class="btn btn-success mt-3">
                  <i class="bi bi-plus-lg me-1"></i> Add Income
                </a>
              </div>
            </c:when>
            <c:otherwise>
              <div class="table-responsive">
                <table class="table" id="incTable">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>Source</th>
                      <th>Account</th>
                      <th>Date</th>
                      <th>Mode</th>
                      <th>Status</th>
                      <th>Amount</th>
                      <th class="text-center">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="inc" items="${incomeList}" varStatus="st">
                      <tr>
                        <td class="text-muted-color text-sm">${st.index + 1}</td>
                        <td>
                          <div class="d-flex align-items-center gap-3">
                            <div class="vendor-initial" style="background:var(--success-50);color:var(--income-color);">
                              <i class="bi bi-arrow-down-circle-fill" style="font-size:14px;"></i>
                            </div>
                            <div class="fw-600 text-sm">${not empty inc.incomeSource ? inc.incomeSource : '—'}</div>
                          </div>
                        </td>
                        <td class="text-sm text-muted-color">${accountMap[inc.accountId] != null ? accountMap[inc.accountId] : '—'}</td>
                        <td>
                          <span class="text-sm" style="font-family:var(--font-mono);color:var(--text-secondary);">
                            ${inc.incomeDate.dayOfMonth} ${inc.incomeDate.month} ${inc.incomeDate.year}
                          </span>
                        </td>
                        <td>
                          <span class="badge badge-neutral">${not empty inc.paymentMode ? inc.paymentMode : '—'}</span>
                        </td>
                        <td>
                          <c:set var="status" value="${inc.statusId != null ? statusMap[inc.statusId] : null}" />

							<span class="badge 
							    ${status == 'Paid' ? 'badge-success badge-dot' 
							    : status == 'PartialPaid' ? 'badge-warning badge-dot' 
							    : status == 'Unpaid' ? 'badge-danger badge-dot' 
							    : 'badge-neutral badge-dot'}">
							
							    ${status != null ? status : '—'}
							</span>
                        </td>
                        <td>
                          <span class="fw-700 text-sm text-income" style="font-family:var(--font-mono);">
                            +₹<fmt:formatNumber value="${inc.amount}" pattern="#,##0.00"/>
                          </span>
                        </td>
                        <td class="text-center">
                          <div class="action-btns">
                            <a href="${pageContext.request.contextPath}/editincome?incomeId=${inc.incomeId}"
                               class="btn-icon edit" title="Edit">
                              <i class="bi bi-pencil"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/deleteincome?incomeId=${inc.incomeId}"
                               class="btn-icon del" title="Delete"
                               onclick="return confirmDelete('income #${inc.incomeId}')">
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
                <span class="text-sm text-muted-color">Showing ${incomeList.size()} income record(s)</span>
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
  return confirm('Delete ' + name + '? This cannot be undone.');
}
</script>
</body>
</html>
