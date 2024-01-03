import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testing/ads/adsManager.dart';
import 'package:testing/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class HorizontalList extends StatefulWidget {
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0),
      // color: Colors.orange[50],
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: 10,
          ),
          Catagory(
            img_location: 'assets/fruits.svg',
            title: LocaleKeys.makanan,
            color: isSelected ? Colors.amber.shade50 : Colors.amber.shade200,
            routes: '/food',
          ),
          Catagory(
            img_location: 'assets/jenis.svg',
            title: LocaleKeys.jenis,
            color: Colors.green.shade50,
            routes: '/jenis',
          ),
          Catagory(
            img_location: 'assets/kangaroo.svg',
            title: LocaleKeys.ternak,
            color: Colors.purple.shade50,
            routes: '/breeding',
          ),
          Catagory(
            img_location: 'assets/care.svg',
            title: LocaleKeys.perawatan,
            color: Colors.blue.shade50,
            routes: '/perawatan',
          ),
          Catagory(
            img_location: 'assets/gender.svg',
            title: LocaleKeys.kelamin,
            color: Colors.pink.shade50,
            routes: '/gender',
          ),
        ],
      ),
    );
  }
}

class Catagory extends StatefulWidget {
  final String img_location;
  final String title;
  final Color color;
  final String routes;
  Catagory(
      {required this.img_location,
      required this.title,
      required this.color,
      required this.routes});

  @override
  _CatagoryState createState() => _CatagoryState();
}

class _CatagoryState extends State<Catagory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7),
      width: 100,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        autofocus: true,
        highlightColor: Colors.amber.shade100,
        onTap: () async {
          AdsManager.loadUnityAds();
          await AdsManager.showIntAds();
          Navigator.pushNamed(context, widget.routes);
        },
        child: Card(
          elevation: 0.4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: widget.color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: SvgPicture.asset(
                  widget.img_location,
                  height: 50,
                  width: 50,
                ),
              ),
              Container(
                // color: Colors.purple,
                child: Center(
                    child: Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ).tr()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
