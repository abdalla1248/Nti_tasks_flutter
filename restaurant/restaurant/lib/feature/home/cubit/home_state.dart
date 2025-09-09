import 'package:restaurant/feature/home/data/model/product_model.dart';
import 'package:restaurant/feature/home/data/model/sliders_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final ProductModel? bestSellers;
  final SlidersModel? sliders;
  final ProductModel? topRated;

  HomeLoaded({
    this.bestSellers,
    this.sliders,
    this.topRated,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
