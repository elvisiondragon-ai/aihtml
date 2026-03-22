#!/bin/bash
NUKE_SCRIPT="<script>
  const APP_VERSION = '2026.03.22.01';
  if (localStorage.getItem('v_cache') !== APP_VERSION) {
    if ('serviceWorker' in navigator) {
      navigator.serviceWorker.getRegistrations().then(regs => regs.forEach(r => r.unregister()));
    }
    caches.keys().then(names => Promise.all(names.map(name => caches.delete(name))));
    localStorage.setItem('v_cache', APP_VERSION);
    window.location.reload(true);
  }
</script>"

find . -name "*.html" -exec sed -i '' -e "/<head>/a\\
$NUKE_SCRIPT" {} +
