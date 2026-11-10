import 'package:flutter/material.dart';

import '../models/course.dart';
import 'horizontal_carousel_scroll_behavior.dart';

/// Horizontal course slider with single-selection highlighting.
class SelectableCourseCarousel extends StatefulWidget {
  /// Creates a selectable carousel bound to [courses] and [selectedCourse].
  const SelectableCourseCarousel({
    super.key,
    required this.courses,
    required this.selectedCourse,
    required this.onCourseSelected,
  });

  /// All courses from the API.
  final List<Course> courses;

  /// Currently selected course, if any.
  final Course? selectedCourse;

  /// Called when the user selects a course (tap or swipe).
  final ValueChanged<Course> onCourseSelected;

  @override
  State<SelectableCourseCarousel> createState() =>
      _SelectableCourseCarouselState();
}

class _SelectableCourseCarouselState extends State<SelectableCourseCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.48);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.courses.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text('No courses available')),
      );
    }

    final theme = Theme.of(context);

    return SizedBox(
      height: 260,
      child: ScrollConfiguration(
        behavior: HorizontalCarouselScrollBehavior(),
        child: PageView.builder(
          controller: _pageController,
          clipBehavior: Clip.none,
          padEnds: false,
          itemCount: widget.courses.length,
          onPageChanged: (index) {
            widget.onCourseSelected(widget.courses[index]);
          },
          itemBuilder: (context, index) {
            final course = widget.courses[index];
            final isSelected = widget.selectedCourse?.id == course.id;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  widget.onCourseSelected(course);
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Card(
                  elevation: isSelected ? 6 : 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                course.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    ColoredBox(
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.menu_book, size: 48),
                                ),
                              ),
                              if (isSelected)
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: theme.colorScheme.primary,
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Expanded(
                                child: Text(
                                  course.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
