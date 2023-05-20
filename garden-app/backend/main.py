from fastapi import FastAPI 
from fastapi.middleware.cors import CORSMiddleware
import json
from gpiozero import LED

pump = LED(17)

app = FastAPI(title="Garden API")

DB_PATH = "db/dev.db"
with open(DB_PATH, "w") as fp:
    json.dump([
        {'name':'Tomato', 'active':True, 'category':'vegetable', 'emoji':''},
        ],fp)

with open(DB_PATH,"r") as f:
    db = json.load(f)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"], 
    allow_headers=["*"],
)

def save():
    with open(DB_PATH, "w") as fp:
        json.dump(db, fp)

@app.get("/api/pump-on")
async def pump_on():
    pump.on()

@app.get("/api/pump-off")
async def pump_off():
    pump.off()

@app.get("/api/pump-status")
async def pump_off():
    return {"status":pump.is_lit}