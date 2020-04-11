import 'package:Vanto/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Music extends StatefulWidget {
  Music({Key key}) : super(key: key);

  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Muzică'),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () {
            return Future<void>.delayed(const Duration(seconds: 1));
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
                        Elem(
                            imagine:
                                'https://alternative.me/icons2/youtube-music.png',
                            titlu: 'English',
                            subtitlu: 'Muzică',
                            tip: 'Ascultă',
                            link: 'https://t.me/vm_chanId_english',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://alternative.me/icons2/youtube-music.png',
                            titlu: 'România',
                            subtitlu: 'Muzică',
                            tip: 'Ascultă',
                            link: 'https://t.me/vm_chanId_romania',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://alternative.me/icons2/youtube-music.png',
                            titlu: 'Manele',
                            subtitlu: 'Muzică',
                            tip: 'Ascultă',
                            link: 'https://t.me/vm_chanId_manele',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://alternative.me/icons2/youtube-music.png',
                            titlu: 'International',
                            subtitlu: 'Muzică',
                            tip: 'Ascultă',
                            link: 'https://t.me/vm_chanId_international',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://alternative.me/icons2/youtube-music.png',
                            titlu: 'Instrumentals',
                            subtitlu: 'Muzică',
                            tip: 'Ascultă',
                            link: 'https://t.me/vm_chanId_instrumentals',
                          ),
                        Div(),
                        Elem(
                            imagine:
                                'https://alternative.me/icons2/youtube-music.png',
                            titlu: 'RoTrap',
                            subtitlu: 'Muzică',
                            tip: 'Ascultă',
                            link: 'https://t.me/ly_music_rotra',
                          ),
                        
                        
                      ],
                    )
                  ),
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