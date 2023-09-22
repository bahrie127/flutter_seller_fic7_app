import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_seller_app/bloc/categories/categories_bloc.dart';
import 'package:flutter_seller_app/data/models/categories_response_model.dart';

import '../../pages/base_widgets/custom_app_bar.dart';

import '../../utils/color_resources.dart';
import '../../utils/custom_themes.dart';
import '../../utils/dimensions.dart';
import 'widgets/custom_text_feild.dart';

class SellerAddProductPage extends StatefulWidget {
  const SellerAddProductPage({super.key});

  @override
  State<SellerAddProductPage> createState() => _SellerAddProductPageState();
}

class _SellerAddProductPageState extends State<SellerAddProductPage> {
  @override
  void initState() {
    context.read<CategoriesBloc>().add(const CategoriesEvent.getCategories());
    super.initState();
  }

  Category? selectCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Product'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            Row(
              children: [
                Text(
                  'Product Name',
                  style: robotoRegular.copyWith(
                      color: ColorResources.titleColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
                Text(
                  '*',
                  style: robotoBold.copyWith(
                      color: ColorResources.mainCardFourColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            CustomTextField(
              textInputAction: TextInputAction.next,
              controller: TextEditingController(),
              textInputType: TextInputType.name,
              hintText: 'Product title',
              border: true,
              onChanged: (String text) {},
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
            Row(
              children: [
                Text(
                  'Description',
                  style: robotoRegular.copyWith(
                      color: ColorResources.titleColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
                Text(
                  '*',
                  style: robotoBold.copyWith(
                      color: ColorResources.mainCardFourColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            CustomTextField(
              isDescription: true,
              controller: TextEditingController(),
              onChanged: (String text) {},
              textInputType: TextInputType.multiline,
              maxLine: 3,
              border: true,
              hintText: 'Enter description',
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
            Row(
              children: [
                Text('Select Category',
                    style: robotoRegular.copyWith(
                        color: ColorResources.titleColor(context),
                        fontSize: Dimensions.fontSizeDefault)),
                Text(
                  '*',
                  style: robotoBold.copyWith(
                      color: ColorResources.mainCardFourColor(context),
                      fontSize: Dimensions.fontSizeDefault),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraSmall,
            ),
            BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Text('server error 2');
                  },
                  loading: () => const Center(
                    child: LinearProgressIndicator(),
                  ),
                  loaded: (data) {
                    selectCategory = selectCategory ?? data.data.first;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(
                            Dimensions.paddingSizeExtraSmall),
                        border: Border.all(
                            width: .5,
                            color: Theme.of(context).hintColor.withOpacity(.7)),
                      ),
                      child: DropdownButton<Category>(
                        value: selectCategory,
                        items: data.data.map((val) {
                          return DropdownMenuItem<Category>(
                            value: val,
                            child: Text(val.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectCategory = value;
                          setState(() {});
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius:
                BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
          ),
          child: const Center(
              child: Text(
            'Continue',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeLarge),
          )),
        ),
      ),
    );
  }
}
