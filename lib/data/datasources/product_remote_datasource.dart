import 'package:dartz/dartz.dart';
import 'package:flutter_seller_app/data/models/products_response_model.dart';

import 'package:http/http.dart' as http;

import '../../common/global_variables.dart';

import 'auth_local_datasource.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductsResponseModel>> getProducts() async {
    final userId = await AuthLocalDatasource().getUserId();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/products?user_id=$userId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return const Left('Server error');
    }
  }
}
