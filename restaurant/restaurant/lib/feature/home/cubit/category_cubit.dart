// category_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:restaurant/feature/home/data/model/product_model.dart';

class CategoryState {
  final String? selectedCategory;
  final List<Product> filteredProducts;

  CategoryState({
    required this.filteredProducts,
    this.selectedCategory,
  });

  CategoryState copyWith({
    String? selectedCategory,
    List<Product>? filteredProducts,
  }) {
    return CategoryState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      filteredProducts: filteredProducts ?? this.filteredProducts,
    );
  }
}

class CategoryCubit extends Cubit<CategoryState> {
  final List<Product> allProducts;

  CategoryCubit(this.allProducts)
      : super(CategoryState(filteredProducts: allProducts));

  void selectCategory(String? category) {
    if (category == null) {
      emit(CategoryState(filteredProducts: allProducts, selectedCategory: null));
    } else {
      final filtered = allProducts
          .where((product) => product.category?.title == category)
          .toList();
      emit(CategoryState(filteredProducts: filtered, selectedCategory: category));
    }
  }
}
