import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/pages/home/widgets/categories_view.dart';
import 'package:food_delivery_flutter/pages/home/widgets/menu_view.dart';
import 'package:food_delivery_flutter/pages/home/widgets/offer_banner_view.dart';
import 'package:food_delivery_flutter/utils/responsive_helper.dart';
import 'package:food_delivery_flutter/utils/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          //load data(user info, categories, menu, banners)
          // await _loadData(context, true);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Scrollbar(
          controller: _scrollController,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // appBar
              SliverAppBar(
                floating: true,
                elevation: 0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).accentColor,
                pinned: ResponsiveHelper.isTab(context) ? true : false,
                leading:
                    // ResponsiveHelper.isTab(context) ? IconButton(
                    //   onPressed: () => drawerGlobalKey.currentState.openDrawer(),
                    //   icon: Icon(Icons.menu,color: Colors.black),
                    // ):
                    null,
                title:
                    // Consumer<SplashProvider>(builder:(context, splash, child) =>
                    Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ResponsiveHelper.isWeb() ? FadeInImage.assetNetwork(
                    //   placeholder: Images.placeholder_rectangle, height: 40, width: 40,
                    //   image: splash.baseUrls != null ? '${splash.baseUrls.restaurantImageUrl}/${splash.configModel.restaurantLogo}' : '',
                    //   imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_rectangle, height: 40, width: 40),
                    // ) :

                    //assets logo
                    //  Image.asset('assets/images/logo.png', width: 40, height: 40),
                    FlutterLogo(
                      size: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      // ResponsiveHelper.isWeb() ? splash.configModel.restaurantName :
                      'Food delivery',
                      style: rubikBold.copyWith(
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: null,
                    // onPressed: () => Navigator.pushNamed(context, Routes.getNotificationRoute()),
                    icon: Icon(Icons.notifications,
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                  // ResponsiveHelper.isTab(context) ?
                  // IconButton(
                  //   onPressed: () => Navigator.pushNamed(context, Routes.getDashboardRoute('cart')),
                  //   icon: Stack(
                  //     clipBehavior: Clip.none,
                  //     children: [
                  //       Icon(Icons.shopping_cart, color: Theme.of(context).textTheme.bodyText1.color),
                  //       Positioned(
                  //         top: -10, right: -10,
                  //         child: Container(
                  //           padding: EdgeInsets.all(4),
                  //           alignment: Alignment.center,
                  //           decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  //           child: Center(
                  //             child: Text(
                  //               Provider.of<CartProvider>(context).cartList.length.toString(),
                  //               style: rubikMedium.copyWith(color: Colors.white, fontSize: 8),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ) :

                  SizedBox(),
                ],
              ),
// Search Button
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverDelegate(
                    child: Center(
                  child: InkWell(
                    // onTap: () =>
                    //     Navigator.pushNamed(context, Routes.getSearchRoute()),
                    child: Container(
                      height: 60,
                      width: 1170,
                      color: Theme.of(context).accentColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.getSearchBg(context),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL),
                              child: Icon(Icons.search, size: 25)),
                          Expanded(
                              child: Text('search_items_here',
                                  style: rubikRegular.copyWith(fontSize: 12))),
                        ]),
                      ),
                    ),
                  ),
                )),
              ),

              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    width: 1170,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CategorieView(),
                          MenuView(),
                          // BannerView(),
                          OfferBannerView(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                            child: Text('popular_item'),
                          ),
                          // ProductView(productType: ProductType.POPULAR_PRODUCT, scrollController: _scrollController),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 60 ||
        oldDelegate.minExtent != 60 ||
        child != oldDelegate.child;
  }
}
