import 'package:fitfrend/Diger.dart';
import 'package:fitfrend/home.dart';
import 'package:fitfrend/home.db';
import 'package:fitfrend/istatistik.dart';
import 'package:fitfrend/yemek.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late ExerciseDatabase _exerciseDatabase;
  List<Exercise> _exercises = [];
  String searchQuery = '';
  double toplamCalori = 0;

  @override
  void initState() {
    super.initState();
    _exerciseDatabase = ExerciseDatabase();
    _createDatabase();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _createDatabase();
  }

  void _createDatabase() async {
    await _exerciseDatabase.createDatabase();

    setState(() {
      _exercises = _exerciseDatabase.exercises;
      calculateTotalCalories();

    });
  }

  void _addExercise(Exercise exercise) async {
    await _exerciseDatabase.addExercise(exercise);

    setState(() {
      _exercises.add(exercise);
      calculateTotalCalories();
    });
  }

  void _incrementExerciseDuration(int index) {
    setState(() {
      _exercises[index].duration += 15;
      _updateExercise(_exercises[index]);
      calculateTotalCalories();
    });

    FitData fitData = FitData(); // FitData sınıfınızı oluşturun
    int id = 1; // Güncellenecek verinin ID'sini belirleyin (bu örnekte 1 olarak varsayıldı)

    // Hedef kalori değerini güncellemek için FitData sınıfını kullanın
    fitData.updateKalori({'harcananKalori': toplamCalori.toInt()}, id);
  }

  void _decrementExerciseDuration(int index) {
    setState(() {
      if (_exercises[index].duration >= 15) {
        _exercises[index].duration -= 15;
        _updateExercise(_exercises[index]);
        calculateTotalCalories();
      }
    });

    FitData fitData = FitData(); // FitData sınıfınızı oluşturun
    int id = 1; // Güncellenecek verinin ID'sini belirleyin (bu örnekte 1 olarak varsayıldı)

    // Hedef kalori değerini güncelleme işlemi.
    fitData.updateKalori({'harcananKalori': toplamCalori.toInt()}, id);
  }

  void _updateExercise(Exercise exercise) async {
    await _exerciseDatabase.updateExercise(exercise);
  }

  void _filterExercises(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  void calculateTotalCalories() {
    toplamCalori = 0;
    for (var exercise in _exercises) {
      toplamCalori += (exercise.duration / 15) * exercise.calories;
    }
  }



  List<Exercise> get filteredExercises {
    if (searchQuery.isEmpty) {
      return _exercises;
    } else {
      return _exercises
          .where((exercise) =>
          exercise.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Egzersiz Sayfası'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterExercises,
              decoration: InputDecoration(
                labelText: 'Egzersiz Ara',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
          Text(
            'Toplam Harcanan Kalori: $toplamCalori',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredExercises.length,
              itemBuilder: (context, index) {
                final exercise = filteredExercises[index];
                return Card(
                  margin: EdgeInsets.all(16.0),
                  child: ListTile(
                    title: Text(exercise.name),
                    subtitle: Column(
                      children: [
                        Text(
                          '${exercise.calories} kalori',
                          style: TextStyle(color: Colors.red),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  _decrementExerciseDuration(index),
                              icon: Icon(Icons.remove),
                            ),
                            Text('${exercise.duration} dk'),
                            IconButton(
                              onPressed: () => _incrementExerciseDuration(index),
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddexerciseDialog(context);
        },
        child: Icon(Icons.add),
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

  void _showAddexerciseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        String exerciseName = '';
        int calories = 0;

        return AlertDialog(
          title: Text('Egzersiz Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  exerciseName = value;
                },
                decoration: InputDecoration(labelText: 'Egzersiz Adı'),
              ),
              TextField(
                onChanged: (value) {
                  calories = int.parse(value);
                },
                decoration: InputDecoration(labelText: 'Kalori Miktarı'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                Exercise exercise = Exercise(
                  name: exerciseName,
                  calories: calories,
                  duration: 0,
                );
                _addExercise(exercise);
                Navigator.of(context).pop();
              },
              child: Text('Ekle'),
            ),
          ],
        );
      },
    );
  }
}
class Exercise {
  int? id;
  String name;
  int calories;
  int duration;

  Exercise({
    this.id,
    required this.name,
    required this.calories,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'duration': duration,
    };
  }
}

class ExerciseDatabase {
  late Database _database;

  List<Exercise> get exercises {
    return _exercises;
  }

  Future<void> createDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'exercise_database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE exercises ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT,'
            'calories INTEGER,'
            'duration INTEGER'
            ')');
      },
    );

    // Veritabanından egzersizleri al
    _exercises = await _fetchExercisesFromDatabase();
  }

  Future<List<Exercise>> _fetchExercisesFromDatabase() async {
    final List<Map<String, dynamic>> exerciseMaps =
    await _database.query('exercises', distinct: true, groupBy: 'name');
    return List.generate(exerciseMaps.length, (index) {
      return Exercise(
        id: exerciseMaps[index]['id'],
        name: exerciseMaps[index]['name'],
        calories: exerciseMaps[index]['calories'],
        duration: exerciseMaps[index]['duration'],
      );
    });
  }

  Future<void> addExercise(Exercise exercise) async {
    await _database.insert('exercises', exercise.toMap());
    _exercises.add(exercise);
  }

  Future<void> updateExercise(Exercise exercise) async {
    await _database.update(
      'exercises',
      exercise.toMap(),
      where: 'id = ?',
      whereArgs: [exercise.id],
    );
  }

  List<Exercise> _exercises = [
    Exercise(name: 'Yürüyüş', calories: 150, duration: 0),
    Exercise(name: 'Yüzme', calories: 200, duration: 0),
    Exercise(name: 'Koşu', calories: 250, duration: 0),
    Exercise(name: 'Ip Atlama', calories: 200, duration: 0),
    Exercise(name: 'Squat', calories: 150, duration: 0),
    Exercise(name: 'Bench Press', calories: 200, duration: 0),
    Exercise(name: 'Barfiks', calories: 150, duration: 0),
    Exercise(name: 'Plank', calories: 100, duration: 0),
    Exercise(name: 'Mekik', calories: 100, duration: 0),
    Exercise(name: 'Bisiklet Sürme', calories: 300, duration: 0),
    Exercise(name: 'Basketbol', calories: 250, duration: 0),
    Exercise(name: 'Pilates', calories: 150, duration: 0),
    Exercise(name: 'Tenis', calories: 220, duration: 0),
    Exercise(name: 'Step Aerobik', calories: 200, duration: 0),
    Exercise(name: 'Yoga', calories: 150, duration: 0),
  ];
}