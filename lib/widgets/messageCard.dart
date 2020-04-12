import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../mainScreens/chatScreen.dart';
import '../providers/MessagesProvider.dart';
import '../widgets/generalAlertDialog.dart';


class MessageCard extends StatelessWidget {
  final int chatId;
  final int receiverId;
  final String receiverImage;
  final String receiverName;
  final String lastMessage;
  final String dateLastMessage;

  MessageCard(
      {this.chatId,
      this.receiverId,
      this.receiverImage,
      this.receiverName,
      this.dateLastMessage,
      this.lastMessage});

  void _deleteChat(BuildContext context) async {
    await Provider.of<MessagesProvider>(context,listen: false).deleteChat(chatId);
    await Provider.of<MessagesProvider>(context,listen: false).fetchMessages(receiverId);
  }


  Future<void> _showConfirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return GeneralDialog(
            content: 'هل بالفعل تريد حذف هذه المحادثه ؟',
            toDOFunction: () => _deleteChat(context),
          );
        });
  }
  void _startChat(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          receiverName: receiverName,
          receiverId: receiverId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _startChat(context),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        padding: const EdgeInsets.only(
          top: 0.0,
          bottom: 5.0,
          left: 5.0,
          right: 5.0,
        ),
        height: 85.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70.0),
          border: Border.all(
            color: Colors.grey[300],
            width: 1.0,
          ),
          color: Colors.grey[50],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(
            right: 10.0,
            left: 20.0,
            top: 0.0,
            bottom: 0.0,
          ),
          leading: Container(
            height: 75.0,
            width: 75.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image:
                    NetworkImage('https://mashghllkw.com/cdn/' + receiverImage),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                receiverName,
                style: TextStyle(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  fontSize: 14.0,
                  fontFamily: 'beINNormal',
                ),
              ),
              Spacer(),
              Text(
                dateLastMessage,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  fontFamily: 'beINNormal',
                ),
              ),
            ],
          ),
          subtitle: Text(
            lastMessage,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
              fontFamily: 'beINNormal',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
          trailing: GestureDetector(
            onTap: ()=>_showConfirmDialog(context),
            child: Icon(
              Icons.delete,
              color: Colors.grey,
              size: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
