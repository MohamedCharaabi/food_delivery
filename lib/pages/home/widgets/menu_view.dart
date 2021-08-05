import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/pages/home/home_template.dart';
import 'package:food_delivery_flutter/services/firebase_crud.dart';
import 'package:shimmer/shimmer.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Text('set_menu'),
        ),
        SizedBox(
          height: 220,
          child: FutureBuilder<QuerySnapshot>(
            future: FirebaseCrud().readMenus(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SetMenuShimmer(),
                );
              } else
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var menu = snapshot.data!.docs[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
                      child: InkWell(
                        // onTap: () {
                        //   ResponsiveHelper.isMobile(context) ?
                        //   showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (con) => CartBottomSheet(
                        //     product: setMenu.setMenuList[index], fromSetMenu: true,
                        //     callback: (CartModel cartModel) {
                        //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('added_to_cart', context)), backgroundColor: Colors.green));
                        //     },
                        //   )):
                        //   showDialog(context: context, builder: (con) => Dialog(
                        //     child: CartBottomSheet(
                        //       product: setMenu.setMenuList[index], fromSetMenu: true,
                        //       callback: (CartModel cartModel) {
                        //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('added_to_cart', context)), backgroundColor: Colors.green));
                        //       },
                        //     ),
                        //   ));
                        // },

                        child: Container(
                          height: 220,
                          width: 170,
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300]!,
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                )
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10)),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'https://icon-library.com/images/icon-for-food/icon-for-food-9.jpg',
                                        image: menu['image'],
                                        height: 110,
                                        width: 170,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // _isAvailable ? SizedBox() :
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10)),
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                        child: Text('not_available_now',
                                            textAlign: TextAlign.center,
                                            style: rubikRegular.copyWith(
                                              color: Colors.white,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_SMALL),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            menu['name'],
                                            style: rubikMedium.copyWith(
                                                fontSize:
                                                    Dimensions.FONT_SIZE_SMALL),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),

                                          // RatingBar(
                                          //   rating: setMenu.setMenuList[index].rating.length > 0 ? double.parse(setMenu.setMenuList[index].rating[0].average) : 0.0,
                                          //   size: 12,
                                          // ),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  '\$50',
                                                  // '${PriceConverter.convertPrice(context, _startingPrice, discount: setMenu.setMenuList[index].discount,
                                                  //     discountType: setMenu.setMenuList[index].discountType, asFixed: 1)}''${_endingPrice!= null
                                                  //     ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: setMenu.setMenuList[index].discount,
                                                  //     discountType: setMenu.setMenuList[index].discountType, asFixed: 1)}' : ''}',
                                                  style: rubikBold.copyWith(
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_SMALL),
                                                ),
                                              ),
                                              // _discount > 0 ? SizedBox() : Icon(Icons.add, color: Theme.of(context).textTheme.bodyText1.color),
                                            ],
                                          ),
                                          // _discount > 0 ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          //   Flexible(
                                          //     child: Text(
                                          //       '${PriceConverter.convertPrice(context, _startingPrice, asFixed: 1)}'
                                          //           '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, asFixed: 1)}' : ''}',
                                          //       style: rubikBold.copyWith(
                                          //         fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                          //         color: ColorResources.COLOR_GREY,
                                          //         decoration: TextDecoration.lineThrough,
                                          //       ),
                                          //     ),
                                          //   ),
                                          //   Icon(Icons.add, color: Theme.of(context).textTheme.bodyText1.color),
                                          // ]) : SizedBox(),
                                        ]),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    );
                  },
                );
            },
          ),
        ),
      ],
    );
  }
}

class SetMenuShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          width: 150,
          margin:
              EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
          decoration: BoxDecoration(
              color: ColorResources.COLOR_WHITE,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 1)
              ]),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            // enabled: Provider.of<SetMenuProvider>(context).setMenuList == null,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 110,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    color: ColorResources.COLOR_WHITE),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 15,
                            width: 130,
                            color: ColorResources.COLOR_WHITE),

                        // Align(alignment: Alignment.centerRight, child: RatingBar(rating: 0.0, size: 12)),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 10,
                                  width: 50,
                                  color: ColorResources.COLOR_WHITE),
                              Icon(Icons.add,
                                  color: ColorResources.COLOR_BLACK),
                            ]),
                      ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
