import 'package:expense_tracker/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'drawer_screen.dart';

class OnbardingScreen extends StatefulWidget {
  const OnbardingScreen({super.key});

  @override
  State<OnbardingScreen> createState() => _OnbardingScreenState();
}

class _OnbardingScreenState extends State<OnbardingScreen> {
  late PageController _pageController;
  late final Box settingsBox;

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    settingsBox = Hive.box('launch');
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  pageChange() async {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    if (_pageIndex == onboardItems.length - 1) {
      await settingsBox.put(
          'firstLaunch', false); // firstLaunch değerini false yap
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DrawerScreen(),
        ), // DrawerScreen'e geçiş yap
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: onboardItems.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                    height: onboardItems[index].height,
                    image: onboardItems[index].image,
                    title: onboardItems[index].title,
                    desc: onboardItems[index].desc,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                      onboardItems.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DotIndicator(isActive: index == _pageIndex),
                          )),
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: FilledButton(
                      onPressed: pageChange,
                      child: _pageIndex == onboardItems.length - 1
                          ? const Text('Start using app')
                          : const Text('Next'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
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
    required this.height,
  });

  final String image, title, desc;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: height,
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
  final double height;

  OnboardItem({
    required this.image,
    required this.title,
    required this.desc,
    required this.height,
  });
}

final List<OnboardItem> onboardItems = [
  OnboardItem(
    image: 'assets/images/welcome_icon.jpeg',
    title: 'Welcome To Expense Tracker!',
    height: 300,
    desc:
        'Track your expenses and manage your finances with ease. Our intuitive app helps you stay on top of your spending, set budgets, and achieve your financial goals.',
  ),
  OnboardItem(
    image: 'assets/images/dashboard_screen.png',
    title: 'Visualize Your Financial Insights',
    height: 550,
    desc:
        'Discover a comprehensive view of your financial health with our analysis tools.',
  ),
  OnboardItem(
    image: 'assets/images/expenses_list.png',
    title: 'Effortless Expense Management',
    height: 550,
    desc:
        'Effortlessly manage your finances with our user-friendly Expense Management screen. Add new expenses, edit existing entries, and deleting entries.',
  ),
  OnboardItem(
    image: 'assets/images/filters_screen.png',
    title: 'Refine Your Search with Filters',
    height: 550,
    desc:
        'Enhance your expense tracking experience by utilizing our Filtered Search feature. Find specific expenses quickly and effortlessly by applying filters to your expense list.',
  ),
  OnboardItem(
    image: 'assets/images/settings_screen.png',
    title: 'Customize Your Experience',
    height: 550,
    desc:
        'Make Expense Tracker truly yours with our versatile Settings screen. Personalize your app experience by fine-tuning your preferences, from managing categories to switching to a dark theme.',
  ),
];
