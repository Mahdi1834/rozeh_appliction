import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rozeh_project/features/feature_home/data/model/banners_model.dart';

class BannerSlider extends StatelessWidget {
  final List<Banners> banners;

  const BannerSlider({
    super.key,
    required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) {
      return const SizedBox.shrink();
    }

    final bool infinite = banners.length > 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double height = constraints.maxHeight;

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: CarouselSlider.builder(
            itemCount: banners.length,
            options: CarouselOptions(
              height: height,
              viewportFraction: 1,
              autoPlay: infinite,
              enableInfiniteScroll: infinite,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(
                milliseconds: 800,
              ),
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: false,
              padEnds: false,
            ),
            itemBuilder: (
                BuildContext context,
                int index,
                int realIndex,
                ) {
              final banner = banners[index];

              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: banner.imageUrl!,
                  width: double.infinity,
                  height: height,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Container(
                      width: double.infinity,
                      height: height,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: double.infinity,
                      height: height,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        size: 40,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}