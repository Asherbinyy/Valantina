'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "94ee238c8ec7d80132ac4245d988ba7e",
"version.json": "39bb5c51909051b09ca45350f75f9ddb",
"index.html": "1783fd50ef2744cc141926134dba8679",
"/": "1783fd50ef2744cc141926134dba8679",
"main.dart.js": "026290333c432cb4ef0dba1d39e4b9de",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/favicon.ico": "937ffb73d5f2d879e0bbed42e8dda13b",
"icons/apple-touch-icon.png": "bdcc0380dcb58ecfc57915150443e1e0",
"icons/icon-192.png": "65be2b145353b7e121da6918c124d239",
"icons/icon-192-maskable.png": "3a85480fd67e2ddfcff6487e70e60afb",
"icons/icon-512-maskable.png": "0b35b542bc7097e57fa15cb02396300f",
"icons/icon-512.png": "37370f2ddb7ecf6f333a91a7ee7685f0",
"manifest.json": "8a0811c9d5f23e42524ffa99af9de583",
"assets/NOTICES": "ffd22d307f6bce04fb94d1e00419a5b3",
"assets/FontManifest.json": "c56b840bae625f47c64fcf530431ead0",
"assets/AssetManifest.bin.json": "b8cb50167a9e083681609606b814d599",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "227f4d05ff69b304892641280b410f13",
"assets/fonts/MaterialIcons-Regular.otf": "9d9060650a1b76eb5ff3ad1b0c66005a",
"assets/assets/tiles/ground_small.png": "916c2660f1a8332a760077e7a25e6a38",
"assets/assets/tiles/ground_small_broken.png": "38caea2b360bbe665ad6a2679a269451",
"assets/assets/tiles/ground_broken.png": "461d49302dad746c6a401c305c382a7c",
"assets/assets/tiles/ground.png": "08344aae3ac8ef9b0542cd580661fd32",
"assets/assets/audio/win.ogg": "3f55b19605e43cbfcb316162eed07e2c",
"assets/assets/audio/music.ogg": "26f8cfaf7e4d3c2d2f212534f70592dc",
"assets/assets/audio/bonk.ogg": "a4e4adbca74fc6751f746a9b7b29891a",
"assets/assets/audio/jump.ogg": "fb8403a1e6b516d8b59543879b4fc90c",
"assets/assets/audio/all_hearts.ogg": "2571a7f694089c530ada1a4c0c6f1de3",
"assets/assets/audio/cutscene.ogg": "3c72451feefdd22bc5a2dd98b92f06ac",
"assets/assets/audio/celebrate.ogg": "7c79a653e6a104ea8b1d38f3127ae8b8",
"assets/assets/audio/heart.ogg": "67c1280c7ee58806e09e80900f157354",
"assets/assets/audio/click.ogg": "4ca9982997589cb0f2f823741545ef4f",
"assets/assets/sprites/flag.png": "4936acb19508b73a936c1110708bc78f",
"assets/assets/sprites/player_stand.png": "5eb8436eda853dd78f821707bcc0ac18",
"assets/assets/sprites/grass1.png": "eaec358fc580cc91227e3532f10814cc",
"assets/assets/sprites/heart_alt.png": "f0b1bcb9da518a38bf1552d8b0e0a189",
"assets/assets/sprites/grass2.png": "4ae5b4ea4a89bcecfacf1b6b1cc63999",
"assets/assets/sprites/heart_grey.png": "d087339d6e2f979f7ee7cd214ab0df89",
"assets/assets/sprites/door_top_left.png": "b0473b4b591dadb22f76217c7bca80b8",
"assets/assets/sprites/cactus.png": "18384bf35644adab2300aae310ba6ef0",
"assets/assets/sprites/player_walk.png": "8cae2cc33a0164c29645e91ebe7c6b30",
"assets/assets/sprites/mushroom_red.png": "df42ef4a1887d0513bfb2318b7512ff1",
"assets/assets/sprites/player_ready.png": "f750c39d46101776ae39a87296d5411e",
"assets/assets/sprites/heart.png": "be0e9471778c14bd20f3d34614005004",
"assets/assets/sprites/player_hurt.png": "202d8d367f6958d27de42bce4a89e0b9",
"assets/assets/sprites/mushroom_brown.png": "37328169486c35b37791b9c88ab57582",
"assets/assets/sprites/spikes_top.png": "24a1757932e57459ba3d91bd48d79049",
"assets/assets/sprites/door_top_right.png": "f135514f801fb3110fb74ffdc9d8c44e",
"assets/assets/sprites/bat2.png": "32272de1518ce71642a23f74f16e031d",
"assets/assets/sprites/spikes_bottom.png": "ce0474409a6380f77c0ca4f6d8fcbef1",
"assets/assets/sprites/bat1.png": "4fea30091064b83a849f238ef0dcf01b",
"assets/assets/sprites/player_jump.png": "bd2516f3ec38a2b89d92e57419d2c667",
"assets/assets/sprites/door_bottom_left.png": "34296775d2b3a8c854db8d7689d4d287",
"assets/assets/sprites/queen_stand.png": "0bbf88e24b75cdb27e275c115b863b4a",
"assets/assets/sprites/door_bottom_right.png": "333335e8b7bba64d0f947ce42c095f7d",
"assets/assets/fonts/VT323-Regular.ttf": "034de38c65e202c1cc838e7d014385fd",
"assets/assets/fonts/PressStart2P-Regular.ttf": "f98cd910425bf727bd54ce767a9b6884",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
