const CACHE_NAME = "controle-gastos-cloud-conta-paga-v2";
const FILES = ["./", "./index.html", "./manifest.json", "./icon.svg", "./supabase-config.js"];

self.addEventListener("install", event => {
  event.waitUntil(caches.open(CACHE_NAME).then(cache => cache.addAll(FILES)));
  self.skipWaiting();
});

self.addEventListener("activate", event => {
  event.waitUntil(self.clients.claim());
});

self.addEventListener("fetch", event => {
  event.respondWith(
    caches.match(event.request).then(resp => resp || fetch(event.request))
  );
});
