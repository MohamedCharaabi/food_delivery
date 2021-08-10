import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_flutter/utils/images.dart';
import 'package:food_delivery_flutter/utils/style.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: 550,
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder_rectangle,
                      image: '',
                      width: 100,
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'product.name',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: rubikMedium.copyWith(
                              fontSize: Dimensions.FONT_SIZE_LARGE),
                        ),
                        SizedBox(height: 10),
                        // RatingBar(
                        //             rating: 0.0,
                        //             size: 15),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$123',
                                style: rubikMedium.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_LARGE),
                              ),
                              //  price == priceWithDiscount
                              //           ? Consumer<WishListProvider>(builder:
                              //               (context, wishList, child) {
                              //               return InkWell(
                              //                 onTap: () {
                              //                   wishList.wishIdList
                              //                           .contains(product.id)
                              //                       ? wishList
                              //                           .removeFromWishList(
                              //                               product,
                              //                               (message) {
                              //                               })
                              //                       : wishList.addToWishList(
                              //                           product, (message) {
                              //                   });
                              //                 },
                              //                 child: Icon(
                              //                   wishList.wishIdList.contains(product.id)
                              //                       ? Icons.favorite
                              //                       : Icons.favorite_border,
                              //                   color: wishList.wishIdList.contains(product.id)
                              //                       ? Theme.of(context).primaryColor
                              //                       : ColorResources.COLOR_GREY,
                              //                 ),
                              //               );
                              //             })
                              //           : SizedBox(),
                            ]),
                        SizedBox(height: 5),
//  price > priceWithDiscount
//                                     ? Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                             Text(
//                                               '${PriceConverter.convertPrice(context, _startingPrice)}'
//                                               '${_endingPrice != null ? ' - ${PriceConverter.convertPrice(context, _endingPrice)}' : ''}',
//                                               style: rubikMedium.copyWith(
//                                                   color:
//                                                       ColorResources.COLOR_GREY,
//                                                   decoration: TextDecoration
//                                                       .lineThrough),
//                                             ),
//                                             Consumer<WishListProvider>(builder:
//                                                 (context, wishList, child) {
//                                               return InkWell(
//                                                 onTap: () {
//                                                   wishList.wishIdList
//                                                           .contains(product.id)
//                                                       ? wishList
//                                                           .removeFromWishList(
//                                                               product,
//                                                               (message) {})
//                                                       : wishList.addToWishList(
//                                                           product,
//                                                           (message) {});
//                                                 },
//                                                 child: Icon(
//                                                   wishList.wishIdList.contains(product.id)
//                                                       ? Icons.favorite
//                                                       : Icons.favorite_border,
//                                                   color: wishList.wishIdList.contains(product.id)
//                                                       ? Theme.of(context).primaryColor
//                                                       : ColorResources.COLOR_GREY,
//                                                 ),
//                                               );
//                                             }),
//                                           ])
//                                     : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            ],
          ),
        ),
      )
    ]);
  }
}
