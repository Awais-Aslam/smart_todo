import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/core/constants/app_colors.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/di/injection.dart';
import 'package:smart_todo/core/extensions/context_extension.dart';
import 'package:smart_todo/core/routes/app_routes.dart';
import 'package:smart_todo/core/services/secure_storage_service.dart';
import 'package:smart_todo/l10n/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.delay,
    required this.enableNavigation,
  });

  final Duration delay;
  final bool enableNavigation;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _fadeController;

  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<double> _textSlide;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Initialize animations
    _logoScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _logoRotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));

    _textSlide = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // Start animations
    _startAnimations();

    // Navigate to next screen after delay
    if (widget.enableNavigation) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToNext();
      });
    }
  }

  void _startAnimations() async {
    await _logoController.forward();
    await _textController.forward();
    await _fadeController.forward();
  }

  void _navigateToNext() async {
    await Future.delayed(widget.delay);

    // final user = FirebaseAuth.instance.currentUser;
    final isUserLoggedIn = await getIt<SecureStorageService>().isUserLoggedIn();

    if (!mounted) return;

    if (isUserLoggedIn) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Animation
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _logoScale.value,
                      child: Transform.rotate(
                        angle: _logoRotation.value * 0.1,
                        child: Container(
                          width: AppConstants.containerWidth120,
                          height: AppConstants.containerHeight120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.white,
                                AppColors.lightGrey,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.task_alt_rounded,
                            size: AppConstants.icon64,
                            color: AppColors.blue,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppConstants.spacing40),

                // App Name Animation
                AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _textSlide.value),
                      child: Column(
                        children: [
                          Text(
                            context.appStrings.appTitle,
                            style: context.textTheme.headlineLarge?.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacing8),
                          Text(
                            context.appStrings.onboardingOrganizeLife,
                            style: context.textTheme.titleSmall?.copyWith(
                              color: AppColors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppConstants.spacing64),

                // Loading Animation
                AnimatedBuilder(
                  animation: _fadeController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Column(
                        children: [
                          SizedBox(
                            width: AppConstants.containerWidth32,
                            height: AppConstants.containerHeight32,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacing16),
                          Text(
                            context.appStrings.loading,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
