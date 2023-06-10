import 'package:fitfrend/Diger.dart';
import 'package:fitfrend/home.dart';
import 'package:fitfrend/istatistik.dart';
import 'package:fitfrend/yemek.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yemek Tarifleri',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),

      home: RecipePage(),
    );

  }
}

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<Meal> meals = [
    Meal(
      'Kahvaltı',
      'Omlet',
      250,
      'Yalnızca 3 malzeme ile hazırlanan sade omlet, yapışmaz tavada pişirilir. Hazırlaması 5, pişirmesi 10 dakika',
    ),
    Meal(
      'Kahvaltı',
      'Yulaf ezmesi',
      200,
      '1 çay bardağı süt ve 3 yemek kaşığı yulaf ezmesini bir tencerede birkaç dakika kaynatın. Kaynadıktan sonra yulaf ezmesi hazır. Dilediğiniz gibi süsleyebilirsiniz.',

    ),
    Meal(
      'Akşam Yemeği',
      'Tavuk Sote',
      200,
      ' Sote tavası ve kullandığınız yağı önceden kızdırın. Sote edilen doğranmış kabuksuz domates ve biberler suyunu salacağı için ekstra su kullanmayın. ',
    ),
    Meal(
      'Öğle Yemeği',
      'Tavuk Salatası',
      350,
      ' Kornişon turşuyu minik küpler şeklinde doğrayın. Tavuk göğsünü didikleyin ve üzerine yeşillikleri ve turşuları ekleyin. Sonra konserve mısır, zeytinyağı, limon ve tuz ekleyerek güzelce tüm malzemeleri karıştırın. Tavuk salatanız servise hazır.',
    ),
    Meal(
      'Öğle Yemeği',
      'Izgara Somon',
      300,
      'Zeytinyağı, taze sıkılmış limon suyu, defne yaprağı, tane karabiber ve tuzu geniş bir kapta karıştırın. Somon dilimlerini bu karışıma yatırıp en az 30 dakika buzdolabında bekletin. Buzdolabından çıkarıp kısa süre önceden ısıtılmış ızgara üzerinde ters yüz ederek kısa süre pişirin.',
    ),
    Meal(
      'Öğle Yemeği',
      'Mercimek Çorbası',
      200,
      'Tuz, karabiber ve bol suda yıkadıktan sonra suyunu süzdürdüğünüz 1,5 su bardağı mercimeği de ilave edin ve son kez güzelce karıştırın. 6 su bardağı sıcak suyu da tencereye ilave edin. Ardından kapağını kapatın, patates ve havuçlar yumuşayana kadar ara ara karıştırarak 40 dakika kadar pişirin.',
    ),
    Meal(
      'Tatlı',
      'Sütlaç',
      200,
      'Süt ile pirinç iyice kaynadıktan sonra 2 su bardağı şekeri tencereye ilave edin. Şekeri de ekledikten sonra kısık ateşte bir saat pişmeye bırakın. Piştikten sonra kaselere bölüştürerek servis etmeye hazır hale getirin. Afiyet olsun.',
    ),
    Meal(
      'Tatlı',
      'Puding',
      200,
      'Önce sütü puding yapmak için uygun olan bir tencereye döküyoruz. Sonra şekeri nişastayı ve unu ekleyip orta ateşte kaynayıncaya kadar karıştırıyoruz. Kaynadıktan sonra vanilya ve tereyağını ilave edip biraz daha karıştırıyoruz ve altını kapatıyoruz. Kaselere döküyoruz.',
    ),

    // Diğer yemeklerin tariflerini ekleyin
  ];

  List<Meal> filteredMeals = [];

  @override
  void initState() {
    super.initState();
    filteredMeals = meals;
  }

  void filterMeals(String searchText) {
    setState(() {
      filteredMeals = meals
          .where((meal) =>
          meal.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void viewRecipe(Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailPage(meal: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Tarifleri'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Diger(),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                filterMeals(value);
              },
              decoration: InputDecoration(
                labelText: 'Yemek Ara',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMeals.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(filteredMeals[index].name),
                  subtitle: Text(filteredMeals[index].category ,style: TextStyle(color: Colors.green),),
                  trailing: Text('${filteredMeals[index].calories} kcal',style: TextStyle(color: Colors.red),),
                  onTap: () {
                    viewRecipe(filteredMeals[index]);
                  },
                );
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

class Meal {
  final String category;
  final String name;
  final int calories;
  final String recipe;

  Meal(this.category, this.name, this.calories, this.recipe);
}

class RecipeDetailPage extends StatelessWidget {
  final Meal meal;

  RecipeDetailPage({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarif'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yemek: ${meal.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Kategori: ${meal.category}',
              style: TextStyle(fontSize: 18,color: Colors.teal),
            ),
            SizedBox(height: 10),
            Text(
              'Kalori: ${meal.calories} kcal',
              style: TextStyle(fontSize: 18, color: Colors.redAccent),
            ),
            SizedBox(height: 10),
            Text(
              'Tarif: ${meal.recipe}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),

      ),

    );
  }
}
