Simple Model Context Protocol server for setting Vikunja reminders. Make sure to configure environment variables in .env

## Publish to Docker Hub

> Build the container locally, tag it with your Docker Hub username, and push.

1. Sign in to Docker Hub and create an empty repository
   **Name:** `mcp-vikunja`
   **Visibility:** *public* (or *private* if you have a paid plan).

2. Populate `.env` (or `.env.local`) with valid Vikunja tokens before you run.

3. Build, tag, and push:

```bash
# export once per shell
export DOCKER_USER=your_dockerhub_user
export DOCKER_TAG=latest               # or 1.0.0 …

make login           # docker login
make push            # builds + pushes $DOCKER_USER/mcp-vikunja:$DOCKER_TAG
```

4. In **`homelab-infra/stacks/librechat/docker-compose.yml`**
   change the service image to the one you just pushed:

```yaml
mcp-vikunja:
  image: ${DOCKER_USER}/mcp-vikunja:${DOCKER_TAG:-latest}
  …
```

5. Redeploy:

```bash
cd homelab-infra
make deploy-librechat-compose
```

LibreChat will pull your image and the new **vikunja** tools will appear in the UI.