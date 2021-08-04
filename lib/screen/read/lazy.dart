import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../mesin/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loadmore/loadmore.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class LazyRead extends StatefulWidget {
  LazyRead({Key key, this.panjang, this.url, this.blogger}) : super(key: key);
  final int panjang;
  final List<Map<String, dynamic>> url;
  final List<Map<String, dynamic>> blogger;

  @override
  _LazyReadState createState() => new _LazyReadState();
}

class _LazyReadState extends State<LazyRead> {
  int get count => list.length;
  List<int> list = [];

  void load() {
    print("load");
    setState(() {
      list.addAll(List.generate(1, (v) => v));
      print(list);
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> header = {"referer": "https://wrt.my.id"};

    return Container(
      child: RefreshIndicator(
        child: LoadMore(
          isFinish: count >= widget.panjang,
          onLoadMore: _loadMore,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              print(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Const.bgcolor),
                    width: double.infinity,
                    child: Center(
                      child: CachedNetworkImage(
                        httpHeaders: header,
                        imageUrl: widget.url[index]['attributes']['src'],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                          return Container(
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            width: double.infinity,
                            height: 200,
                            child: Center(
                              child: NutsActivityIndicator(
                                radius: 18,
                                activeColor: Colors.deepPurpleAccent,
                                inactiveColor: Colors.red,
                                tickCount: 11,
                                startRatio: 0.55,
                                animationDuration: Duration(milliseconds: 700),
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          width: 120,
                          height: 150,
                          child: Center(
                            child: Icon(
                              Icons.error,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            itemCount: count,
          ),
          whenEmptyLoad: true,
          delegate: DefaultLoadMoreDelegate(),
          textBuilder: DefaultLoadMoreTextBuilder.english,
        ),
        onRefresh: _refresh,
      ),
    );
  }

  Future<bool> _loadMore() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 500));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 500));
    list.clear();
    load();
  }
}
