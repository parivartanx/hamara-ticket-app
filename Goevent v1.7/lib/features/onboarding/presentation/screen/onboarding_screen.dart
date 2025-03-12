import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import '/utils/string.dart';
import 'package:page_transition/page_transition.dart';

import '../../../login/presentation/screens/login.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  static const routePath = '/onboarding';                                                                                                                                                                                             
  static const routeName = 'onboarding';
  const OnboardingScreen({Key? key}) : super(key: key); 
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends ConsumerState<OnboardingScreen> {
  static const int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return ScreenUtilInit(
      builder: (context, child) => Scaffold(
        backgroundColor: colorScheme.background,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: OnboardingPageView(
                    pageController: _pageController,
                    onPageChanged: (page) => setState(() => _currentPage = page),
                  ),
                ),
                OnboardingBottomBar(
                  currentPage: _currentPage,
                  numPages: _numPages,
                  pageController: _pageController,
                  onSkip: () => _navigateToLogin(context),
                  onNext: () => _handleNextButton(),
                  onStart: () => _navigateToLogin(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNextButton() {
    if (_currentPage < _numPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _navigateToLogin(BuildContext context) {
    context.pushReplacementNamed(Login.routeName);
  }
}

class OnboardingPageView extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  const OnboardingPageView({
    Key? key,
    required this.pageController,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const ClampingScrollPhysics(),
      controller: pageController,
      onPageChanged: onPageChanged,
      children: const [
        OnboardingPage(
          imagePath: "assets/image/onbonding1.png",
          title: CustomStrings.onbonding1,
          subtitle: CustomStrings.onbonding2,
          description: "In publishing and graphic design, Lorem is\na placeholder text commonly",
        ),
        OnboardingPage(
          imagePath: "assets/image/onbonding2.png",
          title: "Web Have Modern Events",
          subtitle: "Calendar Feature",
          description: "In publishing and graphic design, Lorem is\na placeholder text commonly",
        ),
        OnboardingPage(
          imagePath: "assets/image/onbonding3.png",
          title: "To Look Up More Events or",
          subtitle: "Activities Nearby By Map",
          description: "In publishing and graphic design, Lorem is\na placeholder text commonly",
        ),
      ],
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String description;

  const OnboardingPage({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Stack(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
         Image.asset(
          imagePath,
          fit: BoxFit.fill,
          height: context.height *.67,
          width: context.width,
        ),
        ],),
        
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: context.width  ,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(50),
              ),
            ),
            height: context.height *.23,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: context.height / 30),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Gilroy Medium',
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onPrimary,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Gilroy Medium',
                      color: colorScheme.onPrimary,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: context.height / 30),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Gilroy Medium',
                      color: colorScheme.onPrimary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OnboardingBottomBar extends StatelessWidget {
  final int currentPage;
  final int numPages;
  final PageController pageController;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onStart;

  const OnboardingBottomBar({
    Key? key,
    required this.currentPage,
    required this.numPages,
    required this.pageController,
    required this.onSkip,
    required this.onNext,
    required this.onStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isLastPage = currentPage == numPages - 1;

    return Container(
      height: context.height / 11,
      color: colorScheme.primary,
      child: Align(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OnboardingButton(
                label: 'Skip',
                onTap: onSkip,
                colorScheme: colorScheme,
              ),
              OnboardingPageIndicators(
                currentPage: currentPage,
                numPages: numPages,
                colorScheme: colorScheme,
              ),
              OnboardingButton(
                label: isLastPage ? 'Start' : 'Next',
                onTap: isLastPage ? onStart : onNext,
                colorScheme: colorScheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const OnboardingButton({
    Key? key,
    required this.label,
    required this.onTap,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        height: context.height / 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Gilroy Medium',
                color: colorScheme.onPrimary,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingPageIndicators extends StatelessWidget {
  final int currentPage;
  final int numPages;
  final ColorScheme colorScheme;

  const OnboardingPageIndicators({
    Key? key,
    required this.currentPage,
    required this.numPages,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        numPages,
        (index) => OnboardingPageIndicator(
          isActive: index == currentPage,
          colorScheme: colorScheme,
        ),
      ),
    );
  }
}

class OnboardingPageIndicator extends StatelessWidget {
  final bool isActive;
  final ColorScheme colorScheme;

  const OnboardingPageIndicator({
    Key? key,
    required this.isActive,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive 
            ? colorScheme.onPrimary 
            : colorScheme.onPrimary.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
