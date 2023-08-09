import 'package:expense_tracker/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class OnbardingScreen extends StatefulWidget {
  const OnbardingScreen({super.key});

  @override
  State<OnbardingScreen> createState() => _OnbardingScreenState();
}

class _OnbardingScreenState extends State<OnbardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: onboardItems.length,
                controller: _pageController,
                itemBuilder: (context, index) => OnboardContent(
                  image: onboardItems[index].image,
                  title: onboardItems[index].title,
                  desc: onboardItems[index].desc,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: FilledButton(
                onPressed: () {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                child: const Text('Next'),
              ),
            ),
            const SizedBox(
              height: 75,
            )
          ],
        ),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  final String image, title, desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 350,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.normal, color: Colors.grey[500]),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class OnboardItem {
  final String image, title, desc;

  OnboardItem({
    required this.image,
    required this.title,
    required this.desc,
  });
}

final List<OnboardItem> onboardItems = [
  OnboardItem(
    image: 'assets/images/welcome_icon.jpeg',
    title: 'sa!',
    desc:
        'Track your expenses and manage your finances with ease. Our intuitive app helps you stay on top of your spending, set budgets, and achieve your financial goals.',
  ),
  OnboardItem(
    image: 'assets/images/welcome_icon.jpeg',
    title: 'as!',
    desc:
        'Track your expenses and manage your finances with ease. Our intuitive app helps you stay on top of your spending, set budgets, and achieve your financial goals.',
  ),
  OnboardItem(
    image: 'assets/images/welcome_icon.jpeg',
    title: 'sa!',
    desc:
        'Track your expenses and manage your finances with ease. Our intuitive app helps you stay on top of your spending, set budgets, and achieve your financial goals.',
  ),
  OnboardItem(
    image: 'assets/images/welcome_icon.jpeg',
    title: 'as!',
    desc:
        'Track your expenses and manage your finances with ease. Our intuitive app helps you stay on top of your spending, set budgets, and achieve your financial goals.',
  ),
  OnboardItem(
    image: 'assets/images/welcome_icon.jpeg',
    title: 'sa!',
    desc:
        'Track your expenses and manage your finances with ease. Our intuitive app helps you stay on top of your spending, set budgets, and achieve your financial goals.',
  ),
];
