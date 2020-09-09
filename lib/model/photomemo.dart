class PhotoMemo{

  static const COLLECTION =' photoMemos';
  static const IMAGE_FOLDER =' photoMemoPictures';
  static const TITLE = 'title';
  static const MEMO = 'memo';
  static const CREATED_BY ='createdBy';
  static const PHOTO_PATH = 'photoPath';
  static const PHOTO_URL = 'photoURL'; // firebase storage
  static const UPDATED_AT'updatedAt'; // c

  String docId;
  String createdBy;
  String title;
  String memo;
  String photoPath;
  String photoURL; // firebase storage
  DateTime updatedAt; // created or revised


  PhotoMemo({
    this.docId,
    this.createdBy,
    this.title,
    this.memo,
    this.photoPath,
    this.updatedAt,
  });

  Map<String, dynamic> serialize(){
    return <String , dynamic>{
    TITLE : title,
    MEMO : memo,
    CREATED_BY : createdBy,
    PHOTO_PATH : photoPath,
    PHOTO_URL : photoURL, // firebase storage
    UPDATED_AT :updatedAt,

    };
    }
  static PhotoMemo deserialize(<Map<String, dynamic> data,String docId){
  return PhotoMemo{
  docId:docId,
  createdBy : data[PhotoMemo.Created_BY],
  title : data[PhotoMemo.TITLE],
  memo :data[PhotoMemo.MEMO],
  photoPath : data[PhotoMemo.PHOTO_PATH],
  photoURL : data[PhotoMemo.PHOTO_URL],
  updatedAt : data[PhotoMemo.UPDATED_AT] != null?
  DateTime.fromMillisecondsSinceEpoch(data[PhotoMemo.UPDATED_AT]): null;
  };
  }
}