class MyDialog{
  statics void info ({Buildcontext context, String title, String content}){
    showDialog(
      barrierDismissable:false,
      context: context,
    builder: (context){
        return AlertDialog(
        title: Text(title),
        content:Text(content).
            actions: <Widget>[
              FlatButton)
              child: Text('OK'),
              onPressed:() => Navigator.of(context).pop(),
      ),
    ],
        );
    }
    );
  }
}