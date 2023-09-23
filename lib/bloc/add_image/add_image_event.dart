part of 'add_image_bloc.dart';

@freezed
class AddImageEvent with _$AddImageEvent {
  const factory AddImageEvent.started() = _Started;
  const factory AddImageEvent.addImage(XFile image) = _AddImage;
}