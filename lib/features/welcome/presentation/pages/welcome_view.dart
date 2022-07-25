import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/features/show_task/presentation/pages/show_houses_view.dart';
import 'package:kipsy/features/welcome/presentation/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorManager.blue,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Image.asset(
              'assets/images/graph.png',
              scale: 2,
            ),
            top: -80,
            right: -0,
          ),
          Positioned(
            child: Image.asset(
              'assets/images/graph.png',
              scale: 2,
            ),
            left: -120,
            top: screenHeight / 2,
          ),
          Positioned(
            child: Image.asset(
              'assets/images/graph.png',
              scale: 2,
            ),
            right: -70,
            top: screenHeight - 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/graph.png',
                    ),
                    Lottie.asset('assets/images/task.json'),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Welcome to',
                      style: TextStyle(color: ColorManager.white, fontSize: 20),
                    ),
                    Text(
                      'Kipsy'.toUpperCase(),
                      style: const TextStyle(
                          color: ColorManager.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 60),
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Get Started',
                  fontColor: ColorManager.white,
                  onTap: () async {
                    // Obtain shared preferences.
                    final prefs = await SharedPreferences.getInstance();

                    // Save an boolean value to 'repeat' key.
                    await prefs.setBool('passWelcome', true);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const ShowHousesView(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
