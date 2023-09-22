import 'package:bloc/bloc.dart';
import 'package:flutter_seller_app/data/datasources/product_remote_datasource.dart';
import 'package:flutter_seller_app/data/models/products_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const _Initial()) {
    on<_GetProduct>((event, emit) async {
      emit(const _Loading());
      final response = await ProductRemoteDatasource().getProducts();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
