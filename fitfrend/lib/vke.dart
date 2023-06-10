import 'package:flutter/material.dart';

class BodyMassIndexCalculator extends StatefulWidget {
  @override
  _BodyMassIndexCalculatorState createState() => _BodyMassIndexCalculatorState();
}

class _BodyMassIndexCalculatorState extends State<BodyMassIndexCalculator> {
  double weight = 0;
  double height = 0;
  double bmi = 0;
  int age = 0;
  Gender selectedGender = Gender.male;
  double bodyFatPercentage = 0;
  double leanBodyMass = 0;
  double basalMetabolicRate = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Vücut Kitle Endeksi Hesaplayıcı',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Kilo (kg)',
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              weight = double.tryParse(value) ?? 0;
            });
          },
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: 'Boy (cm)',
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              height = double.tryParse(value) ?? 0;
            });
          },
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            labelText: 'Yaş',
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              age = int.tryParse(value) ?? 0;
            });
          },
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value: Gender.male,
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value as Gender;
                });
              },
            ),
            Text('Erkek'),
            Radio(
              value: Gender.female,
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value as Gender;
                });
              },
            ),
            Text('Kadın'),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              double heightInMeter = height / 100;
              bmi = weight / (heightInMeter * heightInMeter);
              bodyFatPercentage = calculateBodyFatPercentage();
              leanBodyMass = calculateLeanBodyMass();
              basalMetabolicRate = calculateBasalMetabolicRate();
            });
          },
          child: Text('Hesapla'),
        ),
        SizedBox(height: 20),
        Text(
          'Vücut Kitle İndeksi: ${bmi.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'Vücut Yağı Yüzdesi: ${bodyFatPercentage.toStringAsFixed(2)}%',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'Yağsız Vücut Kütlesi: ${leanBodyMass.toStringAsFixed(2)} kg',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          'Bazal Metabolik Hız: ${basalMetabolicRate.toStringAsFixed(2)} kcal',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  double calculateBodyFatPercentage() {
    if (selectedGender == Gender.male) {
      return (1.20 * bmi) + (0.23 * age) - 16.2;
    } else {
      return (1.20 * bmi) + (0.23 * age) - 5.4;
    }
  }

  double calculateLeanBodyMass() {
    return weight * (1 - (bodyFatPercentage / 100));
  }

  double calculateBasalMetabolicRate() {
    if (selectedGender == Gender.male) {
      return 66 + (13.75 * weight) + (5 * height) - (6.75 * age);
    } else {
      return 655 + (9.56 * weight) + (1.85 * height) - (4.68 * age);
    }
  }
}

enum Gender { male, female }
