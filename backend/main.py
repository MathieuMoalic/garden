from pathlib import Path
import json
import os
import datetime
import subprocess

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
import gpiozero

p = gpiozero.DigitalOutputDevice(17)
print(p.value)
p.off()
print(p.value)


class Pump:
    def __init__(self):
        self.status = None

    def run_command(self, command: str):
        result = subprocess.run(
            command,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )
        if result.stderr != "":
            print("Got an error:")
            print(result.stderr)
        else:
            return result.stdout.strip()

    def turn_on(self):
        command = (
            """ssh rpi 'python -c "import gpiozero; print(gpiozero.LED(17).on())"'"""
        )
        self.run_command(command)

    def turn_off(self):
        command = (
            """ssh rpi 'python -c "import gpiozero; print(gpiozero.LED(17).off())"'"""
        )
        self.run_command(command)

    def get_status(self):
        command = (
            """ssh rpi 'python -c "import gpiozero; print(gpiozero.LED(17).is_lit)"'"""
        )
        res = self.run_command(command)
        if res == "False":
            status = "off"
        else:
            status = "on"
        return status

    def keep_history(self):
        current_datetime = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        db["history"].append(f"{current_datetime}: Pump turned {self.status}")


DB_PATH = Path("/data/db.json")


def init_db():
    db = {"history": []}
    DB_PATH.parent.mkdir(parents=True, exist_ok=True)
    with open(DB_PATH, "w") as fp:
        json.dump(db, fp)


if not os.path.exists(DB_PATH):
    init_db()


with open(DB_PATH, "r") as f:
    db = json.load(f)


pump = Pump()

app = FastAPI(title="Garden API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/api/pump-on")
async def pump_on():
    pump.turn_on()


@app.get("/api/pump-off")
async def pump_off():
    pump.turn_off()


@app.get("/api/pump-status")
async def pump_status():
    return {"status": pump.get_status()}


@app.get("/api/cam")
async def get_cam():
    return FileResponse("./cam_shots/latest.jpeg")


@app.get("/api/history")
async def get_history():
    return db["history"]
