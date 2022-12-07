# radar-home

A page with RADAR links.

## Prerequisites

Node.js / npm — to fetch & prune the Tailwind CSS.

## Build and Deployment

To build locally, run
```
npm run build
```
The result is in the `dist` directory.

To build with Docker, run

```
docker buildx build --tag radarbase/radar-home:dev --load .
```

Then execute run it

```
docker run -p 8080:8080 radarbase/radar-home:dev
```

to start a container. View the resutlt on <http://localhost:8080>.
