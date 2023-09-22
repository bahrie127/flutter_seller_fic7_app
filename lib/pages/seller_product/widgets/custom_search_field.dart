import 'package:flutter/material.dart';

import '../../../utils/custom_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';


class CustomSearchField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final String prefix;
  final Function iconPressed;
  final Function? onSubmit;
  final Function? onChanged;
  final Function? filterAction;
  final bool isFilter;
  const CustomSearchField({Key? key,
    required this.controller,
    required this.hint,
    required this.prefix,
    required this.iconPressed,
    this.onSubmit,
    this.onChanged,
    this.filterAction,
    this.isFilter = false,
  }) : super(key: key);

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: TextField(
          controller: widget.controller,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).disabledColor.withOpacity(.5)),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            ),
            filled: true, fillColor: Theme.of(context).primaryColor.withOpacity(.07),
            isDense: true,
            focusedBorder:OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: .70),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeMedium),
              child: SizedBox(width: Dimensions.iconSizeExtraSmall,  child: Image.asset(widget.prefix)),
            ),

            // IconButton(
            //   onPressed: widget.iconPressed,
            //   icon: Icon(widget.prefix, color: Theme.of(context).hintColor),
            // ),
          ),
          onSubmitted: widget.onSubmit as void Function(String)?,
          onChanged: widget.onChanged as void Function(String)?,
        ),
      ),

      
     widget.isFilter ? Padding(
        padding:  EdgeInsets.only(left :  0,
            right :  Dimensions.paddingSizeExtraSmall),
       child: GestureDetector(
          onTap: widget.filterAction as void Function()?,
          child: Container(decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
          ),
              padding: const EdgeInsets.all(Dimensions.paddingSizeMedium),
              child: Image.asset(Images.filterIcon, width: Dimensions.paddingSizeLarge)),
        ),
      ) : const SizedBox(),
    ],);
  }
}
