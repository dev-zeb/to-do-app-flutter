import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/pages/AddOrEditTaks.dart';
import 'package:to_do_app/pages/CategoryPage.dart';
import 'package:to_do_app/pages/FinishedPage.dart';
import 'package:to_do_app/providers/DataProvider.dart';
import 'package:to_do_app/widgets/ToDoList.dart';

List<Widget> _screens = const [
  ToDoList(),
  CategoryPage(),
  FinishedPage(),
];
List<String> _pageTitles = const [
  "To Do App",
  "Categories",
  "Finished",
];

class ToDoApp extends StatefulWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            elevation: 0.0,
            title: Text(_pageTitles[_selectedIndex]),
          ),
          body: _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive),
                label: "Progress",
              ),
            ],
            onTap: (index) {
              if (index != _selectedIndex) {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            selectedItemColor: Colors.deepOrange,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            onPressed: () {
              ///TODO: Implement this functionality
              // Navigator.of(context).pushNamed("AddOrEditTask");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AddOrEditTask(isNewTask: true, task: null),
                ),
              );
              // context.read<DataProvider>().addNewTask();
            },
            child: const Icon(
              Icons.add,
              size: 48,
            ),
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              children: const [
                Text("To Do App"),
                Text("Profile"),
                Text("Settings"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
