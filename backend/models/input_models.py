from pydantic import BaseModel, Field


class HydroponicInput(BaseModel):
    soil_ec: float = Field(..., ge=0.0, le=3.0,
                           description="Electrical Conductivity (dS/m), must be between 0 and 3")
    nitrogen: float = Field(..., ge=0.0, le=120.0,
                            description="Nitrogen content (ppm), must be between 0 and 120")
    phosphorus: float = Field(..., ge=0.0, le=80.0,
                              description="Phosphorus content (ppm), must be between 0 and 80")
    potassium: float = Field(..., ge=0.0, le=300.0,
                             description="Potassium content (ppm), must be between 0 and 300")
    moisture: float = Field(..., ge=0.0, le=80.0,
                            description="Moisture percentage, must be between 0 and 80")
    temperature: float = Field(..., ge=0.0, le=30.0,
                               description="Temperature (°C), must be between 0 and 30")
    crop: int = Field(..., ge=0, le=12, description="Encoded crop type (0-12)")
