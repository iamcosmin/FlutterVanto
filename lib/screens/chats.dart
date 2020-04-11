import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  Chats({Key key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
 @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Conversații'),
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
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://scontent.fotp1-1.fna.fbcdn.net/v/t1.0-1/p160x160/66145606_718860935198978_7580388918323838976_o.jpg?_nc_cat=108&_nc_sid=dbb9e7&_nc_ohc=HJSsGRdX8_IAX8CBjyD&_nc_ht=scontent.fotp1-1.fna&_nc_tp=6&oh=e76479014ca34560c8b1d4f7f74c2adc&oe=5E8D5D81',
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: CupertinoColors.lightBackgroundGray,
                            ),
                            child: Text(
                              'Salutare!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.blueAccent,
                        ),
                        child: Text('Wow! Ce curat e aici!',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      ),
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://scontent.fotp1-1.fna.fbcdn.net/v/t1.0-9/84403608_997931673915582_265756560343433216_n.jpg?_nc_cat=107&_nc_sid=85a577&_nc_ohc=4pBGItcy0PQAX9Dn_-w&_nc_ht=scontent.fotp1-1.fna&oh=6c95a64bf76fe3eff81d844238c3dea7&oe=5E8E3818',
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: CupertinoColors.lightBackgroundGray,
                            ),
                            child: Text(
                              'Daaaa! E așa de frumos!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://scontent.fotp1-1.fna.fbcdn.net/v/t1.0-9/p960x960/80194503_739745906537182_5132976348150628352_o.jpg?_nc_cat=111&_nc_sid=85a577&_nc_ohc=kaCCaFUKME0AX-0JFaW&_nc_ht=scontent.fotp1-1.fna&_nc_tp=6&oh=8143a7fa41a5ce69219ae12c6330af01&oe=5E8EC249',
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: CupertinoColors.lightBackgroundGray,
                            ),
                            child: Text(
                              'Și mie îmi place!😍',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.blueAccent,
                        ),
                        child: Text('Îmi place foarte mult!',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.blueAccent,
                        ),
                        child: Text('Cum de arată așa?',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      ),
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://scontent.fotp1-1.fna.fbcdn.net/v/t1.0-1/p160x160/66145606_718860935198978_7580388918323838976_o.jpg?_nc_cat=108&_nc_sid=dbb9e7&_nc_ohc=HJSsGRdX8_IAX8CBjyD&_nc_ht=scontent.fotp1-1.fna&_nc_tp=6&oh=e76479014ca34560c8b1d4f7f74c2adc&oe=5E8D5D81',
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: CupertinoColors.lightBackgroundGray,
                            ),
                            child: Text(
                              'Păi, am făcut schimbări majore.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://scontent.fotp1-1.fna.fbcdn.net/v/t1.0-1/p160x160/66145606_718860935198978_7580388918323838976_o.jpg?_nc_cat=108&_nc_sid=dbb9e7&_nc_ohc=HJSsGRdX8_IAX8CBjyD&_nc_ht=scontent.fotp1-1.fna&_nc_tp=6&oh=e76479014ca34560c8b1d4f7f74c2adc&oe=5E8D5D81',
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            margin: const EdgeInsets.all(5.0),
                            width: 270,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: CupertinoColors.lightBackgroundGray,
                            ),
                            child: Text(
                              'De exemplu, aplicația e pe Flutter.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://scontent.fotp1-1.fna.fbcdn.net/v/t1.0-1/p160x160/66145606_718860935198978_7580388918323838976_o.jpg?_nc_cat=108&_nc_sid=dbb9e7&_nc_ohc=HJSsGRdX8_IAX8CBjyD&_nc_ht=scontent.fotp1-1.fna&_nc_tp=6&oh=e76479014ca34560c8b1d4f7f74c2adc&oe=5E8D5D81',
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: CupertinoColors.lightBackgroundGray,
                            ),
                            child: Text(
                              'Are design de iOS, etc.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.blueAccent,
                        ),
                        child: Text('Va exista dark mode?',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      ),
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://scontent.fotp1-1.fna.fbcdn.net/v/t1.0-9/p960x960/80194503_739745906537182_5132976348150628352_o.jpg?_nc_cat=111&_nc_sid=85a577&_nc_ohc=kaCCaFUKME0AX-0JFaW&_nc_ht=scontent.fotp1-1.fna&_nc_tp=6&oh=8143a7fa41a5ce69219ae12c6330af01&oe=5E8EC249',
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: CupertinoColors.lightBackgroundGray,
                            ),
                            child: Text(
                              'Eu sper că da...',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://scontent.fotp1-1.fna.fbcdn.net/v/t1.0-9/84403608_997931673915582_265756560343433216_n.jpg?_nc_cat=107&_nc_sid=85a577&_nc_ohc=4pBGItcy0PQAX9Dn_-w&_nc_ht=scontent.fotp1-1.fna&oh=6c95a64bf76fe3eff81d844238c3dea7&oe=5E8E3818',
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: CupertinoColors.lightBackgroundGray,
                            ),
                            child: Text(
                              'Cos a zis că da! De-abia aștept!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              'https://scontent.fotp1-1.fna.fbcdn.net/v/t1.0-1/p160x160/66145606_718860935198978_7580388918323838976_o.jpg?_nc_cat=108&_nc_sid=dbb9e7&_nc_ohc=HJSsGRdX8_IAX8CBjyD&_nc_ht=scontent.fotp1-1.fna&_nc_tp=6&oh=e76479014ca34560c8b1d4f7f74c2adc&oe=5E8D5D81',
                              height: 50.0,
                              width: 50.0,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: CupertinoColors.lightBackgroundGray,
                            ),
                            child: Text(
                              'Va avea!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.blueAccent,
                        ),
                        child: Text('Yessss!',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      ),
                      Text(
                        'Pentru mai multe caracteristici, mențineți aplicația actualizată!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 14,),
                      ),
                      CupertinoTextField(
                        placeholder: 'Trimite un mesaj!',
                      )
                    ],
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