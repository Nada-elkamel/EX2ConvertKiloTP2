import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _convertedResult = ''; // Store the converted result.
  String _startMeasure = 'meters'; // Default source unit.
  String _convertedMeasure = 'kilometers'; // Default target unit.
  double _inputValue = 0.0; // Store the user's input value.

  // Conversion factors for different units.
  final Map<String, double> _unitConversion = {
    'meters': 1,
    'kilometers': 0.001,
    'grams': 1,
    'kilograms': 0.001,
    'feet': 3.28084,
    'miles': 0.000621371,
    'pounds (lbs)': 0.00220462,
    'ounces': 35.274,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Measures Converter'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter a value',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _inputValue = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton(
                      value: _startMeasure,
                      items: _unitConversion.keys.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _startMeasure = value.toString();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButton(
                      value: _convertedMeasure,
                      items: _unitConversion.keys.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _convertedMeasure = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  double conversionFactor =
                      _unitConversion[_convertedMeasure]! /
                          _unitConversion[_startMeasure]!;
                  setState(() {
                    _convertedResult =
                        (_inputValue * conversionFactor).toStringAsFixed(2);
                  });
                },
                child: Text('Convert'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Result: $_convertedResult',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
