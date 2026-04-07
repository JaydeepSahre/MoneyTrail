<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" data-theme="${not empty theme ? theme : 'dark'}">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Expenses — MoneyTrail</title>
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
            <li class="breadcrumb-item active">Expenses</li>
          </ol>
        </nav>
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
          <div>
            <h1 class="page-title"><i class="bi bi-arrow-up-circle-fill" style="color:var(--expense-color);"></i> Expenses</h1>
            <p class="page-subtitle">View, manage and track all your expense transactions</p>
          </div>
          <a href="${pageContext.request.contextPath}/addexpense" class="btn btn-danger">
            <i class="bi bi-plus-lg me-1"></i> Add Expense
          </a>
        </div>
      </div>

      <!-- Summary Strip -->
      <c:if test="${not empty expenseList}">
        <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:var(--sp-4);margin-bottom:var(--sp-5);">
          <div class="card" style="border-left:3px solid var(--expense-color);">
            <div class="card-body" style="padding:var(--sp-4);">
              <div style="font-size:var(--text-xs);font-weight:600;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.06em;">Total Expenses</div>
              <div style="font-size:var(--text-2xl);font-weight:700;color:var(--expense-color);font-family:var(--font-mono);margin-top:4px;">
                ₹<fmt:formatNumber value="${totalExpenseAmount}" pattern="#,##0.00"/>
              </div>
            </div>
          </div>
          <div class="card">
            <div class="card-body" style="padding:var(--sp-4);">
              <div style="font-size:var(--text-xs);font-weight:600;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.06em;">Transactions</div>
              <div style="font-size:var(--text-2xl);font-weight:700;color:var(--text-primary);margin-top:4px;">${expenseList.size()}</div>
            </div>
          </div>
          <div class="card">
            <div class="card-body" style="padding:var(--sp-4);">
              <div style="font-size:var(--text-xs);font-weight:600;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.06em;">Avg. Expense</div>
              <div style="font-size:var(--text-2xl);font-weight:700;color:var(--text-primary);font-family:var(--font-mono);margin-top:4px;">
                ₹<fmt:formatNumber value="${expenseList.size() > 0 ? totalExpenseAmount / expenseList.size() : 0}" pattern="#,##0.00"/>
              </div>
            </div>
          </div>
        </div>
      </c:if>

      <div class="card">
        <div class="card-header">
          <div class="card-title">
            All Expenses
            <span class="badge badge-neutral ms-2">${not empty expenseList ? expenseList.size() : 0}</span>
          </div>
          <div class="d-flex align-items-center gap-2 flex-wrap">
            <div class="search-box" style="min-width:220px;">
              <i class="bi bi-search" style="color:var(--text-muted);font-size:13px;"></i>
              <input type="text" placeholder="Search expenses..." oninput="filterTable(this.value,'expTable')">
            </div>
          </div>
        </div>
        <div class="card-body p-0">
          <c:choose>
            <c:when test="${empty expenseList}">
              <div class="empty-state">
                <div class="empty-state-icon" style="color:var(--expense-color);background:var(--danger-50);">
                  <i class="bi bi-arrow-up-circle-fill"></i>
                </div>
                <p class="empty-state-title">No expenses recorded</p>
                <p class="empty-state-desc">Start adding expenses to track your spending and gain financial insights.</p>
                <a href="${pageContext.request.contextPath}/addexpense" class="btn btn-danger mt-3">
                  <i class="bi bi-plus-lg me-1"></i> Add Expense
                </a>
              </div>
            </c:when>
            <c:otherwise>
              <div class="table-responsive">
                <table class="table" id="expTable">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>Description</th>
                      <th>Category</th>
                      <th>Vendor</th>
                      <th>Account</th>
                      <th>Date</th>
                      <th>Mode</th>
                      <th>Status</th>
                      <th>Amount</th>
                      <th class="text-center">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="exp" items="${expenseList}" varStatus="st">
                      <tr>
                        <td class="text-muted-color text-sm">${st.index + 1}</td>
                        <td>
                          <div class="fw-600 text-sm">${not empty exp.description ? exp.description : '—'}</div>
                          <div class="text-xs text-muted-color">${exp.subCategoryId != null ? subCategoryMap[exp.subCategoryId] : ''}</div>
                        </td>
                        <td>
                          <span class="badge badge-danger">${exp.categoryId != null ? categoryMap[exp.categoryId] : '—'}</span>
                        </td>
                        <td class="text-sm text-muted-color">${exp.vendorId != null ? vendorMap[exp.vendorId] : '—'}</td>
                        <td class="text-sm text-muted-color">${exp.accountId != null ? accountMap[exp.accountId] : '—'}</td>
                        <td>
                          <span class="text-sm" style="font-family:var(--font-mono);color:var(--text-secondary);">
                            ${exp.expenseDate.dayOfMonth} ${exp.expenseDate.month} ${exp.expenseDate.year}
                          </span>
                        </td>
                        <td>
                          <span class="badge badge-neutral">${not empty exp.paymentMode ? exp.paymentMode : '—'}</span>
                        </td>
                        <td>
                          <c:set var="status" value="${exp.statusId != null ? statusMap[exp.statusId] : null}" />
							<span class="badge 
							    ${status == 'Paid' ? 'badge-success badge-dot' 
							    : status == 'PartialPaid' ? 'badge-warning badge-dot' 
							    : status == 'Unpaid' ? 'badge-danger badge-dot' 
							    : 'badge-neutral badge-dot'}">
							
							    ${status != null ? status : '—'}
							</span>
                        </td>
                        <td>
                          <span class="fw-700 text-sm text-expense" style="font-family:var(--font-mono);">
                            −₹<fmt:formatNumber value="${exp.amount}" pattern="#,##0.00"/>
                          </span>
                        </td>
                        <td class="text-center">
                          <div class="action-btns">
                            <a href="${pageContext.request.contextPath}/editexpense?expenseId=${exp.expenseId}"
                               class="btn-icon edit" title="Edit">
                              <i class="bi bi-pencil"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/deleteexpense?expenseId=${exp.expenseId}"
                               class="btn-icon del" title="Delete"
                               onclick="return confirmDelete('expense #${exp.expenseId}')">
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
                <span class="text-sm text-muted-color">Showing ${expenseList.size()} expense(s)</span>
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
