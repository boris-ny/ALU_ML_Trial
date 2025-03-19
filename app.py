from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import pickle
import numpy as np
import uvicorn
import gdown

# Google Drive file ID
file_id = "1UvlAfE0nc_MWIDMt6NThw-50-vahDnO0"
output = "best_hydroponic_model.pkl"

# Download model if it doesn't exist
try:
    with open(output, "rb") as f:
        model = pickle.load(f)
except FileNotFoundError:
    print("Downloading model from Google Drive...")
    gdown.download(f"https://drive.google.com/uc?id={file_id}", output, quiet=False)
    with open(output, "rb") as f:
        model = pickle.load(f)

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

