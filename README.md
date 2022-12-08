# radar-home

A page with RADAR links. It is released as docker image [radarbase/radar-home](https://hub.docker.com/r/radarbase/radar-home).

## Configuration

This Docker image describes a number of components. The component name acts as a prefix for supported environment variables. A component has variables `<COMPONENT>_ENABLED` and `<COMPONENT>_URL`. The former describes whether to enable a given block, and the second what the URL to the component is. Both need to be set for the component to be rendered.

| Components | Description |
|---|---|
| `S3` | Data download portal, usually Minio. |
| `DASHBOARD` | Compliance dashboard, usually Grafana. |
| `UPLOAD_PORTAL` | Upload portal used for the upload source connector. |
| `REST_AUTHORIZER` | REST source authorizer, for Fitbit and Garmin authorization. |
| `MONITOR` | The monitoring stack, usually Prometheus. |
| `GRAYLOG` | System logs, usually from graylog. |

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
