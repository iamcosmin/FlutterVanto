import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/widget.dart';

class Store extends StatefulWidget {
  @override
  StoreScreen createState() => StoreScreen();
}

class StoreScreen extends State<Store> {
  double _value = 50.0;
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text('Magazin'),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () {
            return Future<void>.delayed(const Duration(seconds: 2));
          },
        ),
        SliverPadding(
          padding: MediaQuery.of(context)
              .removePadding(
                removeTop: true,
                removeLeft: true,
                removeRight: true,
              )
              .padding,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Material(
                      elevation: 4.0,
                      borderRadius: BorderRadius.circular(10.0),
                      color: CupertinoColors.darkBackgroundGray,
                      child: Column(
                        children: <Widget>[
                          //! Minecraft

                          Elem(
                            imagine:
                                'https://d33wubrfki0l68.cloudfront.net/4b55f5ed7172d21e730d125675b8888ed8cc4a85/1cd6c/assets/minecraft.jpg',
                            titlu: 'Minecraft',
                            subtitlu: 'Joc',
                            tip: 'Vizitează',
                            link: 'https://vanto.netlify.com/store/apps/minecraft',
                          ),
                          Div(),
                          Elem(
                            imagine:
                                'https://d33wubrfki0l68.cloudfront.net/3892a2b9edb02e7d350220bc39d909d0cc7c8f6a/6eaf5/assets/clashofclans.jpg',
                            titlu: 'Nulls Clash',
                            subtitlu: 'Joc',
                            tip: 'Vizitează',
                            link: 'https://vanto.netlify.com/store/apps/nullsclash',
                          ),
                          Div(),
                          Elem(
                            imagine:
                                'https://d33wubrfki0l68.cloudfront.net/7055b1f3c5fc741cd8f7b9351da0ff71018cff7a/8e140/assets/battlestars.png',
                            titlu: 'Nulls Brawl',
                            subtitlu: 'Joc',
                            tip: 'Vizitează',
                            link: 'https://vanto.netlify.com/store/apps/nullsbrawl',
                          ),
                          Div(),
                          Elem(
                            imagine:
                                'https://d33wubrfki0l68.cloudfront.net/c01aeef8ec61e40109e8f8ab90a7fd1af388cc3c/f1abd/assets/clashroyale.jpg',
                            titlu: 'Nulls Royale',
                            subtitlu: 'Joc',
                            tip: 'Vizitează',
                            link: 'https://vanto.netlify.com/store/apps/nullsroyale',
                          ),
                          Div(),
                          Elem(
                            imagine:
                                'https://d33wubrfki0l68.cloudfront.net/516e9385a26ebc74f06fd2fc4b4c6e7967600c87/cdd13/assets/youtube.jpg',
                            titlu: 'Vanced',
                            subtitlu: 'Aplicație',
                            tip: 'Descarcă',
                            link: 'https://vanced.app',
                          ),
                          
                         
                        ],
                      )),
                );
              },
              childCount: 1,
            ),
          ),
        ),
      ],
    ));
  }
}
