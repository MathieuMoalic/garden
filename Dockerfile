FROM python:3.11
WORKDIR /app
RUN pip install --no-cache-dir gpiozero pigpio
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /bin
ENV GPIOZERO_PIN_FACTORY=pigpio
ENV PIGPIO_ADDR=192.168.1.106