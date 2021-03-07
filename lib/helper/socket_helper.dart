import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/core/get_it.dart';
import 'package:ira_app/helper/preferences_helper.dart';
import 'package:ira_app/helper/stream_controller_helper.dart';
import 'package:ira_app/provider/chat_provider.dart';
import 'package:ira_app/viewModel/chat_view_model_list.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketHelper {
  static final shared = SocketHelper();
  ChatListState vm = ChatListState();

  IO.Socket socket;
  var id;
  var token;
  void connectSocket() async {
    try {
      id = await SharedPreferencesHelper.shared.getMyID();
      token = await SharedPreferencesHelper.shared.getUserToken();
      socket = IO.io(serverURL, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'query': {'token': token}
      });
      socket.connect();
      print(socket.connected);
      socket.on('connect', (_) {
        print('connect');
        // socket.emit('example', {'msg': id}););
        socket.on('onMessage', (data) {
          var message = data['message'].toString();
          var operator = data['operator'].toString() ?? null;
          var isFile = data['file'];
          var fileType = data['file_type'];
          String whoType = data['whoType'];
          print("$whoType");
          // getIt<ChatListState>().addMessage(
          //     message: message,
          //     op: operator,
          //     file: isFile,
          //     file_type: fileType,
          //     whoType: whoType);
          getIt<ChatProvider>().addMessage(
              contentMessage: message,
              op: operator,
              file: isFile,
              fileType: fileType,
              whoType: whoType);

          StreamControllerHelper.shared
              .setLastIndex(getIt<ChatProvider>().messageCount);
        });
      });

      socket.on('disconnect', (_) => print('disconnect'));
    } catch (err) {
      print(err.toString());
    }
  }

  void sendMessage(
      {@required String message,
      bool file,
      String type,
      String whoType,
      var fileData}) {
    // getIt<ChatListState>().addMessage(
    //     message: message,
    //     op: null,
    //     file: file,
    //     file_type: type,
    //     whoType: whoType);
    // StreamControllerHelper.shared
    //     .setLastIndex(getIt<ChatListState>().messageList.length);

    socket.emit('chatroomMessage', {
      "chatroomId": id,
      "message": message,
      "ops": false,
      "file": file,
      "type": type,
      "whoType": whoType,
      "fileData": fileData
    });
  }

  void joinRoom({bool ops}) {
    socket.emit('joinRoom', {
      "chatroomId": id,
      "ops": ops,
    });
  }
}
