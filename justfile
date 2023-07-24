set dotenv-load

dev: front-dev back-dev

clean:
    podman rm --force garden-frontend-dev garden-backend-dev garden-meilisearch-dev

code-server-dev:
    podman run -d --replace \
        --network proxy \
        --name garden-code-server \
        -v .:/home/coder/project:z \
        -v .dev/code-server/config:/root/.config/code-server:z \
        -v .dev/code-server/cache:/root/.local/share/code-server:z \
        -u "0:0" \
        -e "DOCKER_USER=root" \
        docker.io/codercom/code-server:latest \
        code-server --auth=none

front-dev:
    podman run -d --replace \
        --network proxy \
        --name garden-frontend-dev \
        -v ./frontend:/app:z \
        --workdir=/app \
        node:20.3.0-alpine3.18 \
        sh -c "npm i && npm run dev"

back-dev:
    podman run -d --replace \
        --network proxy \
        --name garden-backend-dev \
        -v ./backend:/app:z \
        -v .dev/backend:/data:z \
        -v .dev/ssh:/root/.ssh:z \
        -e GPIOZERO_PIN_FACTORY=pigpio \
        -e PIGPIO_ADDR=192.168.1.106 \
        --workdir=/app \
        python:3.11 \
        sh -c "pip install -r requirements.txt && uvicorn main:app --proxy-headers --host 0.0.0.0 --port 6001 --reload"

staging:
    podman build -t localhost/garden-staging:latest .

    podman network create garden-staging

    podman run -d \
        --name garden-meilisearch-staging \
        --network garden-staging \
        -e MEILI_MASTER_KEY=GUw5MX4OIu6kpPZp1DQQV-tsjud2Pjk5NcfNj0VQwLU \
        -e MEILI_ENV=production \
        -e MEILI_NO_ANALYTICS \
        docker.io/getmeili/meilisearch:v1.2.0

    podman run -d \
        --name garden-staging \
        --network proxy \
        --network garden-staging \
        --requires garden-meilisearch-staging \
        -e MEILI_URL=http://garden-meilisearch-staging:7700 \
        -e MEILI_KEY=GUw5MX4OIu6kpPZp1DQQV-tsjud2Pjk5NcfNj0VQwLU \
        localhost/garden-staging:latest


clean-staging:
    podman rm -f garden-staging 
    podman rm -f garden-meilisearch-staging
    podman network remove -f garden-staging
    podman image rm localhost/garden-staging:latest