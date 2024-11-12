// product_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dio/dio.dart';
import 'package:tezda/core/data/models/request/createProduct.dart';
import 'package:tezda/core/data/models/response/createProductResponse.dart';
import 'package:tezda/core/data/models/response/productList.dart';
import 'package:tezda/core/service/appUrl.dart';

import '../../data/models/response/defaultResponse.dart';
import '../../data/models/response/updateProduct.dart';
import '../../service/apiService.dart';
import '../../service/apiStatus.dart';
import '../apiProvider/apiProvider.dart';

final productProvider = StateNotifierProvider<ProductNotifier,List<ProductList>>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return ProductNotifier(apiService);
});

class ProductNotifier extends StateNotifier<List<ProductList>> {
  final ApiService apiService;

  ProductNotifier(this.apiService) : super([]);

  Future<Object?> fetchProducts() async {
    try {
      final response = await apiService.makeApiCall(null,AppUrl.product, baseUrl: AppUrl.baseurl,
      requestType: HttpMethods.get);
      if(response is Success){
        var r = productListFromJson(response.response as String);
        state =r;
        return r;
      }else if (response is Failure){
        var r = defaultErrorFormatFromJson(response.errorResponse as String);
        return r;
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<Object?> createProduct(CreateProductRequest productData) async {
    try {
      final response = await apiService.makeApiCall(productData,AppUrl.product, baseUrl: AppUrl.baseurl,
          requestType: HttpMethods.post);
      if(response is Success){
        var r = createProductResponseFromJson(response.response as String);
        await fetchProducts();
        return r;
      }else if (response is Failure){
        var r = defaultErrorFormatFromJson(response.errorResponse as String);
        return r;
      }

    } catch (e) {
      print('Error creating product: $e');
    }
  }

  Future<Object?> updateProduct(int productId, CreateProductRequest updatedData) async {
    try {
      final response = await apiService.makeApiCall(updatedData,"${AppUrl.product}/$productId", baseUrl: AppUrl.baseurl,
          requestType: HttpMethods.put);
      if(response is Success){
        var r = updateProductResponseFromJson(response.response as String);
        await fetchProducts();
        return r;
      }else if (response is Failure){
        var r = defaultErrorFormatFromJson(response.errorResponse as String);
        return r;
      }
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<Object?> deleteProduct(int productId) async {
    try {
      final response = await apiService.makeApiCall(null,"${AppUrl.product}/$productId", baseUrl: AppUrl.baseurl,
          requestType: HttpMethods.delete);
      if(response is Success){
        var r = updateProductResponseFromJson(response.response as String);
        await fetchProducts();
        return r;
      }else if (response is Failure){
        var r = defaultErrorFormatFromJson(response.errorResponse as String);
        return r;
      }
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}
