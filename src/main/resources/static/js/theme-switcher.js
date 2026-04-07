document.addEventListener('DOMContentLoaded', () => {
  const btns = document.querySelectorAll('[data-theme-toggle]');

  function setTheme(theme) {
    document.documentElement.dataset.theme = theme;
    localStorage.setItem('theme', theme); // persist
  }

  function toggleTheme() {
    const current = document.documentElement.dataset.theme || 'light';
    const next = current === 'light' ? 'dark' : 'light';
    setTheme(next);
  }

  function syncIcons(theme) {
    btns.forEach(btn => {
      const sunIcon  = btn.querySelector('[data-icon="sun"]');
      const moonIcon = btn.querySelector('[data-icon="moon"]');

      if (sunIcon)  sunIcon.style.display  = theme === 'dark'  ? '' : 'none';
      if (moonIcon) moonIcon.style.display = theme === 'light' ? '' : 'none';
    });
  }

  // Attach click
  btns.forEach(btn => {
    btn.addEventListener('click', toggleTheme);
  });

  // Observe changes
  const observer = new MutationObserver(() => {
    syncIcons(document.documentElement.dataset.theme || 'light');
  });

  observer.observe(document.documentElement, {
    attributes: true,
    attributeFilter: ['data-theme']
  });

  // Load saved theme
  const saved = localStorage.getItem('theme') || 'light';
  setTheme(saved);
  syncIcons(saved);
});