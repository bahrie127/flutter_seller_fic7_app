import 'package:flutter/material.dart';

import '../../pages/base_widgets/custom_app_bar.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import 'widgets/all_product_widget.dart';
import 'widgets/custom_search_field.dart';

class SellerProductPage extends StatefulWidget {
  const SellerProductPage({super.key});

  @override
  State<SellerProductPage> createState() => _SellerProductPageState();
}

class _SellerProductPageState extends State<SellerProductPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Product List'),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: Container(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeDefault),
                child: CustomSearchField(
                  controller: searchController,
                  hint: 'Search',
                  prefix: Images.iconsSearch,
                  iconPressed: () => () {},
                  onSubmit: (text) => () {},
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
          Expanded(child: AllProductWidget())
        ],
      ),
    );
  }
}
