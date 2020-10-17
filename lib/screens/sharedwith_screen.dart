import 'package:flutter/material.dart';
import 'package:photomemo/model/photomemo.dart';
import 'package:photomemo/screens/views/myimageview.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SharedWithScreen extends StatefulWidget {
  static const routeName = '/home/sharedWithScreen';

  @override
  State<StatefulWidget> createState() {
    return _SharedWithState();
  }
}

class _SharedWithState extends State<SharedWithScreen> {
  _Controller con;
  List<PhotoMemo> photoMemos;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    Map arg = ModalRoute.of(context).settings.arguments;
    photoMemos ??= arg['sharedPhotoMemoList'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared With me'),
      ),
      body: photoMemos.length == 0
          ? Text(
              'No PhotoMemos shared with me',
              style: TextStyle(fontSize: 20),
            )
          : CarouselSlider.builder(
              options: CarouselOptions(
                height: 900,
                autoPlay: true,
                viewportFraction: 1.0,
                aspectRatio: 1.0,
                initialPage: 0,
              ),
              itemCount: photoMemos.length,
              itemBuilder: (BuildContext context, int index) => Container(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 2.0, 5.0),
                child: Card(
                  elevation: 7.0,
                  color: Colors.blue[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 450,
                        width: MediaQuery.of(context).size.width,
                        child: MyImageView.network(
                          imageUrl: photoMemos[index].photoURL,
                          context: context,
                        ),
                      ),
                      Text(
                        'Title: ${photoMemos[index].title}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        thickness: 4.0,
                        color: Colors.redAccent,
                      ),
                      Text(
                        '${photoMemos[index].memo}',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        'Created By: ${photoMemos[index].createdBy} ',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Updated At: ${photoMemos[index].updatedAt} ',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Shared With: ${photoMemos[index].sharedWith}',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

//
class _Controller {
  _SharedWithState _state;

  _Controller(this._state);
}
