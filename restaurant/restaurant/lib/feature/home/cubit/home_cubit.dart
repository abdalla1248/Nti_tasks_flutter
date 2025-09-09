import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant/feature/home/data/repo/home_repository.dart';
import 'home_state.dart';
import '../data/model/product_model.dart';
import '../data/model/sliders_model.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  ProductModel? _allBestSellers;
  ProductModel? _allTopRated;

  ProductModel? filteredBestSellers;
  ProductModel? filteredTopRated;

  HomeCubit(this.homeRepo) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());

    try {
      final Either<String, ProductModel> bestSellersResult = await homeRepo.getBestSellerProducts();
      final Either<String, SlidersModel> slidersResult = await homeRepo.getSliders();
      final Either<String, ProductModel> topRatedResult = await homeRepo.getTopRatedProducts();

      // Handle failures
      String? errorMessage;
      bestSellersResult.fold((l) => errorMessage = l, (r) => _allBestSellers = r);
      slidersResult.fold((l) => errorMessage ??= l, (r) => null);
      topRatedResult.fold((l) => errorMessage ??= l, (r) => _allTopRated = r);

      if (errorMessage != null) {
        emit(HomeError(errorMessage!));
        return;
      }

      filteredBestSellers = _allBestSellers;
      filteredTopRated = _allTopRated;

      emit(HomeLoaded(
        bestSellers: filteredBestSellers,
        sliders: slidersResult.getOrElse(() => SlidersModel(sliders: [], status: false)),
        topRated: filteredTopRated,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  /// 🔍 Filter products live
  void searchProducts(String query) {
    if (_allBestSellers == null || _allTopRated == null) return;

    if (query.isEmpty) {
      filteredBestSellers = _allBestSellers;
      filteredTopRated = _allTopRated;
    } else {
      final q = query.toLowerCase();

      filteredBestSellers = ProductModel(
        products: _allBestSellers!.products
            .where((p) => p.name.toLowerCase().contains(q))
            .toList(),
        status: true,
      );

      filteredTopRated = ProductModel(
        products: _allTopRated!.products
            .where((p) => p.name.toLowerCase().contains(q))
            .toList(),
        status: true,
      );
    }

    emit(HomeLoaded(
      bestSellers: filteredBestSellers,
      sliders: (state is HomeLoaded) ? (state as HomeLoaded).sliders : null,
      topRated: filteredTopRated,
    ));
  }
}
