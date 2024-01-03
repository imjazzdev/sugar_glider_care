import 'package:flutter/material.dart';
import 'package:testing/ads/adsManager.dart';
import 'package:testing/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class PerawatanPage extends StatefulWidget {
  @override
  _PerawatanPageState createState() => _PerawatanPageState();
}

class _PerawatanPageState extends State<PerawatanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.grey[50],
        title: Text(LocaleKeys.perawatan,
            style: TextStyle(
              color: Colors.grey[800],
            )).tr(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          splashRadius: 28,
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.grey[900],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          ListTile(
            title: LocaleKeys.perawatanchild_memandikan,
            color: Colors.blue.shade100,
            routes: '/memandikan',
          ),
          ListTile(
            title: LocaleKeys.perawatanchild_potongkuku,
            color: Colors.amber.shade100,
            routes: '/potongkuku',
          ),
          ListTile(
            title: LocaleKeys.perawatanchild_penyakit,
            color: Colors.red.shade100,
            routes: '/penyakit',
          ),
        ],
      ),
    );
  }
}

class ListTile extends StatefulWidget {
  final Color color;
  final String title;
  final String routes;
  ListTile({required this.color, required this.title, required this.routes});

  @override
  _ListTileState createState() => _ListTileState();
}

class _ListTileState extends State<ListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, widget.routes);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        padding: EdgeInsets.only(left: 18, right: 10),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ).tr(),
            IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded), onPressed: () {})
          ],
        ),
      ),
    );
  }
}
