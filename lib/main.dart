import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Scheduler',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Food Scheduler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _meals = <Meal>[]; // The list of meals

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _meals.length,
        itemBuilder: (context, index) {
          final meal = _meals[index];
          return ListTile(
            title: Text(meal.name),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // code to edit the meal
                _showEditMealDialog(context, meal);
              },
            ),
            onLongPress: () {
              // code to delete the meal
              _showDeleteMealDialog(context, meal);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddMealDialog(context);
        },
        tooltip: 'Add Meal',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // function to show a dialog to add a new meal
  void _showAddMealDialog(BuildContext context) {
    final mealNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Meal'),
          content: TextField(
            controller: mealNameController,
            decoration: InputDecoration(hintText: 'Meal name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                // add the new meal to the list of meals
                final meal = Meal(mealNameController.text);
                setState(() {
                  _meals.add(meal);
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
        return AlertDialog(
          title: Text('Edit Meal'),
          content: TextField(
            controller: mealNameController,
            decoration: InputDecoration(hintText: 'Meal name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // update the meal with the new name
                setState(() {
                  meal.name = mealNameController.text;
                });
                Navigator.pop(context);
              },
            ),
          ],
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
          title: Text('Delete Meal'),
          content: Text('Are you sure you want to delete this meal?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                // remove the meal from the list of meals
                setState(() {
                  _meals.remove(meal);
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

  setName(String newName) {
    name = newName;
  }
}
