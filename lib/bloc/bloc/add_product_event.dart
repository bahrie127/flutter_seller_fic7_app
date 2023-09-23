part of 'add_product_bloc.dart';

@freezed
class AddProductEvent with _$AddProductEvent {
  const factory AddProductEvent.started() = _Started;
  const factory AddProductEvent.create(ProductRequestModel request) = _Create;
}
