import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:to_do_app/pages/HomePage.dart';
import 'package:to_do_app/providers/DataProvider.dart';

void main() {
  /**
      // The following 2 statements are to Hide the Status Bar of the Phone
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom, //This line is used for showing the bottom bar
      // SystemUiOverlay.top // Uncomment this to show the Status bar again
      ]);
   */

  runApp(
    ChangeNotifierProvider(
      create: (_) => DataProvider(),
      child: const MaterialApp(
        home: ToDoApp(),
      ),
    ),
  );
}
