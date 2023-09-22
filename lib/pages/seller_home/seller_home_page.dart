import 'package:flutter/material.dart';

import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import 'widgets/on_going_order_widget.dart';

class SellerHomePage extends StatefulWidget {
  const SellerHomePage({super.key});

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    double limitedStockCardHeight = MediaQuery.of(context).size.width / 1.4;
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            elevation: 0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).highlightColor,
            title: Image.asset(Images.logoWithNameImage, height: 35),
          ),
          const SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.paddingSizeSmall),
                OngoingOrderWidget(),

                // CompletedOrderWidget(callback: ),
                SizedBox(height: Dimensions.paddingSizeSmall),

                SizedBox(height: Dimensions.paddingSizeSmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}
