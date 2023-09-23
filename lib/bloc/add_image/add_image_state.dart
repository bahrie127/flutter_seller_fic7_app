part of 'add_image_bloc.dart';

@freezed
class AddImageState with _$AddImageState {
  const factory AddImageState.initial() = _Initial;
  const factory AddImageState.loading() = _Loading;
  const factory AddImageState.loaded(ImageResponseModel data) = _Loaded;
  const factory AddImageState.error(String message) = _Error;
}
