import 'package:kipsy/features/show_task/presentation/pages/show_houses_view.dart';
import 'package:kipsy/firebase_options.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kipsy/core/themes/theme_manager.dart';
import 'package:kipsy/dependency_container.dart';
import 'package:kipsy/features/show_task/presentation/bloc/show_houses_bloc.dart';
import 'package:kipsy/features/welcome/presentation/pages/welcome_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  await init();

  WidgetsFlutterBinding.ensureInitialized();

  // Obtain shared preferences.
  prefs = await SharedPreferences.getInstance();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? view;

    final bool? repeat = prefs.getBool('passWelcome');

    if (repeat == null || repeat == false) {
      view = const WelcomeView();
    } else {
      view = const ShowHousesView();
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => ShowHousesBloc(
                sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl())
              ..getAllHouses()),
      ],
      child: DynamicTheme(
          builder: (BuildContext conetxt, ThemeData theme) => MaterialApp(
                title: 'Kipsy',
                theme: theme,
                debugShowCheckedModeBanner: false,
                home: view,
              ),
          themeCollection: ThemeCollection(themes: {
            1: ThemeManager.theme,
            0: ThemeManager.darkTheme,
          })),
    );
  }
}
