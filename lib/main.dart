import 'package:flutter/material.dart';
import 'package:exp/expenses.dart';
import 'package:flutter/services.dart';

var kcolorscheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 101, 14, 138),
);

var kDarkscheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 9, 125),
    brightness: Brightness.dark);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((fn){runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkscheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkscheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkscheme.primaryContainer,
              foregroundColor: kDarkscheme.onPrimaryContainer),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorscheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolorscheme.onPrimaryContainer,
            foregroundColor: kcolorscheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: kcolorscheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kcolorscheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  color: kcolorscheme.onSecondaryContainer,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
      ),
      // themeMode: ThemeMode.dark,
      home: const Expenses(),
    ),
  );});
  
}
