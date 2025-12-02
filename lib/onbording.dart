import 'package:flutter/material.dart';
import 'package:task18_iti/screens/home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/fast.png",
      "title": "Fresh Meals",
      "subtitle":
          "Discover fresh, healthy meals delivered straight to your door.",
    },
    {
      "image": "assets/images/delivery1.png",
      "title": "Quick Delivery",
      "subtitle": "Get your meals delivered quickly and conveniently.",
    },
    {
      "image": "assets/images/order.png",
      "title": "Start Today!",
      "subtitle": "Start your culinary journey with us today!",
    },
  ];

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // PageView
          PageView.builder(
            controller: _controller,
            itemCount: _onboardingData.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (_, index) {
              final data = _onboardingData[index];
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(data["image"]!, height: 250),
                    const SizedBox(height: 30),
                    Text(
                      data["title"]!,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      data["subtitle"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Indicators + Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => Container(
                      margin: const EdgeInsets.all(4),
                      width: _currentIndex == index ? 12 : 8,
                      height: _currentIndex == index ? 12 : 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.orange
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_currentIndex == _onboardingData.length - 1) {
                      _goToHome();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    _currentIndex == _onboardingData.length - 1
                        ? "Start"
                        : "Next",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),

          // Skip Button
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: _goToHome,
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.orange, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
