import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/entities/carousel_item.dart';
import 'package:secure_gates_project/entities/home_page_card_item.dart';
import 'package:secure_gates_project/entities/visitor.dart';

import '../custom_exception.dart';

final dashboardServiceProvider = Provider<DashboardDataService>((ref) {
  return DashboardDataService(Dio());
});

abstract class BaseDashboardDataService {
  Future<List<CarouselItem>> getCarouselItems();
  Future<List<HomePageCardItem>> getHomePageCards();
  Future<List<Visitor>> getLastThreeVisitors();
}

class DashboardDataService implements BaseDashboardDataService {
  final Dio _dio;

  const DashboardDataService(this._dio);

  @override
  Future<List<CarouselItem>> getCarouselItems() async {
    try {
      final response =
          await _dio.get("https://gatesadmin.000webhostapp.com/banner.php");

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
        "https://gatesadmin.000webhostapp.com/dashboard.php",
        data: data,
      );

      final results = List<Map<String, dynamic>>.from(response.data);

      List<HomePageCardItem> cards = results
          .map((cardData) => HomePageCardItem.fromMap(cardData))
          .toList(growable: false);

      return cards;
    } on DioError catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<List<Visitor>> getLastThreeVisitors() async {
    try {
      final data = FormData.fromMap({
        'soc_code': 'CP',
        'flat_no': '360',
      });
      final response = await _dio.post(
        "https://gatesadmin.000webhostapp.com/last_three_visitors.php",
        data: data,
      );

      final results = List<Map<String, dynamic>>.from(response.data['data']);

      List<Visitor> visitors = results
          .map((cardData) => Visitor.fromMap(cardData))
          .toList(growable: false);

      return visitors;
    } on DioError catch (e) {
      throw CustomExeption(message: e.message);
    }
  }
}
