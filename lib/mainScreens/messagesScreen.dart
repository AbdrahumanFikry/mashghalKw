import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';
import '../widgets/messageCard.dart';
import '../providers/MessagesProvider.dart';

class MessagesScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'messagesScreen';

  Future<void> _onRefresh(BuildContext context) async {
    await Provider.of<MessagesProvider>(context, listen: false).fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    final type = ModalRoute.of(context).settings.arguments;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'الرسائل',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 20.0,
              fontFamily: 'beINNormal',
            ),
          ),
          leading: type == 'user'
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(104, 57, 120, 10),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
              : new Container(),
        ),
        body: RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: Provider.of<MessagesProvider>(context, listen: false)
                    .fetchRooms(),
                builder: (context, dataSnapShot) {
                  if (dataSnapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: ColorLoader(
                        dotRadius: 5.0,
                        radius: 15.0,
                      ),
                    );
                  } else {
                    if (dataSnapShot.error != null) {
                      return Center(
                        child: ColorLoader(
                          dotRadius: 5.0,
                          radius: 15.0,
                        ),
                      );
                    }
                    if (dataSnapShot.error != null) {
                      return Center(
                        child: Text(
                          'تحقق من اتصالك بالانترنت',
                          style: TextStyle(
                            fontFamily: 'beINNormal',
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Consumer<MessagesProvider>(
                          builder: (context, room, child) => room
                                  .roomsModel.data.isEmpty
                              ? Center(
                                  child: Text(
                                    'الرسائل فارغه',
                                    style: TextStyle(
                                      fontFamily: 'beINNormal',
                                      color: Colors.grey,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: room.roomsModel.data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      child: MessageCard(
                                        chatId:
                                            room.roomsModel.data[index].chatId,
                                        receiverId:
                                            room.roomsModel.data[index].id,
                                        receiverImage:
                                            room.roomsModel.data[index].image,
                                        lastMessage: room.roomsModel.data[index]
                                                    .lastMessage ==
                                                null
                                            ? ' '
                                            : room.roomsModel.data[index]
                                                .lastMessage,
                                        dateLastMessage: room
                                            .roomsModel.data[index].createdAt,
                                        receiverName:
                                            room.roomsModel.data[index].name,
                                      ),
                                    );
                                  },
                                ),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
