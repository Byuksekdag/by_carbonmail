import 'package:by_carbonmail/feature/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:by_carbonmail/products/text/app_texts.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => SsplashViewState();
}

class SsplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splash_background.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              _buildText(context),
              SizedBox(
                height: context.dynamicHeight(0.4),
              ),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildButton() {
    return SizedBox(
      width: 220,
      height: 60,
      child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeView()));
          },
          label: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
          ),
          icon: Text(
            AppTexts().buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)))),
    );
  }

  Column _buildText(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: context.dynamicHeight(0.2),
      ),
      Text(AppTexts().splashTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3),
      context.emptySizedHeightBoxLow3x,
      SizedBox(
        width: 245,
        child: Text(AppTexts().splashDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium),
      ),
    ]);
  }
}
