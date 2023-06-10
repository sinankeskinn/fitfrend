import 'package:fitfrend/diger.dart';
import 'package:fitfrend/home.dart';
import 'package:fitfrend/yemek.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fitfrend/home.db';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final FitData fitData = FitData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(),
              ),
            );
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Map<String, int>>(
              future: fitData.getKalori(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Veriler alınırken bir hata oluştu.'),
                  );
                } else {
                  final kaloriData = snapshot.data;
                  if (kaloriData != null) {
                    final alinanKalori = kaloriData['alinanKalori'] ?? 0;
                    final egzersizSure = kaloriData['egzersizSure'] ?? 0;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Haftalık Alınan Kalori Verileri',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 300,
                          padding: EdgeInsets.all(10),
                          child: _buildColumnChart(),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Haftalık Egzersiz Verileri',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 300,
                          padding: EdgeInsets.all(10),
                          child: _buildLineChart(),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text('Veri bulunamadı.'),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    icon: Icon(
                      IconData(0xe6e6, fontFamily: 'MaterialIcons'),
                      size: 30,
                      color: Colors.white,
                    ),
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
                        color: Colors.white,
                      ),
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
                      // İstatistik butonuna basıldığında yapılacak işlemler
                    },
                    icon: Icon(
                      Icons.bar_chart,
                      size: 30,
                      color: Colors.white,
                    ),
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
                      color: Colors.white,
                    ),
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

  Widget _buildColumnChart() {
    final data = [
      KaloriData(DateTime(2023, 6, 1), 2500),
      KaloriData(DateTime(2023, 6, 2), 2800),
      KaloriData(DateTime(2023, 6, 3), 3000),
      KaloriData(DateTime(2023, 6, 4), 2700),
      KaloriData(DateTime(2023, 6, 5), 2900),
      KaloriData(DateTime(2023, 6, 6), 3200),
      KaloriData(DateTime(2023, 6, 7), 2700),
    ];

    final series = [
      charts.Series<KaloriData, String>(
        id: 'Kalori',
        data: data,
        domainFn: (KaloriData kalori, _) => '${kalori.date.day}/${kalori.date.month}',
        measureFn: (KaloriData kalori, _) => kalori.value,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      ),
    ];

    return charts.BarChart(
      series,
      animate: true,
    );
  }

  Widget _buildLineChart() {
    final data = [
      EgzersizData(DateTime(2023, 6, 1), 30),
      EgzersizData(DateTime(2023, 6, 2), 45),
      EgzersizData(DateTime(2023, 6, 3), 60),
      EgzersizData(DateTime(2023, 6, 4), 50),
      EgzersizData(DateTime(2023, 6, 5), 55),
      EgzersizData(DateTime(2023, 6, 6), 40),
      EgzersizData(DateTime(2023, 6, 7), 35),
    ];

    data.sort((a, b) => a.date.compareTo(b.date));

    final series = [
      charts.Series<EgzersizData, DateTime>(
        id: 'Egzersiz',
        data: data,
        domainFn: (EgzersizData egzersiz, _) => egzersiz.date,
        measureFn: (EgzersizData egzersiz, _) => egzersiz.value,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      ),
    ];

    return charts.TimeSeriesChart(
      series,
      animate: true,
      domainAxis: charts.DateTimeAxisSpec(
        tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(
            format: 'd', // Gün formatı
            transitionFormat: 'd MMM', // Geçiş formatı
          ),
        ),
      ),
    );
  }


}

class KaloriData {
  final DateTime date;
  final int value;

  KaloriData(this.date, this.value);
}

class EgzersizData {
  final DateTime date;
  final int value;

  EgzersizData(this.date, this.value);
}
