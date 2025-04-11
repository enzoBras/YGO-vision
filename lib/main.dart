import 'package:flutter/material.dart';
import 'package:ygo_vision/views/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(const YGOVision());
}

class YGOVision extends StatelessWidget {
  const YGOVision({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YGO Vision',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
      ],
      debugShowCheckedModeBanner: false,
      builder: (context, child) =>
          MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
      home: const HomePage(title: 'YGO Vision'),
    );
  }
}
