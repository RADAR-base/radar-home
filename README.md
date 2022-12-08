# radar-home

A page with RADAR links. It is released as docker image [radarbase/radar-home](https://hub.docker.com/r/radarbase/radar-home).

## Configuration

The Docker image has the following environment variables:

| Environment variable | Description |
|---|---|
| `S3_ENABLED` | Enable link to S3 download. Any non-empty value will enable the link to S3. |
| `S3_URL` | URL to download data. A link to will only be created if this value is set. |
| `DASHBOARD_ENABLED` | Enable link to the Grafana dashboard. Any non-empty value will enable the link to the dashboard. |
| `DASHBOARD_URL` | URL to the Grafana dashboard. A link will only be created if this value is set. |
| `UPLOAD_PORTAL_ENABLED` | Enable link to the data upload portal. Any non-empty value will enable the link to the upload portal. |
| `REST_AUTHORIZER_ENABLED` | Enable link to the REST source authorizer, for Fitbit and Garmin data. Any non-empty value will enable the link to the REST authorizer. |

Run

```
docker run -p 8080:8080 radarbase/radar-home:dev
```

to start a container. View the resutlt on <http://localhost:8080>.

## Development

This section describes the development of this repository.

### Prerequisites

Node.js / npm — to fetch & prune the Tailwind CSS.

### Build

To build locally, run
```
npm install
npm run build
```
The result is in the `dist` directory.

To build with Docker, run

```
docker buildx build --tag radarbase/radar-home:dev --load .
```

### Code

The code is an HTML page in `src/index.html`. Some postprocessing is done to that page by `docker/30-env-subst.sh`, which causes all lines with `<!-- [COMPONENT]_BEGIN -->` and `<!-- [COMPONENT]_END -->` to be removed when the site is loaded via Docker. If the component is disabled, the block will be removed from the HTML, otherwise it is visible.

### Release management

To create a new release, create a tag with message. This can be done on the command-line with `git tag -a` or via the Github website. The tag should use format `vX.X.X` with a semantic versioning scheme. A docker image and a Github release are then created by the Github Actions in this repository.
