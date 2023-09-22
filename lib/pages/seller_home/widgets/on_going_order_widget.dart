import 'package:flutter/material.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import 'order_type_button_head.dart';

class OngoingOrderWidget extends StatelessWidget {
  final Function? callback;
  const OngoingOrderWidget({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
              color: ColorResources.getPrimary(context).withOpacity(.05),
              spreadRadius: -3,
              blurRadius: 12,
              offset: Offset.fromDirection(0, 6))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: Dimensions.iconSizeLarge,
                    height: Dimensions.iconSizeLarge,
                    padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeExtraSmall),
                    child: Image.asset(Images.monthlyEarning)),
                const SizedBox(
                  width: Dimensions.paddingSizeSmall,
                ),
                Text(
                  'Business Analytics',
                  style: robotoBold.copyWith(
                      color: ColorResources.getTextColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
                const Expanded(
                    child: SizedBox(
                  width: Dimensions.paddingSizeExtraLarge,
                )),
                Container(
                  height: 50,
                  width: 120,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(
                        width: .7,
                        color: Theme.of(context).hintColor.withOpacity(.3)),
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  ),
                  child: DropdownButton<String>(
                    value: 'overall',
                    items: <String>['overall', 'today', 'this_month']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          'overall',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    isExpanded: true,
                    underline: const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeSmall,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimensions.paddingSizeDefault,
                Dimensions.paddingSizeExtraSmall,
                Dimensions.paddingSizeDefault,
                Dimensions.paddingSeven),
            child: Text(
              'Ongoing Orders',
              style: robotoBold.copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          Padding(
                    padding: const EdgeInsets.fromLTRB(
                        Dimensions.paddingSizeSmall,
                        0,
                        Dimensions.paddingSizeSmall,
                        Dimensions.fontSizeSmall),
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: (1 / .65),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        OrderTypeButtonHead(
                          color: ColorResources.mainCardOneColor(context),
                          text: 'Pending',
                          index: 1,
                          subText: 'Orders',
                          numberOfOrder: 3,
                          callback: callback,
                        ),
                        OrderTypeButtonHead(
                          color: ColorResources.mainCardTwoColor(context),
                          text: 'Packaging',
                          index: 2,
                          numberOfOrder: 4,
                          callback: callback,
                          subText: 'Order',
                        ),
                        OrderTypeButtonHead(
                          color: ColorResources.mainCardThreeColor(context),
                          text: 'Confirmed',
                          index: 7,
                          subText: 'Order',
                          numberOfOrder: 5,
                          callback: callback,
                        ),
                        OrderTypeButtonHead(
                          color: ColorResources.mainCardFourColor(context),
                          text: 'Out of Delivery',
                          index: 8,
                          subText: '',
                          numberOfOrder: 6,
                          callback: callback,
                        ),
                      ],
                    ),
                  ),
                
             
          const SizedBox(height: Dimensions.paddingSizeSmall),
        ],
      ),
    );
  }
}
