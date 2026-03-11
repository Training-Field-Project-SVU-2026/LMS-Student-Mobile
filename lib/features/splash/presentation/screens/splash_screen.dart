import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _nameFadeAnimation;
  late Animation<double> _descFadeAnimation;
  late Animation<double> _exitAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.4, curve: Curves.easeOutBack),
      ),
    );

    _nameFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.35, 0.65, curve: Curves.easeIn),
      ),
    );

    _descFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.55, 0.85, curve: Curves.easeIn),
      ),
    );

    _exitAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.9, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    Future.delayed(Duration(milliseconds: 4200), () {
      if (mounted) {
        context.go(AppRoutes.homeScreen);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A5C75),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _logoFadeAnimation.value * _exitAnimation.value,
                  child: Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage('assets/images/splash2.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 30),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _nameFadeAnimation.value * _exitAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - _nameFadeAnimation.value)),
                    child: Text(
                      'البرنامج الى لسه مش عارفينله اسم ده ',
                      style: context.textTheme.headlineMedium!.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 15),

            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _descFadeAnimation.value * _exitAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - _descFadeAnimation.value)),
                    child: Text(
                      'المهم البرنامج ده فيه بشمهندس قِرانى فانت هتكون فل الفل فى اى تراك سجل وانت مطمئن يا بطل 😘😁',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontSize: 18,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 5,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
