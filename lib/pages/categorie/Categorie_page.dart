import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/models/Categorie.dart';
import 'package:food_delivery_flutter/models/Menu.dart';
import 'package:food_delivery_flutter/pages/foodDetails/food_details.dart';
import 'package:food_delivery_flutter/providers/favorities_provider.dart';
import 'package:food_delivery_flutter/services/firebase_crud.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CategoriePage extends StatefulWidget {
  const CategoriePage({Key? key, required this.selectedCategorie})
      : super(key: key);
  final Categorie selectedCategorie;

  @override
  _CategoriePageState createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  late String uid;
  late Future<List<String>?> _favorites =
      FirebaseCrud().fetchUserFavorites(uid);
  @override
  void initState() {
    super.initState();
    String useruid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {
      uid = useruid;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    log('favorites ==> $_favorites');
    return Scaffold(
      body: FutureBuilder<List<Menu>>(
        future: FirebaseCrud()
            .fetchMenuCat(widget.selectedCategorie.name!, context, uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Menu> fetchedMenus = snapshot.data!;
          log(' cat ==> ${widget.selectedCategorie.name}');
          log('fetchedMenus ==> $fetchedMenus');
          // return SizedBox();
          return SizedBox(
            height: height,
            child: Stack(
              children: [
                Container(
                  height: height * 0.4,
                  width: width,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: '${widget.selectedCategorie.image}',
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        bottom: height * 0.09,
                        left: 15,
                        child: Text(
                          '${widget.selectedCategorie.name}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                  top: height * 0.35,
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 18),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${fetchedMenus.length} Menus'),
                            SizedBox(height: 5),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: fetchedMenus.length,
                                itemBuilder: (context, index) {
                                  Menu _menu = fetchedMenus[index];
                                  return menuRow(_menu);
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //top cart and arrow_back
                Positioned(
                    top: 15,
                    right: 15,
                    left: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ],
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget menuRow(Menu menu) {
    return Consumer<FavoritiesProvider>(
      builder: (context, fav, child) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FoodDetails(selectedFood: menu)));
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: '${menu.image}',
                        placeholder: (context, url) => Image.asset(
                          'assets/images/icon-food.jpg',
                          width: 70,
                          height: 70,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          menu.name!.length > 23
                              ? menu.name!.substring(0, 23) + '...'
                              : '${menu.name}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '\$ ${menu.price}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '★ ${menu.rating}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ],
                )),
                IconButton(
                  onPressed: () async {
                    bool res =
                        await context.read<FavoritiesProvider>().favClick(menu);
                    return res
                        ? showTopSnackBar(
                            context,
                            CustomSnackBar.success(
                              message: "Favorites updated!!",
                            ),
                          )
                        : showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message: "Error!!",
                            ));
                  },
                  icon: fav.favsItems.contains(menu.id)
                      ? Icon(Icons.favorite, color: Colors.red)
                      : Icon(Icons.favorite_border, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
