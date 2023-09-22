import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_seller_app/bloc/products/products_bloc.dart';

import '../../../utils/custom_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../seller_add_product_page.dart';
import 'animated_floating_button.dart';
import 'paginated_list_view.dart';
import 'shop_product_card.dart';

class AllProductWidget extends StatefulWidget {
  const AllProductWidget({super.key});

  @override
  State<AllProductWidget> createState() => _AllProductWidgetState();
}

class _AllProductWidgetState extends State<AllProductWidget> {
  ScrollController scrollController = ScrollController();
  String message = "";
  bool activated = false;
  bool endScroll = false;

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        endScroll = true;
        message = "bottom";
      });
    } else {
      endScroll = false;
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    context.read<ProductsBloc>().add(const ProductsEvent.getProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                return false;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const Text('Server Error');
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loaded: (data) {
                        return PaginatedListView(
                          reverse: false,
                          scrollController: scrollController,
                          totalSize: data.data.length,
                          offset: 3,
                          onPaginate: (int? offset) async {},
                          itemView: ListView.builder(
                            itemCount: data.data.length,
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return ShopProductWidget(
                                  product: data.data[index]);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              left: null,
              child: Align(
                alignment: Alignment.bottomRight,
                child: ScrollingFabAnimated(
                  width: 150,
                  color: Theme.of(context).cardColor,
                  icon: SizedBox(
                      width: Dimensions.iconSizeExtraLarge,
                      child: Image.asset(Images.addIcon)),
                  text: Text(
                    'Add New',
                    style: robotoRegular.copyWith(),
                  ),
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return const SellerAddProductPage();
                    }));
                  },
                  animateIcon: true,
                  inverted: false,
                  scrollController: scrollController,
                  radius: 10.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
