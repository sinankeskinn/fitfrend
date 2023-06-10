import 'package:fitfrend/Diger.dart';
import 'package:fitfrend/home.dart';
import 'package:fitfrend/istatistik.dart';
import 'package:fitfrend/yemek.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  final List<HelpItem> helpItems = [
    HelpItem(
      question: 'Günlük kalori hedefimi nasıl belirlerim?',
      answer: 'Diğer sekmesinde bulunan hedefler sekmesinden, fiziksel bilgilerinizi girerek belirleyebilirsiniz.',
    ),
    HelpItem(
      question: 'Yemek nasıl eklerim?',
      answer: 'Yemek sekmesinden yemek ekle(+) iconu ile, yemek bilgilerini girerek ekleme yapabilirsiniz. ',
    ),
    HelpItem(
      question: 'Egzersiz nasıl eklerim?',
      answer: 'Egzersiz sayfasından ekle butonu ile(+) egzersiz verilerini girerek kişisel egzersizinizi oluşturabilirsiniz.',
    ),
    HelpItem(
      question: 'Yemek tariflerine nasıl giderim?',
      answer: 'Diğer sayfasından Yemek tarifleri sekmesine ulaşabilirsiniz. ',
    ),
    HelpItem(
      question: 'Vücut Kitle İndex hesalama işleminin nasıl yaparım? ' ,
      answer: 'Diğer sayfasından Vücut Kitle indexi hesaplayıcısına ulaşabilirsiniz. ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yardım'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Diger()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: helpItems.length,
              itemBuilder: (context, index) {
                return HelpItemCard(helpItem: helpItems[index]);
              },
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen(),
                            ),
                          );                        },
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
                          );                             },
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
}

class HelpItem {
  final String question;
  final String answer;

  HelpItem({required this.question, required this.answer});
}

class HelpItemCard extends StatelessWidget {
  final HelpItem helpItem;

  HelpItemCard({required this.helpItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(helpItem.question),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(helpItem.answer),
          ),
        ],
      ),
    );
  }
}
