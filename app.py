from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import pickle
import numpy as np
import uvicorn

# Load the best-performing model
with open("best_hydroponic_model.pkl", "rb") as file:
    model = pickle.load(file)

# Initialize FastAPI application
app = FastAPI(title="Hydroponic pH Prediction API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],  # Allow all HTTP methods including OPTIONS
    allow_headers=["*"],
)
# Define input data model
class HydroponicInput(BaseModel):
    soil_ec: float
    nitrogen: float
    phosphorus: float
    potassium: float
    moisture: float
    temperature: float
    crop: int  # Encoded crop type

# Handle CORS preflight requests explicitly
@app.options("/predict")
async def preflight():
    return {"message": "OK"}

# Define prediction endpoint
@app.post("/predict")
async def predict(data: HydroponicInput):
    input_data = np.array([[  # Convert input to numpy array
        data.soil_ec, data.nitrogen, data.phosphorus,
        data.potassium, data.moisture, data.temperature, data.crop
    ]])
    prediction = model.predict(input_data)[0]  # Make prediction
    return {"Predicted pH": prediction}

# Run API (for local development)
if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)

