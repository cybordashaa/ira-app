import 'package:flutter/material.dart';
import 'package:ira_app/core/get_it.dart';
import 'package:ira_app/helper/preferences_helper.dart';
import 'package:ira_app/helper/stream_controller_helper.dart';
import 'package:ira_app/viewModel/chat_view_model_list.dart';
import 'package:ira_app/models/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketHelper {
  static final shared = SocketHelper();
  ChatListState vm = ChatListState();

  IO.Socket socket;
  var id;
  var token;

  // void connectSocket() async {
  //   token = await SharedPreferencesHelper.shared.getUserToken();
  //   id = await SharedPreferencesHelper.shared.getMyID();
  //   socket = IO.io('http://192.168.0.111:8001', <String, dynamic>{
  //     'transports': ['websocket'],
  //     'autoConnect': false,
  //     'query': {'token': token}
  //   });
  //   socket.connect();

  //   socket.on('connection', (_) {
  //     print("connect");
  //     socket.emit('example', {'msg': "client msg send"});
  //     socket.on('onMessage', (data) {
  //       print(data);
  //       var content = data['message'].toString();
  //       var uID = data['user'];
  //       var opID = data['operator'].toString();

  //       getIt<ChatListState>().addMessage(message: content, op: opID);
  //       StreamControllerHelper.shared
  //           .setLastIndex(getIt<ChatListState>().messageList.length);
  //     });
  //   });
  // }
  void connectSocket() async {
    id = await SharedPreferencesHelper.shared.getMyID();
    token = await SharedPreferencesHelper.shared.getUserToken();
    socket = IO.io('http://192.168.0.111:8001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'token': token}
    });
    socket.connect();
    socket.on('connect', (_) {
      print('Bağlandı');
      // socket.emit('example', {'msg': id});
      socket.on('onMessage', (data) {
        if (data['operator'] != null) {
          var content = data['message'].toString();
          // var uID = data['user'];
          var opID =
              data['operator']['_id'] == null ? null : data['operator']['_id'];
          print('--opID$opID');

          getIt<ChatListState>().addMessage(message: content, op: null);
          StreamControllerHelper.shared
              .setLastIndex(getIt<ChatListState>().messageList.length);
        }
      });
    });
  }

  void sendMessage({@required String message, bool file, String type}) {
    getIt<ChatListState>()
        .addMessage(message: message, op: null, file: file, file_type: type);
    StreamControllerHelper.shared
        .setLastIndex(getIt<ChatListState>().messageList.length);

    socket.emit('chatroomMessage', {
      "chatroomId": id,
      "message": message,
      "ops": null,
      "file": file,
      "type": type,
    });
  }

  void joinRoom({bool ops}) {
    socket.emit('joinRoom', {
      "chatroomId": id,
      "ops": ops,
    });
  }
}
