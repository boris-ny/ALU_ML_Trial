// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(HydroponicApp());
// }

// class HydroponicApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Hydroponic pH Predictor',
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: PredictionScreen(),
//     );
//   }
// }

// class PredictionScreen extends StatefulWidget {
//   @override
//   _PredictionScreenState createState() => _PredictionScreenState();
// }

// class _PredictionScreenState extends State<PredictionScreen> {
//   final TextEditingController soilEcController = TextEditingController();
//   final TextEditingController nitrogenController = TextEditingController();
//   final TextEditingController phosphorusController = TextEditingController();
//   final TextEditingController potassiumController = TextEditingController();
//   final TextEditingController moistureController = TextEditingController();
//   final TextEditingController temperatureController = TextEditingController();
//   final TextEditingController cropController = TextEditingController();

//   String predictionResult = "";
//   String suggestion = "";

//   Future<void> predictpH() async {
//     final url = Uri.parse("http://127.0.0.1:8000/predict");
//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "soil_ec": double.tryParse(soilEcController.text) ?? 0.0,
//         "nitrogen": double.tryParse(nitrogenController.text) ?? 0.0,
//         "phosphorus": double.tryParse(phosphorusController.text) ?? 0.0,
//         "potassium": double.tryParse(potassiumController.text) ?? 0.0,
//         "moisture": double.tryParse(moistureController.text) ?? 0.0,
//         "temperature": double.tryParse(temperatureController.text) ?? 0.0,
//         "crop": int.tryParse(cropController.text) ?? 0,
//       }),
//     );

//     if (response.statusCode == 200) {
//       double predictedPH = jsonDecode(response.body)["Predicted pH"];
//       setState(() {
//         predictionResult = "Predicted pH: " + predictedPH.toStringAsFixed(2);
        
//         // Provide suggestions based on pH range
//         if (predictedPH < 5.5) {
//           suggestion = "pH is too low. Consider adding lime (calcium carbonate) or increasing alkalinity using potassium bicarbonate.";
//         } else if (predictedPH > 7.0) {
//           suggestion = "pH is too high. Consider adding acidic nutrients like phosphoric acid or sulfur to lower the pH.";
//         } else {
//           suggestion = "pH is optimal for most crops. Maintain current nutrient balance.";
//         }
//       });
//     } else {
//       setState(() {
//         predictionResult = "Error: Unable to predict pH";
//         suggestion = "";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Hydroponic pH Predictor")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: soilEcController, decoration: InputDecoration(labelText: "Soil EC (dS/m)")),
//             TextField(controller: nitrogenController, decoration: InputDecoration(labelText: "Nitrogen (ppm)")),
//             TextField(controller: phosphorusController, decoration: InputDecoration(labelText: "Phosphorus (ppm)")),
//             TextField(controller: potassiumController, decoration: InputDecoration(labelText: "Potassium (ppm)")),
//             TextField(controller: moistureController, decoration: InputDecoration(labelText: "Moisture (%)")),
//             TextField(controller: temperatureController, decoration: InputDecoration(labelText: "Temperature (°C)")),
//             TextField(controller: cropController, decoration: InputDecoration(labelText: "Crop (Encoded)")),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: predictpH,
//               child: Text("Predict"),
//             ),
//             SizedBox(height: 20),
//             Text(
//               predictionResult,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               suggestion,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blueGrey),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(HydroponicApp());
}

class HydroponicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FarmSmart - Hydroponic pH Predictor',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/predict': (context) => PredictionScreen(),
      },
    );
  }
}


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensures compact spacing
          children: [
            Image.asset("assets/logo.png", height: 250), // Adjusted logo size
            SizedBox(height: 10), // Added space between logo and text
            Text(
              "Welcome to FarmSmart",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100, // Green bar at the top
            width: double.infinity,
            color: Colors.green,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10), // Moves the logo up slightly
                    Image.asset("assets/logo.png", height: 200),
                    SizedBox(height: 30),
                    Text(
                      "🌱 At FarmSmart, we are dedicated to revolutionizing agriculture with technology and data-driven insights.\n\n\n"
                          "💧 Our primary focus is hydroponic farming, which allows crops to grow without soil, using nutrient-rich water solutions to maximize yield and efficiency.\n\n\n"
                          "📊 This app helps you analyze and optimize pH levels for healthier crops and improved production.\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => Navigator.pushReplacementNamed(context, '/predict'),
                      child: Text("Proceed to Prediction"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final TextEditingController soilEcController = TextEditingController();
  final TextEditingController nitrogenController = TextEditingController();
  final TextEditingController phosphorusController = TextEditingController();
  final TextEditingController potassiumController = TextEditingController();
  final TextEditingController moistureController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();

  String predictionResult = "";
  String suggestion = "";

  int? selectedCrop;
  final Map<String, int> cropEncoding = {
    'Bell Pepper': 0, 'Bitter Gourd': 1, 'Carrot': 2, 'Corn': 3, 'Cucumber': 4,
    'Eggplant': 5, 'Green Chili': 6, 'Lettuce': 7, 'Mustard Greens': 8, 'Pechay': 9,
    'Squash': 10, 'Tomato': 11, 'Watermelon': 12
  };


  Future<void> predictpH() async {
    final url = Uri.parse("http://10.0.2.2:8000/predict");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "soil_ec": double.tryParse(soilEcController.text) ?? 0.0,
        "nitrogen": double.tryParse(nitrogenController.text) ?? 0.0,
        "phosphorus": double.tryParse(phosphorusController.text) ?? 0.0,
        "potassium": double.tryParse(potassiumController.text) ?? 0.0,
        "moisture": double.tryParse(moistureController.text) ?? 0.0,
        "temperature": double.tryParse(temperatureController.text) ?? 0.0,
        "crop": selectedCrop ?? 0,
      }),
    );

    if (response.statusCode == 200) {
      double predictedPH = jsonDecode(response.body)["Predicted pH"];
      setState(() {
        predictionResult = "Predicted pH: " + predictedPH.toStringAsFixed(2);
        
        // Provide suggestions based on pH range
        if (predictedPH < 5.5) {
          suggestion = "pH is too low. Consider adding lime (calcium carbonate) or increasing alkalinity using potassium bicarbonate.";
        } else if (predictedPH > 7.0) {
          suggestion = "pH is too high. Consider adding acidic nutrients like phosphoric acid or sulfur to lower the pH.";
        } else {
          suggestion = "pH is optimal for your crops. Maintain current nutrient balance.";
        }
      });
    } else {
      setState(() {
        predictionResult = "Error: Unable to predict pH";
        suggestion = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100, // Color bar at the top
            width: double.infinity,
            color: Colors.green,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pushReplacementNamed(context, '/welcome'),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Back to Home",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📊 Please enter the required parameters to predict the pH level in your hydroponic system.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  TextField(controller: soilEcController, decoration: InputDecoration(labelText: "Soil EC (dS/m)", border: OutlineInputBorder())),
                  SizedBox(height: 10),
                  TextField(controller: nitrogenController, decoration: InputDecoration(labelText: "Nitrogen (ppm)", border: OutlineInputBorder())),
                  SizedBox(height: 10),
                  TextField(controller: phosphorusController, decoration: InputDecoration(labelText: "Phosphorus (ppm)", border: OutlineInputBorder())),
                  SizedBox(height: 10),
                  TextField(controller: potassiumController, decoration: InputDecoration(labelText: "Potassium (ppm)", border: OutlineInputBorder())),
                  SizedBox(height: 10),
                  TextField(controller: moistureController, decoration: InputDecoration(labelText: "Moisture (%)", border: OutlineInputBorder())),
                  SizedBox(height: 10),
                  TextField(controller: temperatureController, decoration: InputDecoration(labelText: "Temperature (°C)", border: OutlineInputBorder())),
                  SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    value: selectedCrop,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCrop = newValue;
                      });
                    },
                    items: cropEncoding.entries.map((entry) {
                      return DropdownMenuItem<int>(
                        value: entry.value,
                        child: Text("${entry.key}"),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: "Select Crop",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onPressed: predictpH,
                      child: Text("Predict"),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      predictionResult,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      suggestion,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
