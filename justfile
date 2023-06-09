dev:
	DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock" docker-compose -p "garden-app-dev" -f "docker-compose.dev.yml" up --build -d

deploy: 
	DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock" docker-compose up -d 

build:
	cd backend && podman build -t localhost/matmoa/garden-backend -f prod.Dockerfile .
	cd ..
	cd frontend && podman build -t localhost/matmoa/garden-frontend -f prod.Dockerfile .