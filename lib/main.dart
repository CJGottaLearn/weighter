import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provier;
import 'package:weighter/models/exercise.dart';
import 'package:weighter/models/workout.dart';
import 'package:weighter/services/hive_database.dart';
import 'package:weighter/pages/home.dart';
import 'package:weighter/constants/styles.dart';
import 'package:weighter/models/database_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provier.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  await DatabaseRepository().openBoxs();
  // runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          accentColor: kAccentColor,
          fontFamily: 'Roboto',
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          )),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }

  @override
  void dispose() {
    HiveDatabase().closeHive();
    super.dispose();
  }
}
