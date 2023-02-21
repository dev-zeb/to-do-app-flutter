import 'package:flutter/material.dart';

import 'package:to_do_app/pages/AddOrEditTasks.dart';
import 'package:to_do_app/pages/StatsPage.dart';
import 'package:to_do_app/pages/SettingsPage.dart';
import 'package:to_do_app/widgets/DrawerItemWithSwitchWidget.dart';
import 'package:to_do_app/widgets/ExitAppDialog.dart';
import 'package:to_do_app/widgets/ToDoListWidget.dart';

const List<Widget> _screens = [
  ToDoListWidget(),
  StatsPage(),
  SettingsPage(),
];
const List<String> _pageTitles = [
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
        if (_selectedIndex == homePageIndex) {
          showDialog(
            context: context,
            builder: (context) {
              return const ExitAppDialog();
            },
          );
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
            floatingActionButton: _selectedIndex == homePageIndex
                ? FloatingActionButton(
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
                  )
                : null,
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Image.asset("assets/images/to_do_app_logo.png",
                      height: 132, width: 132),
                  const Text(
                    "To Do App",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.orange,
                  ),
                  DrawerItemWithSwitchWidget(
                    optionName: "Dark Theme",
                    isSelected: false,
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.orange,
                  ),
                  DrawerItemWithSwitchWidget(
                    optionName: "App Sound",
                    isSelected: false,
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.orange,
                  ),
                  DrawerItemWithSwitchWidget(
                    optionName: "Notification",
                    isSelected: false,
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
