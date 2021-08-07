import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/services/firebase_crud.dart';
import 'package:food_delivery_flutter/utils/style.dart';
import 'package:shimmer/shimmer.dart';

import 'package:food_delivery_flutter/pages/home/home_template.dart';

class CategorieView extends StatefulWidget {
  const CategorieView({Key? key}) : super(key: key);

  @override
  _CategorieViewState createState() => _CategorieViewState();
}

class _CategorieViewState extends State<CategorieView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Categories
  Future<QuerySnapshot> readCategories() {
    CollectionReference categories = _firestore.collection('categories');

    return categories.get();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
        child: Text('all_categories'),
      ),
      SizedBox(
        height: 80,
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseCrud().readCategories(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CategoryShimmer(),
              );
            } else
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var categorie = snapshot.data!.docs[index];
                  return Padding(
                    padding:
                        EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                    child: InkWell(
                      // onTap: () => Navigator.pushNamed(
                      //     context,
                      //     Routes.getCategoryRoute(
                      //       categories[index].id,
                      //       categories[index].image,
                      //       categories[index].name
                      //           .replaceAll(' ', '-'),
                      //     )), // arguments:  categories[index].name),
                      child: Column(children: [
                        ClipOval(
                          child: FadeInImage.assetNetwork(
                            placeholder:
                                'https://icon-library.com/images/icon-for-food/icon-for-food-9.jpg',
                            image: categorie['image'],
                            width: 65, height: 65, fit: BoxFit.cover,
                            // width: 100, height: 100, fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          categorie['name'],
                          style: rubikMedium.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]),
                    ),
                  );
                },
              );
          },
        ),
      ),
    ]);
  }
}

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: 14,
        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              // enabled: Provider.of<CategoryProvider>(context).categoryList == null,
              child: Column(children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: ColorResources.COLOR_WHITE,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                    height: 10, width: 50, color: ColorResources.COLOR_WHITE),
              ]),
            ),
          );
        },
      ),
    );
  }
}
