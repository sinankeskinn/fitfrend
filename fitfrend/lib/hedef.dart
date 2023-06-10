import 'package:fitfrend/Diger.dart';
import 'package:fitfrend/home.dart';
import 'package:fitfrend/home.db';
import 'package:fitfrend/istatistik.dart';
import 'package:fitfrend/yemek.dart';
import 'package:flutter/material.dart';

class CalorieCalculatorPage extends StatefulWidget {
  @override
  _CalorieCalculatorPageState createState() => _CalorieCalculatorPageState();
}

enum Gender { male, female }

class _CalorieCalculatorPageState extends State<CalorieCalculatorPage> {
  int age = 0;
  double weight = 0;
  double height = 0;
  double calorieResult = 0;
  double targetCalorie = 0; // Added targetCalorie variable
  String lifestyle = '';
  Gender? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Diger()),
            );
          },
        ),
        title: Text('Günlük Kalori Hesaplayıcı'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Yaş',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  age = int.parse(value);
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Kilo (kg)',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  weight = double.parse(value);
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Boy (cm)',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  height = double.parse(value);
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Aktivite Düzeyi',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(child: Text('Az Hareketli Yaşam'), value: 'Az Hareketli Yaşam'),
                DropdownMenuItem(child: Text('Orta Derece Hareketli Yaşam'), value: 'Orta Derece Hareketli Yaşam'),
                DropdownMenuItem(child: Text('Sportif Yaşam'), value: 'Sportif Yaşam'),
              ],
              onChanged: (value) {
                setState(() {
                  lifestyle = value.toString();
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Cinsiyet',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Radio(
                  value: Gender.male,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value as Gender;
                    });
                  },
                ),
                Text('Erkek'),
                SizedBox(width: 20),
                Radio(
                  value: Gender.female,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value as Gender;
                    });
                  },
                ),
                Text('Kadın'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateCalories,
              child: Text('Hesapla'),
            ),
            SizedBox(height: 20),
            Text(
              'Günlük İhtiyaç Duyulan Kalori:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              calorieResult.toStringAsFixed(2),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: setTargetCalorie, // New onPressed event handler
              child: Text('Hedef Olarak Belirle'),
            ),
            SizedBox(height: 20),
            Text(
              'Hedef Kalori:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              targetCalorie.toStringAsFixed(2),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(),
                        ),
                      );                    },
                    icon: Icon(
                      IconData(0xe6e6, fontFamily: 'MaterialIcons'),
                      size: 30,
                    ),
                    color: Colors.white,
                  ),
                  Text(
                    'Kontrol Paneli',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MealScreen()),
                  );
                },
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MealScreen()),
                        );
                      },
                      icon: Icon(
                        Icons.food_bank,
                        size: 30,
                      ),
                      color: Colors.white,
                    ),
                    Text(
                      'Yemek',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => StatisticsPage()),
                      );                         },
                    icon: Icon(
                      Icons.bar_chart,
                      size: 30,
                    ),
                    color: Colors.white,
                  ),
                  Text(
                    'İstatistik',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Diger()),
                      );
                    },
                    icon: Icon(
                      Icons.list,
                      size: 30,
                    ),
                    color: Colors.white,
                  ),
                  Text(
                    'Diğer',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateCalories() {
    setState(() {
      double bmr = 0;
      if (gender == Gender.male) {
        bmr = 66 + (13.75 * weight) + (5 * height) - (6.75 * age);
      } else if (gender == Gender.female) {
        bmr = 655 + (9.56 * weight) + (1.85 * height) - (4.68 * age);
      }

      switch (lifestyle) {
        case 'Az Hareketli Yaşam':
          calorieResult = bmr * 1.2;
          break;
        case 'Orta Derece Hareketli Yaşam':
          calorieResult = bmr * 1.55;
          break;
        case 'Sportif Yaşam':
          calorieResult = bmr * 1.9;
          break;
        default:
          calorieResult = 0;
          break;
      }
    });
  }



  void setTargetCalorie() async {
    setState(() {
      targetCalorie = calorieResult;
    });

    FitData fitData = FitData(); // FitData sınıfınızı oluşturun
    int id = 1; // Güncellenecek verinin ID'sini belirleyin (bu örnekte 1 olarak varsayıldı)

    // Hedef kalori değerini güncellemek için FitData sınıfınıkullanıdk
    await fitData.updateKalori({'hedefKalori': targetCalorie.toInt()}, id);
  }




}