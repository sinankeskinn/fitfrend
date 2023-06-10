import 'package:fitfrend/giris.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class girisekrani extends StatefulWidget {
  @override
  _girisekraniState createState() => _girisekraniState();
}

class _girisekraniState extends State<girisekrani>
with SingleTickerProviderStateMixin {
late AnimationController _animationController;
late Animation<double> _slideAnimation;

List<String> welcomeWords = [
  'FitFrend',
  'Uygulamasına',
  'Hoş',
  'Geldiniz!',
];
int currentWordIndex = 0;

@override
void initState() {
  super.initState();

  _animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  _slideAnimation = Tween<double>(begin: -100, end: 0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ),
  );

  _animationController.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      // Animasyon tamamlandığında bir sonraki kelimeye geç
      goToNextWord();
    }
  });

  _animationController.forward();
}

@override
void dispose() {
  _animationController.dispose();
  super.dispose();
}

String getCurrentWord() {
  return welcomeWords[currentWordIndex];
}

void goToNextWord() {
  setState(() {
    currentWordIndex = (currentWordIndex + 1) % welcomeWords.length;
    _animationController.reset();
    _animationController.forward();
  });
}

@override
Widget build(BuildContext context) {
  return AnimatedBuilder(
    animation: _animationController,
    builder: (context, child) {
      return Row(
        children: [
          for (int i = 0; i <= currentWordIndex; i++)
            Text(
              '${welcomeWords[i]} ',
              style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
            ),
        ],
      );
    },
  );
}
}

class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: child,
        );
      },
      child: Container(
        width: 150,
        height: 150,
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    });

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.amber[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedLogo(),
            SizedBox(height: 20),
            girisekrani(),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}