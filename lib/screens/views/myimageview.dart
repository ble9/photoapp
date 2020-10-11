import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//profile pic borken
class MyImageView{
  static CachedNetworkImage network (
  {@required String imageUrl, @required BuildContext context}) =>
      CachedNetworkImage(
        imageUrl: imageUrl ?? 'http://noaddress_null',
        errorWidget: (context, url, error)=> Icon(Icons.error, size: 30),
        progressIndicatorBuilder: (context, url, progress) =>
        CircularProgressIndicator(
          value: progress.progress,
      ),
  );
}