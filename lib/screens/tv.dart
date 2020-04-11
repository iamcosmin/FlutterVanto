import 'package:Vanto/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class TV extends StatefulWidget {
  @override
  TVScreen createState() => TVScreen();
}

class TVScreen extends State<TV> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text('TV'),
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
                      child: Column(children: <Widget>[
                        Elem(
                            imagine:
                                'https://c-sf.smule.com/rs-s79/arr/19/89/a24b6f44-e26c-44c6-aa2b-be0082d104bb.jpg',
                            titlu: 'Lucifer',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/joinchat/AAAAAE7K3zy8EGuxudgQJgț',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://images.wallpapersden.com/image/download/money-heist-season-3_67249_128x128.jpg',
                            titlu: 'La Casa De Papel',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/Moviewalker_Money_Heist',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://miro.medium.com/fit/c/256/256/2*1jkHJmjaoPE4Lj1ooaIocA.jpeg',
                            titlu: 'Stranger Things',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/Moviewalker_Stranger_Things',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://miro.medium.com/max/256/0*KUYsTxlcwk9iIVe3.jpg',
                            titlu: 'Game of Thrones',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/joinchat/AAAAAFQwYFQia9akoUPEmw',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://m.media-amazon.com/images/I/41x+WJxp19L._AA256_.jpg',
                            titlu: 'The Boss Baby',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/Moviewalker_Boss_Baby',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://is3-ssl.mzstatic.com/image/thumb/Purple123/v4/b1/e6/c4/b1e6c41d-964a-6f64-9d78-300c284e4940/source/256x256bb.jpg',
                            titlu: 'Breaking Bad',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/Moviewalker_Breaking_Bad',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://cdn130.picsart.com/316919878133201.jpg?type=webp&to=crop&r=256',
                            titlu: 'The End Of The F* World',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/Moviewalker_End_of_The_F_World',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://www.stylist.co.uk/images/app/uploads/2018/03/08100013/jessica-jones-crop-1520503305-1000x1000.jpg?w=256&h=256&fit=max&auto=format%2Ccompress',
                            titlu: 'Jessica Jones',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/Moviewalker_Jessica_Jones',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://apprecs.org/ios/images/app-icons/256/1c/398107676.jpg',
                            titlu: 'The Vampire Diaries',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/Moviewalker_Vampire_Diaries',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://m.media-amazon.com/images/I/510yBJ2zakL._AA256_.jpg',
                            titlu: 'Prison Break',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/Moviewalker_Prison_Break',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://m.media-amazon.com/images/I/41L-kVIGyIL._AA256_.jpg',
                            titlu: '13 Reasons Why',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/Moviewalker_13_Reasons_Why',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://miro.medium.com/fit/c/256/256/2*1kesM7nBlczRzTUUkbb1xw.jpeg',
                            titlu: 'Euphoria',
                            subtitlu: 'Serial',
                            tip: 'Vizionează',
                            link: 'https://t.me/Moviewalker_Euphoria',
                          ),

                       

                      ]),
                    ));
              },
              childCount: 1,
            ),
          ),
        ),
      ],
    ));
  }
}
