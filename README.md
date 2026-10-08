# Guacamole HTTP RemoteApp

A containerized browser session that lets Apache Guacamole users open HTTP and HTTPS applications through an RDP connection. The container runs xRDP and starts Firefox in kiosk mode for each session.

This repository is an independent community project. It is not maintained or endorsed by the Apache Guacamole project.

## How it works

```text
Apache Guacamole / guacd
        │ RDP
        ▼
  RemoteApp container
  xRDP → isolated Firefox session
        │ HTTP or HTTPS
        ▼
   Web application
```

Each RDP session gets its own temporary Firefox profile. An optional browser extension can show a short connection screen, enforce a timeout, and fill a login form when credentials are explicitly supplied in the Guacamole connection parameters.

## Current status

This repository is being prepared for a reproducible build. The project is experimental; review the security notes and validate it in a test environment before using it with sensitive systems.

## Build and run

Requirements: Docker Engine with the Compose plugin.

1. Copy `.env.example` to `.env` and set a strong, unique `RDP_MASTER_PASSWORD`.
2. Build and start the container:

   ```sh
   docker compose up --build -d
   ```

3. For a local RDP client, connect to `127.0.0.1:3389`. For Guacamole, connect the `guacd` service and this container to a shared Docker network and use the container service name as the RDP hostname.

The Compose example binds RDP to loopback by default. Do not expose port 3389 to an untrusted network.

## Configuration

| Variable | Purpose | Default |
| --- | --- | --- |
| `RDP_MASTER_PASSWORD` | Shared password required by xRDP | Required |
| `DEFAULT_URL` | URL opened when the RDP connection does not provide one | `about:blank` |

See [docs/CONFIGURATION.md](docs/CONFIGURATION.md) for Guacamole connection setup and [docs/SECURITY.md](docs/SECURITY.md) for security considerations.

## Image distribution

The build workflow will first compile the image without publishing it. Once the source and release process are ready, versioned images can be published to Docker Hub for discovery and distribution.

## License

No license has been selected for this repository yet. Until one is added, all rights remain reserved.
