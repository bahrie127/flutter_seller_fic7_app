import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_seller_app/bloc/add_image/add_image_bloc.dart';
import 'package:flutter_seller_app/bloc/bloc/add_product_bloc.dart';
import 'package:flutter_seller_app/bloc/categories/categories_bloc.dart';
import 'package:flutter_seller_app/common/global_variables.dart';
import 'package:flutter_seller_app/data/models/categories_response_model.dart';
import 'package:flutter_seller_app/data/models/request/product_request_model.dart';
import 'package:flutter_seller_app/pages/dashboard/seller_dashboard_page.dart';
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    context.read<CategoriesBloc>().add(const CategoriesEvent.getCategories());
    super.initState();
  }

  Category? selectCategory;

  XFile? _imageFile;

  String imageUrl = '';

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (photo != null) {
      _imageFile = photo;
      context.read<AddImageBloc>().add(AddImageEvent.addImage(photo));
      // setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Product'),
      body: SingleChildScrollView(
        child: Padding(
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
                controller: titleController,
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
                controller: descController,
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
                  Text('Upload Image',
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
              Center(
                child: BlocBuilder<AddImageBloc, AddImageState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const Text('Error');
                      },
                      loaded: (data) {
                        imageUrl = data.imagePath;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: _imageFile != null
                              ? Image.network(
                                  '${GlobalVariables.baseUrl}${data.imagePath}',
                                  // File(_imageFile!.path.toString()),
                                  height: 150,
                                  // width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/placeholder_1x1.png',
                                  height: 150,
                                ),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      initial: () {
                        return Image.asset(
                          'assets/images/placeholder_1x1.png',
                          height: 150,
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    child: const Text(
                      "Camera",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xFFF5A1A1),
                      ),
                    ),
                    child: const Text(
                      "Galery",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
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
                              color:
                                  Theme.of(context).hintColor.withOpacity(.7)),
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
              const SizedBox(
                height: Dimensions.paddingSizeExtraLarge,
              ),
              Row(
                children: [
                  Text('Price',
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
              CustomTextField(
                textInputAction: TextInputAction.done,
                controller: priceController,
                textInputType: TextInputType.number,
                hintText: 'Price',
                border: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const SellerDashboardPage();
              }));
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: InkWell(
                  onTap: () {
                    final request = ProductRequestModel(
                      name: titleController.text,
                      description: descController.text,
                      price: int.parse(priceController.text),
                      imageUrl: imageUrl,
                      categoryId: selectCategory!.id,
                    );

                    context
                        .read<AddProductBloc>()
                        .add(AddProductEvent.create(request));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(
                          Dimensions.paddingSizeExtraSmall),
                    ),
                    child: const Center(
                        child: Text(
                      'Add Product',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.fontSizeLarge),
                    )),
                  ),
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
