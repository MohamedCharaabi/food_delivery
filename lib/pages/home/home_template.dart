import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/utils/responsive_helper.dart';
// import 'package:flutter_restaurant/helper/responsive_helper.dart';
// import 'package:flutter_restaurant/view/screens/menu/widget/options_view.dart';

class HomeTemplate extends StatefulWidget {
  const HomeTemplate({Key? key}) : super(key: key);

  @override
  _HomeTemplateState createState() => _HomeTemplateState();
}

class _HomeTemplateState extends State<HomeTemplate> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: Color(0xFFF4F7FC),
      drawer:
          //  ResponsiveHelper.isTab(context) ? Drawer(child: OptionsView(onTap: null)) :
          SizedBox(),
      appBar: null,
      body: SafeArea(
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
                        // style: rubikBold.copyWith(color: Theme.of(context).primaryColor),
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
                                    style:
                                        rubikRegular.copyWith(fontSize: 12))),
                          ]),
                        ),
                      ),
                    ),
                  )),
                ),
              ],
            ),
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

class Dimensions {
  static const double FONT_SIZE_EXTRA_SMALL = 10.0;
  static const double FONT_SIZE_SMALL = 12.0;
  static const double FONT_SIZE_DEFAULT = 14.0;
  static const double FONT_SIZE_LARGE = 16.0;
  static const double FONT_SIZE_EXTRA_LARGE = 18.0;
  static const double FONT_SIZE_OVER_LARGE = 24.0;

  static const double PADDING_SIZE_EXTRA_SMALL = 5.0;
  static const double PADDING_SIZE_SMALL = 10.0;
  static const double PADDING_SIZE_DEFAULT = 15.0;
  static const double PADDING_SIZE_LARGE = 20.0;
  static const double PADDING_SIZE_EXTRA_LARGE = 25.0;
}

class ColorResources {
  static Color getGreyColor(BuildContext context) {
    return
        // Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF6f7275) :
        Color(0xFFA0A4A8);
  }

  static Color getGrayColor(BuildContext context) {
    return
        // Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF919191) :
        Color(0xFF6E6E6E);
  }

  static Color getSearchBg(BuildContext context) {
    return
        // Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF585a5c) :
        Color(0xFFF4F7FC);
  }

  static Color getBackgroundColor(BuildContext context) {
    return
        // Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF343636) :
        Color(0xFFF4F7FC);
  }

  static Color getHintColor(BuildContext context) {
    return
        // Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF98a1ab) :
        Color(0xFF52575C);
  }

  static Color getGreyBunkerColor(BuildContext context) {
    return
        // Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFFE4E8EC) :
        Color(0xFF25282B);
  }

  static const Color COLOR_GREY = Color(0xFFA0A4A8);
  static const Color COLOR_BLACK = Color(0xFF000000);
  static const Color COLOR_NERO = Color(0xFF1F1F1F);
  static const Color COLOR_WHITE = Color(0xFFFFFFFF);
  static const Color COLOR_HINT = Color(0xFF52575C);
  static const Color SEARCH_BG = Color(0xFFF4F7FC);
  static const Color COLOR_GRAY = Color(0xff6E6E6E);
  static const Color COLOR_OXFORD_BLUE = Color(0xff282F39);
  static const Color COLOR_GAINSBORO = Color(0xffE8E8E8);
  static const Color COLOR_NIGHER_RIDER = Color(0xff303030);
  static const Color BACKGROUND_COLOR = Color(0xffF4F7FC);
  static const Color COLOR_GREY_BUNKER = Color(0xff25282B);
  static const Color COLOR_GREY_CHATEAU = Color(0xffA0A4A8);
  static const Color BORDER_COLOR = Color(0xFFDCDCDC);
  static const Color DISABLE_COLOR = Color(0xFF979797);

  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };
}

const rubikRegular = TextStyle(
  fontFamily: 'Rubik',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w400,
);

const rubikMedium = TextStyle(
  fontFamily: 'Rubik',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w500,
);

const rubikBold = TextStyle(
  fontFamily: 'Rubik',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w700,
);
