import os

# API Configuration
API_TITLE = "Hydroponic pH Prediction API"
API_DESCRIPTION = "This API predicts the optimal pH level for hydroponic farming based on key soil and environmental factors."
API_VERSION = "1.0.0"

# Server Configuration
HOST = "127.0.0.1"
PORT = int(os.getenv("PORT", 8000))

# Model Configuration
MODEL_PATH = "best_hydroponic_model.pkl"
