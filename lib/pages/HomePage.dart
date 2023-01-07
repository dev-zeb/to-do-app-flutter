import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/pages/AddOrEditTasks.dart';
import 'package:to_do_app/pages/StatsPage.dart';
import 'package:to_do_app/pages/SettingsPage.dart';
import 'package:to_do_app/widgets/ToDoList.dart';

const List<Widget> _screens = [
  ToDoList(),
  StatsPage(),
  SettingsPage(),
];
const List<String> _pageTitles =  [
  "To Do App",
  "Stats",
  "Settings",
];

const homePageIndex = 0;
const statsPageIndex = 1;
const settingsPageIndex = 2;

class ToDoApp extends StatefulWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(_selectedIndex == homePageIndex) {
          showDialog(context: context, builder: (context) {
            return SizedBox(
              height: 300,
              width: 240,
              child: AlertDialog(
                actions: [
                  InkWell(
                    child: const Text("Yes"),
                    onTap: () {
                      SystemNavigator.pop();
                    },
                  ),
                  InkWell(
                    child: const Text("No"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
                title: const Text("Exit App?"),
              ),
            );
          });
        } else {
          setState(() {
            _selectedIndex = homePageIndex;
          });
        }
        return false;
      },
      child: MaterialApp(
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
                  icon: Icon(Icons.query_stats),
                  label: "Stats",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
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
            floatingActionButton: _selectedIndex == homePageIndex ? FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              onPressed: () {
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
            ) : null,
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
      ),
    );
  }
}
