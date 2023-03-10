import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Scheduler',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Scheduler'),
      ),
      body: ListView.builder(
        itemCount: _days.length,
        itemBuilder: (context, index) {
          final day = _days[index];
          return ListTile(
            title: Text(day),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MealsScreen(day: day),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MealsScreen extends StatefulWidget {
  final String day;

  const MealsScreen({Key? key, required this.day}) : super(key: key);

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final _breakfastMeals = <Meal>[];
  final _dinnerMeals = <Meal>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.day),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Breakfast', style: Theme.of(context).textTheme.headline5),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _breakfastMeals.length,
            itemBuilder: (context, index) {
              final meal = _breakfastMeals[index];
              return ListTile(
                title: Text(meal.name),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showEditMealDialog(context, meal);
                  },
                ),
                onLongPress: () {
                  _showDeleteMealDialog(context, meal);
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Dinner', style: Theme.of(context).textTheme.headline5),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _dinnerMeals.length,
            itemBuilder: (context, index) {
              final meal = _dinnerMeals[index];
              return ListTile(
                title: Text(meal.name),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showEditMealDialog(context, meal);
                  },
                ),
                onLongPress: () {
                  _showDeleteMealDialog(context, meal);
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('Add Meal'),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: Text('Add Breakfast'),
                            onPressed: () {
                              Navigator.pop(context);
                              _showAddMealDialog(context, meals: _breakfastMeals);
                            },
                          ),
                          TextButton(
                            child: Text('Add Dinner'),
                            onPressed: () {
                              Navigator.pop(context);
                              _showAddMealDialog(context, meals: _dinnerMeals);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     _showAddMealDialog(context, meals: []);
      //   },
      // ),
    );
  }

  // function to show a dialog to add a new meal
  void _showAddMealDialog(BuildContext context, {required List<Meal> meals}) {
    final mealNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Meal'),
          content: TextField(
            controller: mealNameController,
            decoration: const InputDecoration(hintText: 'Meal name'),
            onSubmitted: (value) {
            // add the new meal to the list of meals
            final meal = Meal(value);
            setState(() {
              meals.add(meal);
            });
            Navigator.pop(context);
          },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                // add the new meal to the list of meals
                final meal = Meal(mealNameController.text);
                setState(() {
                  meals.add(meal);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // function to show a dialog to edit a meal
  void _showEditMealDialog(BuildContext context, Meal meal) {
    final mealNameController = TextEditingController(text: meal.name);
    showDialog(
      context: context,
      builder: (context) {
        var actions2 = <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                setState(() {
                  meal.name = mealNameController.text;
                });
                Navigator.pop(context);
              },
            ),
          ];
        return AlertDialog(
          title: const Text('Edit Meal'),
          content: TextField(
            controller: mealNameController,
            decoration: const InputDecoration(hintText: 'Meal name'),
            onSubmitted: (value) {
              // add the new meal to the list of meals
              setState(() {
                meal.name = value;
              });
              Navigator.pop(context);
            },
          ),
          actions: actions2,
        );
      },
    );
  }

  // function to show a dialog to delete a meal
  void _showDeleteMealDialog(BuildContext context, Meal meal) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Meal'),
          content: const Text('Are you sure you want to delete this meal?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  _breakfastMeals.remove(meal);
                  _dinnerMeals.remove(meal);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class Meal {
  String name;

  Meal(this.name);
}

// class Meal {
//   String name;

//   Meal(this.name);

//   setName(String newName) {
//     name = newName;
//   }
// }