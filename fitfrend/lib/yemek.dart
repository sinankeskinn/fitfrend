import 'package:fitfrend/diger.dart';
import 'package:fitfrend/home.dart';
import 'package:fitfrend/home.db';
import 'package:fitfrend/istatistik.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SortOrder { Artan, Azalan }

class Meal {
  final String mealType;
  final String mealName;
  final int calorie;
  int portion;

  Meal(this.mealType, this.mealName, this.calorie, {this.portion = 0});

  void increasePortion() {
    portion++;
  }

  void decreasePortion() {
    if (portion > 0) { // Değer 1'den küçük olmamalı
      portion--;
    }
  }
}


class MealScreen extends StatefulWidget {
  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  List<Meal> mealList = [
    Meal('Kahvaltı', 'Omlet', 250),
    Meal('Kahvaltı', 'Yulaf ezmesi', 200),
    Meal('Kahvaltı', 'Meyve Tabağı', 100),
    Meal('Öğle Yemeği', 'Tavuk Salatası', 350),
    Meal('Öğle Yemeği', 'Mevsim Salatası', 300),
    Meal('Öğle Yemeği', 'Mercimek Çorbası', 200),
    Meal('Akşam Yemeği', 'Izgara Somon', 400),
    Meal('Akşam Yemeği', 'Sebzeli Makarna', 350),
    Meal('Akşam Yemeği', 'Tavuk Sote', 300),
    Meal('Ara Öğün', 'Yoğurt', 150),
    Meal('Ara Öğün', 'Ceviz', 200),
    Meal('Ara Öğün', 'Muz', 100),
    Meal('Atıştırmalık', 'Havuç Dilimleri', 50),
    Meal('Atıştırmalık', 'Badem', 100),
    Meal('Atıştırmalık', 'Kuru Üzüm', 80),
    Meal('İçecek', 'Yeşil Çay', 50),
    Meal('İçecek', 'Portakal Suyu', 120),
    Meal('İçecek', 'Soda', 0),
    Meal('Kahvaltı', 'Peynir', 150),
    Meal('Öğle Yemeği', 'Tavuk Izgara', 300),
    Meal('Akşam Yemeği', 'Karnıyarık', 400),
    Meal('Meyve', 'Elma', 80),
    Meal('Meyve', 'Muz', 90),
    Meal('Meyve', 'Portakal', 120),
    Meal('Meyve', 'Domates', 80),
    Meal('İçecek', 'Maden Suyu', 0),
    Meal('Atıştırmalık', 'Cips', 200),
    Meal('Atıştırmalık', 'Çikolata', 150),
    Meal('Atıştırmalık', 'Kraker', 100),
    Meal('Atıştırmalık', 'Jelibon', 80),
    Meal('İçecek', 'Limonata', 150),
    Meal('İçecek', 'Çay', 60),
    Meal('İçecek', 'Süt', 120),
    Meal('İçecek', 'Ayran', 100),
    Meal('İçecek', 'Meyve Suyu', 180),
    Meal('İçecek', 'Kahve', 50),
    Meal('İçecek', 'Bitki Çayı', 0),
    Meal('İçecek', 'Mocha', 200),
    Meal('Kahvaltı', 'Menemen', 300),
    Meal('Kahvaltı', 'Simit', 150),
    Meal('Kahvaltı', 'Pancake', 250),
    Meal('Kahvaltı', 'Sigara Böreği', 200),
    Meal('Kahvaltı', 'Çay', 50),
    Meal('Kahvaltı', 'Tost', 350),
    Meal('Kahvaltı', 'Mısır Gevrekleri', 200),
    Meal('Kahvaltı', 'Bal', 80),
    Meal('Kahvaltı', 'Reçel', 100),
    Meal('Öğle Yemeği', 'Izgara Tavuk Göğsü', 300),
    Meal('Öğle Yemeği', 'Peynirli Sandviç', 250),
    Meal('Öğle Yemeği', 'Tavuklu Noodle', 400),
    Meal('Öğle Yemeği', 'Köfte Pilav', 450),
    Meal('Akşam Yemeği', 'Kıymalı Pide', 500),
    Meal('Akşam Yemeği', 'Fırında Tavuk', 350),
    Meal('Akşam Yemeği', 'Sebzeli Düdüklü Tencere', 400),
    Meal('Akşam Yemeği', 'Etli Sebzeli Güveç', 450),
    Meal('Akşam Yemeği', 'Balık Tava', 350),
    Meal('Akşam Yemeği', 'Kaşarlı Tost', 300),
    Meal('Tatlı', 'Cheesecake', 300),
    Meal('Tatlı', 'Çikolata Sufle', 250),
    Meal('Tatlı', 'Meyveli Pasta', 200),
    Meal('Tatlı', 'Profiterol', 350),
    Meal('Tatlı', 'Brownie', 200),
    Meal('Tatlı', 'Magnolia', 300),
    Meal('Tatlı', 'Tiramisu', 250),
    Meal('Tatlı', 'Çilekli Parfe', 200),
    Meal('Tatlı', 'Trileçe', 350),
    Meal('Tatlı', 'Muhallebi', 200),
    Meal('Tatlı', 'Waffle', 300),
    Meal('Tatlı', 'Panna Cotta', 250),
    Meal('Tatlı', 'Donut', 200),
    Meal('Tatlı', 'Meyveli Yoğurt', 150),
    Meal('Tatlı', 'Krem Şanti', 200),
    Meal('Tatlı', 'Çikolatalı Mousse', 250),
    Meal('Tatlı', 'İrmik Helvası', 180),
    Meal('Tatlı', 'Kadayıf', 300),
    Meal('Tatlı', 'Sütlü Nuriye', 220),
    Meal('Tatlı', 'Kazandibi', 250),
  ];

  List<Meal> filteredMealList = [];
  List<String> mealTypes = [];
  String selectedMealType = '';
  String searchQuery = '';
  SortOrder selectedSortOrder = SortOrder.Artan;
  int selectedTotalCalorie = 0;

  SharedPreferences? _prefs;

  @override
  void dispose() {
    _saveTotalCalorie(); // Kaloriyi kaydet
    super.dispose();
  }



  @override
  void initState() {
    super.initState();
    _initializePreferences();
    filteredMealList = List.from(mealList);
    _extractMealTypes();
    _filterMealList();
  }


  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedTotalCalorie = _prefs!.getInt('totalCalorie') ?? 0;
    });
  }


  void _saveTotalCalorie() async {
    _prefs?.setInt('totalCalorie', selectedTotalCalorie);

    // Database üzerinden alinanKalori değerini güncelleme işlemi.
    FitData fitData = FitData();
    int id = 1;
    await fitData.updateAlinanKalori(selectedTotalCalorie, id);
  }








  void _extractMealTypes() {
    mealTypes = mealList.map((meal) => meal.mealType).toSet().toList();
  }

  void _filterMealList() {
    filteredMealList = mealList.where((meal) {
      bool typeMatches = selectedMealType.isEmpty || meal.mealType == selectedMealType;
      bool queryMatches = meal.mealName.toLowerCase().contains(searchQuery);
      return typeMatches && queryMatches;
    }).toList();

    _sortMealList();
    _calculateTotalCalorie(); // Toplam kaloriyi hesaplamak için bu metodu çağırın
  }


  void _calculateTotalCalorie() {
    int totalCalorie = 0;

    for (Meal meal in filteredMealList) {
      totalCalorie += meal.calorie * meal.portion;
    }

    setState(() {
      selectedTotalCalorie = totalCalorie;
    });

    // Kaydetmek için _saveTotalCalorie metodunu burada çağırmayın
  }


  void _sortMealList() {
    if (selectedSortOrder == SortOrder.Artan) {
      filteredMealList.sort((a, b) => a.calorie.compareTo(b.calorie));
    } else {
      filteredMealList.sort((a, b) => b.calorie.compareTo(a.calorie));
    }
  }

  Widget _buildMealItem(Meal meal) {
    return Card(
      child: ListTile(
        title: Text(meal.mealName),
        subtitle: Text('${meal.calorie.toString()} kal', style: TextStyle(color: Colors.red)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  meal.decreasePortion();
                });
                _calculateTotalCalorie();
              },
              icon: Icon(Icons.remove),
            ),
            Text('${meal.portion}'),
            IconButton(
              onPressed: () {
                setState(() {
                  meal.increasePortion();
                });
                _calculateTotalCalorie();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Afiyet olsun'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        onTap: () {
          _saveTotalCalorie(); // Kaloriyi kaydet
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Kalori güncellendi'),
              duration: Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Listesi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                  _filterMealList();
                });
              },
              decoration: InputDecoration(
                labelText: 'Ara',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 4.0, 2.0, 4.0),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'Yemek Türü',
                      prefixIcon: Icon(Icons.category),
                    ),
                    value: selectedMealType,
                    onChanged: (value) {
                      setState(() {
                        selectedMealType = value.toString();
                        _filterMealList();
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text('Tümü'),
                        value: '',
                      ),
                      ...mealTypes.map((type) => DropdownMenuItem(child: Text(type), value: type)).toList(),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'Sıralama',
                      prefixIcon: Icon(Icons.sort),
                    ),
                    value: selectedSortOrder,
                    onChanged: (value) {
                      setState(() {
                        selectedSortOrder = value as SortOrder;
                        _sortMealList();
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text('Artan'),
                        value: SortOrder.Artan,
                      ),
                      DropdownMenuItem(
                        child: Text('Azalan'),
                        value: SortOrder.Azalan,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),





          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Toplam Kalori:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  selectedTotalCalorie.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMealList.length,
              itemBuilder: (context, index) {
                return _buildMealItem(filteredMealList[index]);
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
                          );
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
}

void main() {
  runApp(MaterialApp(
    home: MealScreen(),
  ));
}
