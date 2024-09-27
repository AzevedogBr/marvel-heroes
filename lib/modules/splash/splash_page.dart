import 'package:flutter/material.dart';

import '../../shared/analytics/analytics.dart';
import '../home/presentation/presentation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final AnalyticsService analyticsUseCase = AnalyticsServiceImpl();
  @override
  void initState() {
    analyticsUseCase
        .sendAnalyticsEvent('screen_view', {"id": '12345', 'screen': 'splash'});
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202020),
      body: Center(
        child: Image.asset(
          'assets/images/marvel_logo1.png',
        ),
      ),
    );
  }
}
