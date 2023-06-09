FROM python:3.11
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 15001
ENV GPIOZERO_PIN_FACTORY=pigpio
ENV PIGPIO_ADDR=192.168.1.106
CMD ["uvicorn", "main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "15001", "--reload"]