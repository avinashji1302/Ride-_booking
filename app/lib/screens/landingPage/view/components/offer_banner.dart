import 'package:app/screens/landingPage/model.dart/bannner_model.dart';
import 'package:app/screens/landingPage/viewModel/landing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LandingProvider>();
    final data = controller.allBanner;

    if (data == null || data.list.isEmpty) {
      debugPrint("notnhign.....");
      return const SizedBox(height: 110);
    }

    return SizedBox(
      height: 130,
      child: PageView.builder(
        padEnds: false,
        controller: PageController(viewportFraction: 0.9),
        itemCount: data.list.length,
        itemBuilder: (context, index) {
          return _OfferCard(offer: data.list[index]);
        },
      ),
    );
  }
}

class _OfferCard extends StatefulWidget {
  final BannerModel offer;

  const _OfferCard({required this.offer});

  @override
  State<_OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<_OfferCard> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
     controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            /// ✅ Banner Image
            Image.network(
              widget.offer.file,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: Colors.grey.shade300),
            ),

            /// ✅ Dark Overlay (Premium Look)
            Positioned(
              top: 10,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(.65),
                      Colors.black.withOpacity(.15),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
              ),
            ),

            /// ✅ Content
            Positioned(
              top: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Tag
                  AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, Widget? child) {
                      return ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: [Colors.green, Colors.purple, Colors.white],
                            stops: [
                              controller.value - 0.3,
                              controller.value,
                              controller.value + 0.3,
                            ],
                          ).createShader(bounds);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "SPECIAL OFFER ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 6),

                  // /// Title
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 10,
                  //     vertical: 4,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: Colors.green,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Text(
                  //     offer.title,
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: const TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
