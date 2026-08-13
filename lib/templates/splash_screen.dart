import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;
  const SplashScreen({super.key, required this.nextScreen});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _circleController;
  late AnimationController _iconController;
  late AnimationController _textController;

  late Animation<double> _circleScale;
  late Animation<Offset> _iconOffset;
  late Animation<double> _iconOpacity;
  late Animation<double> _textOpacity;

  String? _versionNumber;

  @override
  void initState() {
    super.initState();
    _loadAppVersion();

    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 600),
    );

    _circleScale = Tween<double>(begin: 0.0, end: 40.0).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeInOut),
    );

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _iconOffset = Tween<Offset>(begin: const Offset(0, -2.5), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _iconController, curve: Curves.bounceOut),
        );

    _iconOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _iconController, curve: Curves.easeIn));

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _startSequencedAnimation();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      // packageInfo.version restituirà ad esempio "1.2.0"
      _versionNumber = packageInfo.version;
    });
  }

  Future<void> _startSequencedAnimation() async {
    await _circleController.forward();
    await Future.delayed(const Duration(microseconds: 100));
    _iconController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    await _textController.forward();
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, _, _) => widget.nextScreen,
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _circleController.dispose();
    _iconController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Center(
            child: AnimatedBuilder(
              animation: _circleScale,
              builder: (context, child) {
                return Transform.scale(
                  scale: _circleScale.value,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SlideTransition(
                  position: _iconOffset,
                  child: FadeTransition(
                    opacity: _iconOpacity,
                    child: Image.asset(
                      'assets/icon/app_icon.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _textOpacity,
                  child: const Text(
                    'Classic Games Hub',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: FadeTransition(
              opacity: _textOpacity,
              child: Text(
                "v $_versionNumber",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
