import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';

class CustomCardSlider extends StatefulWidget {
  const CustomCardSlider({super.key});

  @override
  CustomCardSliderState createState() => CustomCardSliderState();
}

class CustomCardSliderState extends State<CustomCardSlider> {
  int _currentIndex = 0;

  final List<String> imageUrls = [
    AppImages.slider1,
    AppImages.slider2,
    AppImages.slider3,
    AppImages.slider4,
    AppImages.slider5,
  ];

  final List<Widget> _icons = [
    const Icon(Icons.power, color: Colors.black, size: 30),
  ];

  final String title = "Image Title";
  final String description = "This is a description of the image.";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              CarouselSlider(
                items: imageUrls.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          // Image
                          Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context)
                                .size
                                .width, // Ensure image takes full width
                          ),
                          // Icons positioned over the image
                          Positioned(
                            left: 10,
                            bottom: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                              ),
                              child: Row(
                                children: _icons,
                              ),
                            ),
                          ),
                          // Title and description
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  // Ensures only one image is shown at a time
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              // Left arrow
              Positioned(
                left: 280,
                top: 0,
                bottom: 180,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 30),
                  onPressed: () {
                    setState(() {
                      _currentIndex = (_currentIndex - 1) % imageUrls.length;
                    });
                  },
                ),
              ),
              // Right arrow
              Positioned(
                right: 60,
                top: 0,
                bottom: 180,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: Colors.white, size: 30),
                  onPressed: () {
                    setState(() {
                      _currentIndex = (_currentIndex + 1) % imageUrls.length;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
