import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "Dating App",
      home: new HomePage()
    );
  }
}
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Dating Chat"),
      ),
      body: new ChatScreen(),
    );
  }
}


class ChatScreen extends StatefulWidget{
  @override
  State createState() => new ChatScreenState();
}
class ChatScreenState extends State<ChatScreen>{

  File _image;
  Future getImage(bool isCamera) async{
    File image;
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    else{
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

 final TextEditingController _textController = new TextEditingController();
 final List<ChatMessage>  _messages = <ChatMessage>[];
 void _handleSubmitted(String text){
   _textController.clear();
   ChatMessage message = new ChatMessage(
     text: text,
   );
   setState(() {
     _messages.insert(0, message);
   });
 }

  Widget _textComposerWidget(){
    return new IconTheme(
      data: new IconThemeData(color: Colors.pinkAccent),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child : new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration.collapsed( hintText: "Send a message"),
                controller: _textController,
                onSubmitted: _handleSubmitted,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              child: new IconButton(icon: new Icon(Icons.insert_drive_file), onPressed: () {getImage(false);},
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 3.0),
              child: new IconButton(icon: new Icon(Icons.camera_alt), onPressed: () {getImage(true);},
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(icon: new Icon(Icons.send), onPressed: ()=> _handleSubmitted(_textController.text),
              ),
            ),
            _image == null?Container() : Image.file(_image,height: 200,width: 200,),
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return new Column(
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_,int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        new Divider(height: 1.0,),
        new Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _textComposerWidget(),
        )
      ],
    );
  }
}
const String _name = "Aditya";
class ChatMessage extends StatelessWidget{
  final String text;
  ChatMessage({this.text});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
              child: new Text(_name[0]),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Horizontal
            children: <Widget>[
              new Text(_name,style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: EdgeInsets.only(top: 5.0),
                child: new Text(text),
              )
            ],
          )
        ],
      ),
    );
  }
}