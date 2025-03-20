from fastapi import APIRouter, Depends
from models.input_models import HydroponicInput
from services.prediction import PredictionService

router = APIRouter()
prediction_service = PredictionService()


@router.options("/predict")
async def preflight():
    """Handle CORS preflight requests"""
    return {"message": "OK"}


@router.post("/predict")
async def predict(data: HydroponicInput):
    """Predict optimal pH level based on input data"""
    prediction = prediction_service.predict(
        data.soil_ec,
        data.nitrogen,
        data.phosphorus,
        data.potassium,
        data.moisture,
        data.temperature,
        data.crop
    )

    return {"Predicted pH": prediction}
