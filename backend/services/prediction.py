import pickle
import numpy as np
from config import MODEL_PATH


class PredictionService:
    def __init__(self):
        self.model = None
        self.load_model()

    def load_model(self):
        """Load the pre-trained model from disk"""
        try:
            with open(MODEL_PATH, "rb") as file:
                self.model = pickle.load(file)
        except Exception as e:
            raise RuntimeError(f"Failed to load model: {str(e)}")

    def predict(self, soil_ec, nitrogen, phosphorus, potassium, moisture, temperature, crop):
        """Make a pH prediction based on input features"""
        if self.model is None:
            raise RuntimeError("Model not loaded")

        input_data = np.array([[
            soil_ec, nitrogen, phosphorus, potassium,
            moisture, temperature, crop
        ]])

        prediction = self.model.predict(input_data)[0]
        return prediction
