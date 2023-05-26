import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/entities/carousel_item.dart';
import 'package:secure_gates_project/entities/home_page_card_item.dart';
import 'package:secure_gates_project/services/auth_service.dart';
import 'package:secure_gates_project/services/dashboard_data_service.dart';
import 'package:secure_gates_project/widgets/home_page_card.dart';

final carouselDataProvider =
    FutureProvider.autoDispose<List<CarouselItem>>((ref) async {
  final data = ref.watch(dashboardServiceProvider);
  final items = data.getCarouselItems();

  return items;
});

final featuresDataProvider =
    FutureProvider.autoDispose<List<HomePageCardItem>>((ref) async {
  final data = ref.watch(dashboardServiceProvider);
  final cards = data.getHomePageCards();

  return cards;
});

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final carouselData = ref.watch(carouselDataProvider);
    final featureData = ref.watch(featuresDataProvider);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: size.width,
            decoration: const BoxDecoration(
              color: Color(0xFF7553F6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 10),
                  child: Text(
                    "Secure Gates",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 10),
                  child: IconButton(
                      onPressed: () async {
                        await ref.read(authServiceProvider).signOut();
                      },
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello! Username",
                  style: GoogleFonts.montserrat(
                    fontSize: 27,
                  ),
                ),
                Text(
                  "Welcome to the cenetral park society, Jhasi",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          carouselData.when(
              data: (data) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        height: 180,
                        autoPlay: true,
                        autoPlayInterval: const Duration(
                          seconds: 6,
                        )),
                    items: data.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFF9CC5FF),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.bannerImage,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) {
                return Text(e.toString());
              }),
          const SizedBox(
            height: 20,
          ),
          featureData.when(
              data: (data) {
                return Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: data
                              .sublist(0, 3)
                              .map((item) => Expanded(
                                    child: HomePageCard(
                                        featureText: item.featureName,
                                        image: item.featureIcon),
                                  ))
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: data
                              .sublist(3, 6)
                              .map((item) => Expanded(
                                    child: HomePageCard(
                                        featureText: item.featureName,
                                        image: item.featureIcon),
                                  ))
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: SizedBox(
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: data
                                .sublist(6, 7)
                                .map((item) => Expanded(
                                      child: HomePageCard(
                                          featureText: item.featureName,
                                          image: item.featureIcon),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) {
                return Text(e.toString());
              }),
        ],
      ),
    );
  }
}
