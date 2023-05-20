deploy: build
    podman run -dt --replace -v .:/app --name=garden localhost/matmoa/garden:latest

run:
    podman run -it --rm -v .:/app localhost/matmoa/garden:latest bash

build:
    podman build -t localhost/matmoa/garden .
    
pump-on:
    podman run --rm -v .:/app --name=garden-pump-on  localhost/matmoa/garden:latest python3 pump-on.py

pump-off:
    podman run --rm -v .:/app --name=garden-pump-off localhost/matmoa/garden:latest python3 pump-off.py