import 'package:fitfrend/diger.dart';
import 'package:fitfrend/home.db';
import 'package:fitfrend/istatistik.dart';
import 'package:flutter/material.dart';
import 'package:fitfrend/exercise.dart';
import 'package:fitfrend/yemek.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int hedefKalori = 0;
  int harcananKalori = 0;
  int ogunSayisi = 0;
  int egzersizSure = 0;
  int alinanKalori = 0;

  double progress = 0.0;
  int kalanKalori = 0;
  int yuzde = 0;
  int fazlaKalori = 0;

  String formattedDate = '';

  final TextEditingController egzersizKaloriController = TextEditingController();
  final TextEditingController yenilenKaloriController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setCurrentDate();
    fetchData();
  }

  Future<void> fetchData() async {
    FitData fitData = FitData();
    Map<String, int> kalori = await fitData.getKalori();

    setState(() {
      hedefKalori = kalori['hedefKalori'] ?? 0;
      harcananKalori = kalori['harcananKalori'] ?? 0;
      ogunSayisi = kalori['ogunSayisi'] ?? 0;
      egzersizSure = kalori['egzersizSure'] ?? 0;
      alinanKalori = kalori['alinanKalori'] ?? 0;

      progress = alinanKalori / hedefKalori;
      kalanKalori = hedefKalori - alinanKalori;
      yuzde = ((alinanKalori / hedefKalori) * 100).toInt();
      fazlaKalori = alinanKalori - hedefKalori;
      if (fazlaKalori < 0) {
        fazlaKalori = 0;
      }
    });
  }



  void setCurrentDate() {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('dd.MM.yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            Text('FitFrend'),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Günlük Kalori Durumu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(Icons.flag, 'Hedef', '$hedefKalori kal',
                    Colors.green),
                _buildStatItem(Icons.restaurant_menu, 'Yenilen',
                    '$alinanKalori kal', Colors.red),
                _buildStatItem(Icons.fitness_center, 'Egzersiz',
                    '$harcananKalori kal', Colors.blue),
                IconButton(
                  onPressed: () {
                    _showEditDialog();
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Card(
            margin: EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  value: progress,
                                  strokeWidth: 10,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    progress >= 1.0 ? Colors.red : Colors.green,
                                  ),
                                ),
                              ),
                              Text(
                                '$yuzde%',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem(Icons.add_circle_outline,
                            'Kalan Kalori', '$kalanKalori kal', Colors.orange),
                        _buildStatItem(Icons.warning_rounded, 'Fazla Alınan',
                            '$fazlaKalori kal', Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 4,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExercisePage(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 8.0),
                          Text(
                            'Egzersiz',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Harcanan Kal: $harcananKalori kal',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Süre: $egzersizSure dk',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
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
                    child: Card(
                      margin: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Yemek',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Alınan Kalori: $alinanKalori kal',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Öğün Sayısı: $ogunSayisi',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
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
                                                  },
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
                              MaterialPageRoute(
                                builder: (context) => MealScreen(),
                              ),
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
                          );

                        },
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
        ],
      ),
    );
  }


  void _showEditDialog() {
    TextEditingController egzersizKaloriController =
    TextEditingController(text: harcananKalori.toString());
    TextEditingController yenilenKaloriController =
    TextEditingController(text: alinanKalori.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Değerleri Düzenle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: yenilenKaloriController,
                decoration: InputDecoration(labelText: 'Yenilen Kalori'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: egzersizKaloriController,
                decoration: InputDecoration(labelText: 'Egzersiz Kalori'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Diyalog kutusunu kapat
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                // Değerleri kaydet ve işlemleri gerçekleştir
                _saveValues(
                  int.parse(egzersizKaloriController.text),
                  int.parse(yenilenKaloriController.text),
                );
                Navigator.of(context).pop(); // Diyalog kutusunu kapat
              },
              child: Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }



  void setTargetCalorie() async {
    FitData fitData = FitData();
    int id = 1;

    // Hedef kalori değerini güncellemek için FitData sınıfını kullanıyoruz.
    await fitData.updateKalori({'alinanKalori': alinanKalori}, id);
  }







  void _saveValues(int egzersizKalori, int yenilenKalori) {
    setState(() {
      harcananKalori = egzersizKalori;
      alinanKalori = yenilenKalori;

      // Hesaplamaları yeniden yap
      progress = alinanKalori / hedefKalori;
      kalanKalori = hedefKalori - alinanKalori;
      yuzde = ((alinanKalori / hedefKalori) * 100).toInt();
      fazlaKalori = alinanKalori - hedefKalori;
    });
  }






  Widget _buildStatItem(
      IconData icon, String title, String value, Color color) {
    if (title == 'Kalan Kalori' || title == 'Fazla Alınan') {
      return Column(
        children: [
          SizedBox(
            height: 8.0,
          ), // Boşluk ekle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: color,
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    value,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: color,
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    value,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }
  }
}
