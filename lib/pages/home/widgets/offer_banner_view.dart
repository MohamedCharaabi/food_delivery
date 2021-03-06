// import 'package:card_swiper/card_swiper.dart';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/services/firebase_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfferBannerView extends StatelessWidget {
  final List<String> images = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
    'assets/images/banner4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseCrud().readBanners(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var banner = snapshot.data;
          return InkWell(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15.0),
              height: 180.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Swiper(
                itemHeight: 100,
                duration: 500,
                itemWidth: double.infinity,
                pagination: SwiperPagination(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () {
                    log('$index');
                  },
                  child: CachedNetworkImage(
                    imageUrl: snapshot.data!.docs[index]['image'],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),

                // Image.network(
                //   snapshot.data!.docs[index]['image'],
                //   fit: BoxFit.cover,
                // ),
                autoplay: true,
                viewportFraction: 1.0,
                scale: 0.9,
              ),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => GroceryScreen(),
              //   ),
              // );
            },
          );
        });
  }
}
