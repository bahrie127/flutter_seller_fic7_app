import 'package:bloc/bloc.dart';
import 'package:flutter_seller_app/data/datasources/product_remote_datasource.dart';
import 'package:flutter_seller_app/data/models/add_product_response_model.dart';
import 'package:flutter_seller_app/data/models/request/product_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';
part 'add_product_bloc.freezed.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(const _Initial()) {
    on<_Create>((event, emit) async {
      emit(const _Loading());
      final response =
          await ProductRemoteDatasource().addProduct(event.request);
      response.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
