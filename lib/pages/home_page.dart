
import 'package:flutter/material.dart';

import '../models/banner_item.dart';
import '../services/course_api_service.dart';
import '../widgets/home_banner_carousel.dart';
import 'register_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CourseApiService _courseApiService = CourseApiService();

  late Future<List<BannerItem>> _bannersFuture;

  @override
  void initState() {
    super.initState();
    _bannersFuture = _courseApiService.fetchBanners(limit: 2);
  }

  /// Reloads banner data after a fetch error.
  void _retryBanners() {
    setState(() {
      _bannersFuture = _courseApiService.fetchBanners(limit: 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Courses'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder<List<BannerItem>>(
                future: _bannersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 220,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return SizedBox(
                      height: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Unable to load course banners.'),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            onPressed: _retryBanners,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final banners = snapshot.data ?? [];
                  return HomeBannerCarousel(banners: banners);
                },
              ),
              const SizedBox(height: 28),
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About us',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'We offer practical, instructor-led courses to help you '
                        'build real-world skills. Browse featured courses above, '
                        'then book your seat in a few taps.',
                        style: TextStyle(fontSize: 15, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Book Course',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
