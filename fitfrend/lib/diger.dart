import 'package:fitfrend/hedef.dart';
import 'package:fitfrend/help.dart';
import 'package:fitfrend/istatistik.dart';
import 'package:fitfrend/tarif.dart';
import 'package:fitfrend/vke.dart';
import 'package:flutter/material.dart';
import 'package:fitfrend/home.dart';
import 'package:fitfrend/yemek.dart';


class Diger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diğer'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        children: [
          _buildGridItem(
            icon: Icons.restaurant,
            title: 'Yemek Tarifleri',
            color: Colors.orange,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RecipeApp(),
                ),
              );
            },
          ),
          _buildGridItem(
            icon: Icons.accessibility_new_rounded,
            title: 'Vücut Kitle Endeksi',
            color: Colors.green,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Vücut Kitle Endeksi Hesaplayıcı'),
                    content: SingleChildScrollView(
                      child: BodyMassIndexCalculator(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Kapat'),
                      ),
                    ],
                  );
                },
              );

            },
          ),

          _buildGridItem(
            icon: Icons.flag_circle,
            title: 'Hedef',
            color: Colors.blue,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CalorieCalculatorPage(),
                ),
              );

            },
          ),
          _buildGridItem(
            icon: Icons.hide_source,
            title: 'Uygulama Hakkında',
            color: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(width: 10),
                        Text('Uygulama Hakkında',style: TextStyle(fontSize:18 )),
                      ],
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'FitFrend Mobil Uygulaması',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'FitFrend mobil uygulaması, sağlıklı bir yaşam tarzı benimseyenler için tasarlanmış kullanıcı dostu bir uygulamadır. Bu uygulama, kullanıcıların beslenme alışkanlıklarını takip etmelerine, egzersiz yapmalarına, vücut ölçümlerini kaydetmelerine ve sağlıklı bir yaşam tarzını sürdürmelerine yardımcı olur.',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Uygulamanın Temel Özellikleri:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Beslenme Takibi: Fit Yaşam, kullanıcılara günlük olarak tükettikleri kalori, karbonhidrat, protein, yağ gibi besin değerlerini takip etme imkanı sağlar. Kullanıcılar, yemek ve içecek tüketimlerini kaydedebilir ve besin öğelerinin dengeli bir şekilde alınmasını sağlayabilir.\n\nEgzersiz Planlama: Uygulama, kullanıcılara kişiselleştirilmiş egzersiz planları sunar. Kullanıcılar, egzersiz türlerini seçebilir, süreleri ve yoğunluklarını ayarlayabilir ve düzenli olarak egzersiz yapmalarını sağlayacak bir program oluşturabilirler.\n\nVücut Ölçümleri: Fit Yaşam, kullanıcılara kilo, boy, bel çevresi gibi vücut ölçümlerini kaydetme imkanı sunar. Bu ölçümler, ilerlemeyi takip etmek ve sağlıklı bir şekilde kilo vermeyi veya kas kütlesini artırmayı hedefleyen kullanıcılara yol gösterir.\n\nHedefler ve İstatistikler: Kullanıcılar, kendilerine belirledikleri hedeflere ulaşmak için ilerlemelerini izleyebilirler. Uygulama, kullanıcılara istatistikler ve grafikler aracılığıyla ilerlemelerini görsel olarak takip etme imkanı sunar ve motive edici bir deneyim sağlar.\n\nBeslenme Rehberi ve Tarifler: Fit Yaşam, kullanıcılara sağlıklı beslenme konusunda rehberlik eder. Uygulama içindeki beslenme rehberi ve tarifler, kullanıcılara dengeli ve besleyici yiyecekler seçmelerine yardımcı olur.\n\nHatırlatıcılar ve Bildirimler: Uygulama, kullanıcılara günlük hedeflerini hatırlatır ve düzenli olarak egzersiz yapmaları veya su içmeleri gibi sağlıklı alışkanlıkları sürdürmelerine yardımcı olacak bildirimler gönderir.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Kapat'),
                      ),
                    ],
                  );
                },
              );
            },
          ),


          _buildGridItem(
            icon: Icons.help,
            title: 'Yardım',
            color: Colors.purple,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HelpPage(),
                ),
              );

            },
          ),
          _buildGridItem(
            icon: Icons.settings,
            title: 'Ayarlar',
            color: Colors.teal,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Uygulama Verilerini Sıfırla'),
                  content: Text('Uygulama verilerini sıfırlamak istediğinize emin misiniz?'),
                  actions: [
                    ElevatedButton(
                      child: Text('Uygulama Verilerini Sıfırla'),
                      onPressed: () {
                        Navigator.pop(context); // İletişim kutusunu kapat
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Başarılı'),
                            content: Text('Uygulama başarıyla sıfırlandı.'),
                            actions: [
                              ElevatedButton(
                                child: Text('Kapat'),
                                onPressed: () {
                                  Navigator.pop(context); // İkinci iletişim kutusunu kapat
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    TextButton(
                      child: Text('Kapat'),
                      onPressed: () {
                        Navigator.pop(context); // İlk iletişim kutusunu kapat
                      },
                    ),
                  ],
                ),
              );
            },
          ),

        ],
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
                        MaterialPageRoute(builder: (context) => HomeScreen(),
                        ),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => StatisticsPage()),
                      );                         },
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



  Widget _buildGridItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
