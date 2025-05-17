import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../common/theme/app/app_colors.dart';

class PostNetworkImageListView extends StatelessWidget {
  final List<String> imageUrls;

  const PostNetworkImageListView({
    super.key,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        Widget image = Image.network(
          imageUrls[index],
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _loadingIndicator();
          },
          errorBuilder: (context, error, stackTrace) =>
              Container(color: AppColors.gray150),
        );
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () =>
                  Navigator.of(context).push(
                    MaterialPageRoute(fullscreenDialog: true, builder: (context) =>
                        _PostNetworkImageSlider(
                            imageUrls: imageUrls, initialIndex: index))),
          child: Container(
            width: 120,
            height: 120,
            decoration: ShapeDecoration(
              color: AppColors.gray100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: image
            ),
          ),
        )
        ,
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Container(
      color: AppColors.gray150,
      child: Center(
        child: Transform.scale(
          scale: 0.6,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.gray600,
          ),
        ),
      ),
    );
  }
}

class _PostNetworkImageSlider extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const _PostNetworkImageSlider({
    required this.imageUrls,
    required this.initialIndex,
  });

  @override
  State<_PostNetworkImageSlider> createState() =>
      _PostNetworkImageSliderState();
}

class _PostNetworkImageSliderState extends State<_PostNetworkImageSlider> {
  int currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.black,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          CarouselSlider.builder(
            carouselController: _controller,
            itemCount: widget.imageUrls.length,
            options: CarouselOptions(
              initialPage: currentIndex,
              height: double.infinity,
              viewportFraction: 1.0, // 한 사진이 화면 모두 차지
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return _PostNetworkImageView(imageUrl: widget.imageUrls[index]);
            },
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '${currentIndex + 1} / ${widget.imageUrls.length}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.white),
              ),
            ),
          ),
          Positioned(
            top: 46,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostNetworkImageView extends StatelessWidget {
  final String imageUrl;

  const _PostNetworkImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          },
          errorBuilder: (context, error, stackTrace) =>
              Container(color: Colors.grey.shade800),
        ),
      ),
    );
  }
}
