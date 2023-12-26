'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "ab6cc9d108d764179b5ae6aed33eb19d",
"assets/AssetManifest.bin.json": "8755c98ecfc8e90b02a68da52849af02",
"assets/AssetManifest.json": "e392bf0d6bd15c6b7094baf3e6425dd2",
"assets/assets/animation/data.json": "a9a164b9c34c0a8d9316e583e7745d2f",
"assets/assets/images/30590337_7692756%2520(1).svg": "b6b4ee7c38d4de3f54d41904b208602e",
"assets/assets/images/9558306_4164050.svg": "5ce26dbe301e542ffbf71563d1a479a3",
"assets/assets/images/basil-home-outline.svg": "45ff43efb3b3201b4f4f79eaf4aad80a",
"assets/assets/images/basil-home-solid.svg": "3960c2fbf227569c25564ab898aaa30b",
"assets/assets/images/capture.PNG": "fb3f1138b9f883554a1c27c42eb853bc",
"assets/assets/images/cartoon.png": "a1996734ac5775cb3579758bdfad9963",
"assets/assets/images/dashboard.svg": "778d8fab15cf4945411e21a9717bda4f",
"assets/assets/images/dashboard1.png": "f061aef041509fb2996fa42b4dfdf334",
"assets/assets/images/dashicons-email-alt-2.svg": "65cd9a4b1af86a2b337d13a2e9559ab7",
"assets/assets/images/ellipse-117.jpg": "a1937befd22484b617bfbf31007a6cf5",
"assets/assets/images/ep-lock.svg": "5afb37cd0d5762d4834d23ee258c31ba",
"assets/assets/images/fluent-people-28-filled.png": "774dac4afb205b457befcb648fe52cdd",
"assets/assets/images/fluent-phone-chat-20-regular.svg": "3ad3880e4450874653ed079658ca0656",
"assets/assets/images/Hair-pulling%2520disorder-cuate.svg": "8aaec994896d2ad0d1a4ce7d9e16b759",
"assets/assets/images/heroicons-user-20-solid.svg": "1b4545a504a002f5b240f7c1f26f4c6f",
"assets/assets/images/heroicons-user.svg": "9ff753f5c7db11fa311389c62d18b2ac",
"assets/assets/images/ic-dropoff.png": "39f1a71f3beb8aa8373cdfd2d44b9e75",
"assets/assets/images/ic-pick.png": "3f62c0570391be99d1cddba135d1776a",
"assets/assets/images/icomoon-free-book.svg": "93504514ba163173ca127dabdf333504",
"assets/assets/images/icon-park-outline-comb.svg": "822f7ba616a53a8999013f47bd532eeb",
"assets/assets/images/iconamoon-exit-light.png": "b24c29e71dd0bee64dd1dc839405bb33",
"assets/assets/images/image-3.png": "b0122d7adf7d2023a1aba25c9d1eef28",
"assets/assets/images/image3.png": "b0122d7adf7d2023a1aba25c9d1eef28",
"assets/assets/images/imagex.png": "e3bc07a33c35b1cbb25840a112b8df98",
"assets/assets/images/ion-card.png": "f106d395a09093a5c1d5d50292b88994",
"assets/assets/images/lucide-layout-dashboard.png": "a8dc51b39a840b0152e1657bdb793a19",
"assets/assets/images/mdi-security-lock-outline.svg": "54261256082a5add740d79cf4bfa9110",
"assets/assets/images/memoji-boys-5231.png": "0c64d315c0295c44d85beccfbc39b5da",
"assets/assets/images/mingcute-check-2-line.svg": "89e4cb6abb415f7096adfa1092f8ced1",
"assets/assets/images/mingcute-transfer-line.png": "3466eed5e4de88b95d6173374ed94453",
"assets/assets/images/mingcute-transfer-line.svg": "b789bb81091e1c3c277e0f8734698c09",
"assets/assets/images/portrait-of-young-woman-smiling-isolated.png": "6a7fb27925dc1fe94e365bcfe3a758e3",
"assets/assets/images/rectangle-1031.png": "174f3bcec774d24c6e8beef6841a4d85",
"assets/assets/images/rectangle-1041.jpg": "78d83412c90fe157545dff42a3182a28",
"assets/assets/images/rectangle-1042.png": "3d130cca800e15072f8c4a187966eba7",
"assets/assets/images/rectangle-1047.png": "224244b1c43ef4306348a42d7cf0538d",
"assets/assets/images/solar-bill-check-linear.png": "550a694a73093c0c4d9128b69679381b",
"assets/assets/images/solar-shop-minimalistic-bold.svg": "4354de7af7371a85d2d0348257287617",
"assets/assets/images/solar-shop-minimalistic-linear.svg": "cd6bc61a9a12fe7697606a3725bbde4e",
"assets/assets/images/vector.png": "710c564d22b7fafacb0d5c47ce8561c1",
"assets/FontManifest.json": "3ec1f5d77db05c5912915831d5df9c61",
"assets/fonts/MaterialIcons-Regular.otf": "e18f471bde3be970a13006fbd032f0f9",
"assets/NOTICES": "d8d696e8e1e44cf92596e63f07feb62b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "f25e8e701660fb45e2a81ff3f43c6d5c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "70fcba3bb297735dd659f9911cfd717e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "8b3edd3f4e8b602cd5b56617a1de2dd5",
"assets/packages/ionicons/assets/fonts/Ionicons.ttf": "757f33cf07178f986e73b03f8c195bd6",
"assets/packages/line_icons/lib/assets/fonts/LineIcons.ttf": "bcaf3ba974cf7900b3c158ca593f4971",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/twaOma.png": "aec5ae2e054154b7e8b0ffbdd49bfc7c",
"index.html": "ce62a50a5e8d26f73a4667301291b433",
"/": "ce62a50a5e8d26f73a4667301291b433",
"main.dart.js": "e0710d3a3f59a64987fb1a2bedee45a5",
"manifest.json": "3c4e67e6c69a0659d2ce69feffe9d612",
"splash/img/dark-1x.png": "6c00c43ddad4dd5afa8687bc95ed2354",
"splash/img/dark-2x.png": "a759ee138d3153b742ce18f43a6f7cd9",
"splash/img/dark-3x.png": "7908fd0ade2209c323fce00b27db7af2",
"splash/img/dark-4x.png": "d059b93b43bfa24637752b139762ad2e",
"splash/img/light-1x.png": "6c00c43ddad4dd5afa8687bc95ed2354",
"splash/img/light-2x.png": "a759ee138d3153b742ce18f43a6f7cd9",
"splash/img/light-3x.png": "7908fd0ade2209c323fce00b27db7af2",
"splash/img/light-4x.png": "d059b93b43bfa24637752b139762ad2e",
"twaOma.png": "aec5ae2e054154b7e8b0ffbdd49bfc7c",
"version.json": "3dc7801fac839b5d07a64a61c4eed406"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
