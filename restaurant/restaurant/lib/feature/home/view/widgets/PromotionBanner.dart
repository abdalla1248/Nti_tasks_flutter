import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/feature/home/data/model/sliders_model.dart';
import 'package:shimmer/shimmer.dart';

class PromotionBanner extends StatefulWidget {
  final SlidersModel? sliders;
  final bool isLoading;

  const PromotionBanner({
    super.key,
    required this.sliders,
    required this.isLoading,
  });

  @override
  State<PromotionBanner> createState() => _PromotionBannerState();
}

class _PromotionBannerState extends State<PromotionBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _buildLoadingShimmer();
    }

    final sliderList = widget.sliders?.sliders ?? [];

    return Column(
      children: [
        // Banner
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 140,
          decoration: BoxDecoration(
            color: const Color(0xFFFF5722),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: sliderList.isNotEmpty
                ? PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: sliderList.length,
                    itemBuilder: (context, index) {
                      final slider = sliderList[index];
                      return CachedNetworkImage(
                        imageUrl: slider.imagePath ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'images/pizza.jpg',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  )
                : Image.asset(
                    'images/pizza.jpg',
                    fit: BoxFit.cover,
                  ),
          ),
        ),

        // Rectangular Indicator ("--- --- ---")
        if (sliderList.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              sliderList.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                height: 6,
                width: _currentPage == index ? 20 : 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _currentPage == index
                      ? Colors.orange
                      : Colors.orange.withOpacity(0.4),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
