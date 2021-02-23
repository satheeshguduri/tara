import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/gradients.dart';
import 'package:tara_app/common/widgets/cart_icon.dart';
import 'package:tara_app/common/widgets/counter_button.dart';
import 'package:tara_app/common/widgets/page_indicator.dart';
import 'package:tara_app/common/widgets/primary_button.dart';
import 'package:tara_app/models/transfer/register_card_request.dart';
import 'package:tara_app/screens/consumer/shop/product_item.dart';
import '../../../common/constants/styles.dart';
import '../../../common/widgets/extensions.dart';
import '../../base/base_state.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends BaseState<ProductDetailsPage> {
  final List<String> image = [
    "https://images.unsplash.com/photo-1519995672084-d21490e86ba6?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
    "https://images.unsplash.com/photo-1519995672084-d21490e86ba6?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
    "https://images.unsplash.com/photo-1519995672084-d21490e86ba6?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
    "https://images.unsplash.com/photo-1519995672084-d21490e86ba6?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
    "https://images.unsplash.com/photo-1519995672084-d21490e86ba6?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(), //Text
              background: ValueBuilder<int>(
                  initialValue: 0,
                  builder: (data, updateFn) {
                    return Stack(
                      children: [
                        PageView.builder(
                          itemBuilder: (_, i) {
                            return Image.network(
                              image[i],
                              fit: BoxFit.cover,
                            );
                          },
                          onPageChanged: (i) => updateFn(i),
                          itemCount: image.length,
                        ),
                        Positioned(
                          bottom: 16,
                          child: SizedBox(
                            width: Get.width,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: DotsIndicator(
                                  data,
                                  5,
                                  // onChange: updateFn,
                                ),
                                color: Colors.white,
                              ).borderRadiusLeft(8).borderRadiusRight(8),
                            ),
                          ),
                        ),
                      ],
                    );
                  }) //Images.network
              ),
          //FlexibleSpaceBar
          expandedHeight: 196,
          leading: Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Container(
              width: 66,
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                tooltip: 'Back',
                onPressed: () => pop(),
              ),
              color: Colors.black.withOpacity(0.2),
            ).borderRadiusRight(24),
          ),
          //IconButton
          actions: <Widget>[
            //IconButton
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Container(
                width: 66,
                alignment: Alignment.center,
                child: CartButton(
                  iconColor: Colors.white,
                ),
                color: Colors.black.withOpacity(0.2),
              ).borderRadiusLeft(24),
            ) //IconButton
          ], //<Widget>[]
        ), //Slive
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              buildNameCard(context),
              SizedBox(
                height: 16,
                child: ColoredBox(color: Colors.grey.shade200),
              ),
              buildDescriptionBox(),
              SizedBox(
                height: 16,
                child: ColoredBox(color: Colors.grey.shade200),
              ),
              buildSimilarItems(),
              SizedBox(
                height: 16,
                child: ColoredBox(color: Colors.grey.shade200),
              ),
            ],
          ),
        ), // rAppBar
      ], //<Widget>[]
    ) //CustonScrollView
        );
  }

  Widget buildSimilarItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Often bought with",
              style: TextStyles.headline6222,
            ),
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "SEE ALL",
                          textAlign: TextAlign.center,
                          style: BaseStyles.seeAllTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    margin: EdgeInsets.only(top: 4, left: 20),
                    decoration: BoxDecoration(
                      gradient: Gradients.primaryGradient,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 176 * 1.6,
          child: ListView.separated(
            itemBuilder: (_, i) {
              return SizedBox(width: 196, child: ProductItem());
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 8,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 8,
            ),
          ),
        ),
      ],
    ).paddingAll(16);
  }

  Widget buildDescriptionBox() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: TextStyles.subtitle1222,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Fresh Organic Spinach from reputable farm. Price per pack (200gr). Fresh until 1 week after purchase if stored in fridge.",
            style: TextStyle(color: AppColors.black90),
          )
        ],
      ),
    ).paddingAll(16);
  }

  Widget buildNameCard(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Bayam Hijau Hidroponik (1 Ikat)",
              style: TextStyles.headline6222,
            ),
            subtitle: Text("± 200gr / Ikat"),
            trailing: ValueBuilder<bool>(
              initialValue: false,
              builder: (data, updateFn) {
                return InkWell(
                  borderRadius: BorderRadius.circular(56),
                  onTap: () => updateFn(!data),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Icon(
                        data ? Icons.favorite_outline_rounded : Icons.favorite),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              // contentPadding: EdgeInsets.zero,
              title: Text(
                "Price / Ikat",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              subtitle: Text(
                "Rp 5.300-6.600",
                style: TextStyles.subtitle1222,
              ),
              trailing: SizedBox(
                width: Get.width * 0.5,
                child: Counter(
                  title: "+ Add to Cart",
                  onChange: (count) {},
                ),
              ),
            ),
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    ).paddingOnly(top: 12, bottom: 16);
  }

  @override
  BuildContext getContext() {
    return context;
  }
}
