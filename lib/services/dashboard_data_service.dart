import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/controller/user_controller.dart';
import 'package:secure_gates_project/entities/carousel_item.dart';
import 'package:secure_gates_project/entities/home_page_card_item.dart';
import 'package:secure_gates_project/entities/visitor.dart';
import 'package:secure_gates_project/general_providers.dart';

import '../custom_exception.dart';

final dashboardServiceProvider = Provider<DashboardDataService>((ref) {
  final generalPathUrl = ref.read(generalUrlPathProvider);
  return DashboardDataService(
    ref,
    generalPathUrl,
  );
});

abstract class BaseDashboardDataService {
  Future<List<CarouselItem>> getCarouselItems();
  Future<List<HomePageCardItem>> getHomePageCards();
  Future<List<Visitor>> getLastThreeVisitors();
}

class DashboardDataService implements BaseDashboardDataService {
  final Dio _dio = Dio();
  final String generalPath;
  final Ref ref;

  DashboardDataService(this.ref, this.generalPath);

  @override
  Future<List<CarouselItem>> getCarouselItems() async {
    try {
      final response = await _dio.get("$generalPath/banner.php");

      final results = List<Map<String, dynamic>>.from(response.data);

      List<CarouselItem> items = results
          .map((carouselData) => CarouselItem.fromMap(carouselData))
          .toList(growable: false);

      return items;
    } catch (e) {
      throw CustomExeption(message: e.toString());
    }
  }

  @override
  Future<List<HomePageCardItem>> getHomePageCards() async {
    try {
      final data = FormData.fromMap({'soc': 'CP'});
      final response = await _dio.post(
        "$generalPath/dashboard.php",
        data: data,
      );

      final results = List<Map<String, dynamic>>.from(response.data);

      List<HomePageCardItem> cards = results
          .map((cardData) => HomePageCardItem.fromMap(cardData))
          .toList(growable: false);

      return cards;
    } on DioException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<List<Visitor>> getLastThreeVisitors() async {
    try {
      final currentUser = ref.read(userControllerProvider).currentUser!;
      final data = FormData.fromMap({
        'soc_code': currentUser.socCode,
        'flat_no': currentUser.flatNumber,
      });
      final response = await _dio.post(
        "$generalPath/last_three_visitors.php",
        data: data,
      );

      final results = List<Map<String, dynamic>>.from(response.data['data']);

      List<Visitor> visitors = results
          .map((cardData) => Visitor.fromMap(cardData))
          .toList(growable: false);

      return visitors;
    } on DioException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }
}
