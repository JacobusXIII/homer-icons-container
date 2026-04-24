# Homer icons container

## Overview

Serves the [NX211/homer-icons](https://github.com/NX211/homer-icons) pack from your own host so you can use stable icon URLs in any dashboard (Homer, Heimdall, Glance, etc.) instead of hotlinking GitHub.

## Run

Run these from the repository root.

```bash
docker build -t homer-icons .
docker rm -f homer-icons 2>/dev/null || true
docker run -d --name homer-icons -p 8080:8080 \
  -e BASE_URL="/homer-icons/" \
  -e UPDATE_ON_STARTUP=false \
  --restart unless-stopped homer-icons
````

Open [http://localhost:8080/](http://localhost:8080/).

## Environment Variables

* `BASE_URL`: sets the public base path/domain used for icon links (both the URL copied on click and the icon file URLs in the page).

  * default `""`: auto-detect from current browser URL (reverse-proxy friendly)
  * `/`: copied icon URLs point to root
  * `/some/path/`: copied icon URLs use that subpath
  * `https://icons.example.com/icons/`: copied icon URLs use absolute URL
* `UPDATE_ON_STARTUP`: if set to `true`, container startup fetches latest `NX211/homer-icons` before serving.

  * default `false`: startup does not fetch and serves icons bundled in the image

## Refresh icons and regenerate the gallery

```bash
docker exec homer-icons update-icons.sh
```

## Use the index

* Open the site in your browser.
* Search to filter the grid by name or path; suggestions appear as you type.
* Click an icon to copy its URL to the clipboard, then paste it into your dashboard’s icon field.

