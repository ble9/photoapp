class PhotoMemo {
  //field name for Firestore documents
  static const COLLECTION = 'photoMemos';
  static const IMAGE_FOLDER = 'photoMemoPictures';
  static const PROFILE_FOLDER  = 'profilePictures';
  static const TITLE = 'title';
  static const MEMO = 'memo';
  static const CREATED_BY = 'createdBy';
  static const PHOTO_URL = 'photoURL';
  static const PHOTO_PATH = 'photoPath';
  static const UPDATED_AT = 'updatedAt';
  static const SHARED_WITH = 'sharedWith';
  static const IMAGE_LABELS = 'imageLabels';
  static const MIN_CONFIDENCE = 0.7;

  String docID; //Firestore doc id
  String createdBy;
  String title;
  String memo;
  String photoPath; //Firebase storage; image file name
  String photoURL; //Firebase storage; image URL for internet access
  DateTime updatedAt; //created or revised time
  List<dynamic> sharedWith; //list of emails
  List<dynamic> imageLabels; //image labels generated by ML

  PhotoMemo({
    this.docID,
    this.createdBy,
    this.title,
    this.memo,
    this.photoPath,
    this.photoURL,
    this.updatedAt,
    this.sharedWith,
    this.imageLabels,
  }) {
    this.sharedWith ??= [];
    this.imageLabels ??= [];
  }

  // convert Dart object to Firestore document
  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      TITLE: title,
      CREATED_BY: createdBy,
      MEMO: memo,
      PHOTO_PATH: photoPath,
      PHOTO_URL: photoURL,
      UPDATED_AT: updatedAt,
      SHARED_WITH: sharedWith,
      IMAGE_LABELS: imageLabels,

    };
  }

  //convert Firestore document to Dart object
  static PhotoMemo deserialize(Map<String, dynamic> data, String docID) {
    return PhotoMemo(
      docID: docID,
      createdBy: data[PhotoMemo.CREATED_BY],
      title: data[PhotoMemo.TITLE],
      memo: data[PhotoMemo.MEMO],
      photoPath: data[PhotoMemo.PHOTO_PATH],
      photoURL: data[PhotoMemo.PHOTO_URL],
      sharedWith: data[PhotoMemo.SHARED_WITH],
      imageLabels: data[PhotoMemo.IMAGE_LABELS],
      updatedAt: data[PhotoMemo.UPDATED_AT] != null
          ? DateTime.fromMillisecondsSinceEpoch(
          data[PhotoMemo.UPDATED_AT].millisecondsSinceEpoch)
          : null,
    );
  }

  @override
  String toString() {
    return '$docID  $createdBy  $title  $memo  \n  $photoURL';
  }
}
