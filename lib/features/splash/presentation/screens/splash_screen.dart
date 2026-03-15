import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_student/core/extensions/context_extensions.dart';
import 'package:lms_student/core/routing/app_routes.dart';
import 'package:lms_student/core/localization/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:lms_student/features/splash/presentation/bloc/splash_event.dart';
import 'package:lms_student/features/splash/presentation/bloc/splash_state.dart';
import 'package:lms_student/features/splash/presentation/screens/widgets/custom_error_popup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _nameFadeAnimation;
  late Animation<double> _descFadeAnimation;
  late Animation<double> _exitAnimation;

  bool _isDataReady = false;
  SplashState? _finalState;

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

    _controller.animateTo(0.85).then((_) {
      if (_isDataReady && _finalState != null) {
        _controller.forward().then((_) {
          if (mounted) _handleNavigation(context, _finalState!);
        });
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
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded || state is SplashError) {
          _isDataReady = true;
          _finalState = state;

          if (!_controller.isAnimating) {
            if (_controller.value < 1.0) {
              _controller.forward().then((_) {
                if (mounted) _handleNavigation(context, state);
              });
            } else {
              _handleNavigation(context, state);
            }
          }
        }
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.primary,
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
                        width: 150.w,
                        height: 150.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.3,
                              ),
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
                        context.tr('splash_title'),
                        style: context.textTheme.headlineMedium!.copyWith(
                          color: context.colorScheme.onPrimary,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.3,
                              ),
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
                        context.tr('splash_desc'),
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colorScheme.onPrimary,
                          fontSize: 18,
                          shadows: [
                            Shadow(
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.2,
                              ),
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
      ),
    );
  }

  void _handleNavigation(BuildContext context, SplashState state) {
    if (state is SplashLoaded) {
      context.go(AppRoutes.rootAfterLogin);
    } else if (state is SplashError) {
      if (state.message != null && state.message!.isNotEmpty) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => CustomErrorPopup(
            title: context.tr('error'),
            message: state.message!,
            onRetry: () {
              context.pop();
              _isDataReady = false;
              _finalState = null;
              _controller.reset();
              _controller.animateTo(0.85).then((_) {
                if (_isDataReady && _finalState != null) {
                  _controller.forward().then((_) {
                    if (mounted) _handleNavigation(context, _finalState!);
                  });
                }
              });
              context.read<SplashBloc>().add(SplashStarted());
            },
          ),
        );
      } else {
        String msg = context.tr('authentication_failed');
        if (state.message == "No token found") {
          msg = context.tr('no_token_found');
        } else if (state.message == "Session expired") {
          msg = context.tr('session_expired');
        } else if (state.isActive == false) {
          msg = context.tr('account_inactive');
        } else if (state.isVerified == false) {
          msg = context.tr('account_unverified');
        }
        if (msg != context.tr('authentication_failed')) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(msg)));
        }
        context.go(AppRoutes.loginScreen);
      }
    }
  }
}
