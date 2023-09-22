import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/custom_themes.dart';
import '../../../utils/dimensions.dart';


extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final bool isAmount;
  final bool amountIcon;
  final bool border;
  final bool isDescription;
  final bool idDate;
  final bool isPassword;
  final Function(String text)? onChanged;
  final String? prefixIconImage;
  final bool isPos;
  final int? maxSize;
  final bool variant;

  const CustomTextField(
      {Key? key, this.controller,
        this.hintText,
        this.textInputType,
        this.maxLine,
        this.focusNode,
        this.nextNode,
        this.textInputAction,
        this.isPhoneNumber = false,
        this.isValidator=false,
        this.validatorMessage,
        this.capitalization = TextCapitalization.none,
        this.fillColor,
        this.isAmount = false,
        this.amountIcon = false,
        this.border = false,
        this.isDescription = false,
        this.onChanged,
        this.idDate = false, this.prefixIconImage,
        this.isPassword = false,
        this.isPos = false,
        this.maxSize,
        this.variant = false,
      }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  void _toggle() {
    setState(() { _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border:widget.border? Border.all(width: 1, color: Theme.of(context).hintColor.withOpacity(.35)):null,
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
      ),
      child: TextFormField(
        controller: widget.controller,
        maxLines: widget.maxLine ?? 1,
        textCapitalization: widget.capitalization,
        maxLength: widget. maxSize ?? (widget.isPhoneNumber ? 15 : null),
        focusNode: widget.focusNode,
        initialValue: null,
        obscureText: widget.isPassword?_obscureText: false,
        onChanged: widget.onChanged,
        enabled: widget.idDate ? false : true,
        inputFormatters: (widget.textInputType == TextInputType.phone || widget.isPhoneNumber) ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))]
            : widget.isAmount ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))] : null,
        keyboardType: widget.isAmount ? TextInputType.number : widget.textInputType ?? TextInputType.text,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(widget.nextNode);
        },


        validator: (input){
          if(input!.isEmpty){
            if(widget.isValidator){
              return widget.validatorMessage??"";
            }
          }
          return null;

        },
        decoration: InputDecoration(
          prefixIconConstraints: BoxConstraints(
            minWidth: widget.variant ? 5 : 20,
            minHeight: widget.variant ? 5 : 20,
          ),
          prefixIcon: widget.prefixIconImage != null ?
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,Dimensions.paddingSizeSmall,0),
            child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.135)
            ),
            child: Image.asset(widget.prefixIconImage!,width: 20, height: 20,)),
          ):const SizedBox(),
          suffixIconConstraints:  BoxConstraints(
            minWidth:widget.variant ? 5 : widget.isPos? 0:40,
            minHeight:widget.variant ? 5 : 20,
          ),
          suffixIcon: widget.isPassword? GestureDetector(onTap: _toggle,
              child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility)):const SizedBox.shrink(),
          hintText: widget.hintText ?? '',
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor,)),
          filled: widget.fillColor != null,
          fillColor: widget.fillColor,
          isDense: true,
          contentPadding:  EdgeInsets.symmetric(vertical: 10.0, horizontal:widget.variant? 0: 10),
          alignLabelWithHint: true,
          counterText: '',
          hintStyle: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
          errorStyle: const TextStyle(height: 1.5),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
