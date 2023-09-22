import 'package:flutter/cupertino.dart';

import '../../../utils/images.dart';


class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String placeholder;
  const CustomImage({Key? key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = Images.placeholder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      height: height,
      width: width, fit: BoxFit.cover,
      placeholder: Images.placeholder, image: image,
      imageErrorBuilder: (c, o, s) => Image.asset(
        Images.placeholder, height: height,
        width: width, fit: BoxFit.cover,
      ),
    );
  }
}
