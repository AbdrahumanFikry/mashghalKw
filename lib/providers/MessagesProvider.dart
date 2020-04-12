import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mashghal_co/models/messageModel.dart';
import 'package:mashghal_co/models/roomsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/httpException.dart';

class MessagesProvider with ChangeNotifier {
  String _token;
  String _userId;
  List<Message> _messages = [];
  MessagesModel _messagesModel;

  List get messages {
    return [..._messages];
  }

  RoomsModel _roomsModel;

  RoomsModel get roomsModel {
    return _roomsModel;
  }

  //-------------------------fetch   Rooms  Model-------------------------------
  Future<void> fetchRooms() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    const url = 'https://mashghllkw.com/api/v1/chat/getchaters';
    try {
      final response = await http.post(url, body: {
        'user_id': _userId,
      });
      final responseData = json.decode(response.body);
//      print('::::::::::::::Rooms:::::::::::::::::::' + response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _roomsModel = RoomsModel.fromJson(responseData);
        notifyListeners();
        return _roomsModel;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  //-------------------------fetch Messages Model-------------------------------
  Future<void> fetchMessages(int receiverId) async {
    const url = 'https://mashghllkw.com/api/v1/chat/getchat';
    try {
      final response = await http.post(url, body: {
        'sender_id': _userId,
        'receiver_id': receiverId.toString(),
      });
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _messagesModel = MessagesModel.fromJson(responseData);
        _messages = _messagesModel.data;
        notifyListeners();
        return _messages;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  //------------------------------send Message----------------------------------
  Future<void> sendMessage(int receiverId, String message) async {
    print(':::::::::::::::::::::::::::::::::::::startimg::::::::::::::::::::::::::::::::::::::');
    const url = 'https://mashghllkw.com/api/v1/chat/makechat';
    try {
      final response = await http.post(url, body: {
        'sender_id': _userId,
        'receiver_id': receiverId.toString(),
        'message': message,
      });
      final responseData = json.decode(response.body);
      print(':::::::::::::::::::::::::::::::::::::::' + response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        notifyListeners();
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }
  //------------------------------delete Chat-----------------------------------
  Future<void> deleteChat(int chatId) async {
    const url = 'https://mashghllkw.com/api/v1/chat/delchat';
    try {
      final response = await http.post(url, body: {
        'chat_id': chatId.toString(),
      });
      final responseData = json.decode(response.body);
//      print(':::::::::::::::::::::::::::::::::::::::' + response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        notifyListeners();
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

}
