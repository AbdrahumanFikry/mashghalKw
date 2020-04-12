import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/googleMaps.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';
import '../widgets/chatWidgets.dart';
import '../providers/MessagesProvider.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'chatScreen';
  final int receiverId;
  final String receiverName;

  ChatScreen({this.receiverId, this.receiverName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //-------------------------------variables------------------------------------
  final messageController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _message;
  File _image;
  List<Widget> _messages = [];

  //-------------------------------methods--------------------------------------
  void _onSaved(value) {
    _message = value;
  }

  @override
  void didChangeDependencies() {
    Timer(Duration(seconds: 2), _listen);
    super.didChangeDependencies();
  }

  //----------------------------imageHandler------------------------------------
  Future _openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  //----------------------------------------------------------------------------
  Future<void> _listen() async {
    await Provider.of<MessagesProvider>(context, listen: false)
        .fetchMessages(widget.receiverId);
    _messages = [];
    final messages = Provider.of<MessagesProvider>(context).messages;
    for (var message in messages) {
      final newMessage = MessageViewer(
        type: message.receiverId != widget.receiverId ? 'else' : 'me',
        content: message.message == null ? ' ' : message.message,
        date: message.msgDate,
      );
      _messages.add(newMessage);
    }
  }

  Future<void> _send() async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      await Provider.of<MessagesProvider>(context, listen: false)
          .sendMessage(widget.receiverId, _message);
    }
  }

  //---------------------------------build--------------------------------------
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            widget.receiverName,
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 20.0,
              fontFamily: 'beINNormal',
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(104, 57, 120, 10),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: ListView(
            children: <Widget>[
              //------------------------chatScreen----------------------------
              _messages.isEmpty
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: ColorLoader(
                          dotRadius: 5.0,
                          radius: 15.0,
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.yellow.withAlpha(64),
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.vertical -
                          106,
                      width: double.infinity,
                      child: ListView(
                        reverse: true,
                        padding: EdgeInsets.only(
                          top: 8.0,
                          right: 8.0,
                          left: 8.0,
                          bottom: 50.0,
                        ),
                        children: _messages,
                      ),
                    ),
              //--------------------------------------------------------------
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      GestureDetector(
                        onTap: _openCamera,
                        child: Icon(
                          Icons.camera_enhance,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: _openGallery,
                        child: Image.asset(
                          'assets/icons/image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GoogleMaps(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/icons/pin.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Spacer(),
                      Form(
                        key: _formKey,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          color: Colors.white,
                          child: TextFormField(
                            controller: messageController,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontFamily: 'beINNormal',
                              fontSize: 14.0,
                            ),
                            obscureText: false,
                            onChanged: _onSaved,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hintText: 'اكتب رساله...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'beINNormal',
                                fontSize: 14.0,
                              ),
                              filled: false,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            messageController.clear();
                            _send();
                          },
                          child: Text(
                            'ارسال',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontFamily: 'beINNormal',
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
