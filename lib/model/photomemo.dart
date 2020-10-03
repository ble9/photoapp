import 'package:flutter/material.dart';

class PhotoMemo {

  static const COLLECTION = ' photoMemos';
  static const IMAGE_FOLDER = ' photoMemoPictures';
  static const TITLE = 'title';
  static const MEMO = 'memo';
  static const CREATED_BY = 'createdBy';
  static const PHOTO_PATH = 'photoPath';
  static const PHOTO_URL = 'photoURL'; // firebase storage
  static const UPDATED_AT = 'updatedAt';// c
  static const SHARED_WITH = 'sharedWith';
  static const  IMAGE_LABELS = ' imageLabels';
  static const MIN_CONFIDENCE = 0.7;

  String docId;
  String createdBy;
  String title;
  String memo;
  String photoPath;
  String photoURL; // firebase storage
  DateTime updatedAt; // created or revised
  List<dynamic> sharedWith;
  List<dynamic> imageLabels;

  PhotoMemo({
    this.docId,
    this.createdBy,
    this.title,
    this.memo,
    this.photoPath,
    this.updatedAt,
    this.photoURL,
    this.sharedWith,
    this.imageLabels,
  }) {
    this.sharedWith ??=[];
    this.imageLabels ??=[];
  }
  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      TITLE: title,
      MEMO: memo,
      CREATED_BY: createdBy,
      PHOTO_PATH: photoPath,
      PHOTO_URL: photoURL, // firebase storage
      UPDATED_AT: updatedAt,
      SHARED_WITH: sharedWith,
      IMAGE_LABELS: imageLabels,

    };
  }

  static PhotoMemo deserialize(Map<String, dynamic> data, String docId) {
    return PhotoMemo(
        docId: docId,
        createdBy: data[PhotoMemo.CREATED_BY],
        title: data[PhotoMemo.TITLE],
        memo: data[PhotoMemo.MEMO],
        photoPath: data[PhotoMemo.PHOTO_PATH],
        photoURL: data[PhotoMemo.PHOTO_URL],
        sharedWith: data[PhotoMemo.SHARED_WITH],
        imageLabels: data[PhotoMemo.IMAGE_LABELS],
        updatedAt: data[PhotoMemo.UPDATED_AT] != null ?
          DateTime.fromMillisecondsSinceEpoch(data[PhotoMemo.UPDATED_AT].millisecondsSinceEpoch)  : null,
    );
  }
  @override
  String toString(){
    return '$docId $createdBy $title $memo \n $photoURL';
  }
}