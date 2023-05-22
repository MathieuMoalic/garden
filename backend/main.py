from fastapi import FastAPI 
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse

import json
from gpiozero import LED

pump = LED(17)

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
    pump.on()

@app.get("/api/pump-off")
async def pump_off():
    pump.off()

@app.get("/api/pump-status")
async def pump_off():
    return {"status":pump.is_lit}


@app.get("/api/cam")
async def get_cam():
    return FileResponse("./cam_shots/latest.jpeg")