import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ira_app/core/base_state.dart';
import 'package:ira_app/core/get_it.dart';
import 'package:ira_app/helper/socket_helper.dart';
import 'package:ira_app/helper/stream_controller_helper.dart';
import 'package:ira_app/screens/chat/message_list.dart';
import 'package:ira_app/viewModel/chat_view_model_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends BaseState<ChatView> {
  TextEditingController _messageController = TextEditingController();
  ScrollController _controller = ScrollController();
  StreamSubscription<int> subscription;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  var vm = getIt<ChatListState>();
  // final state = getIt<ShufListState>();

  @override
  void initState() {
    super.initState();
    getMessages();
    SocketHelper.shared.connectSocket();
  }

  @override
  void dispose() async {
    subscription.cancel();
    _controller.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (vm.messageStatus !=
        MessageStatus.empty) if (MediaQuery.of(context).viewInsets.bottom > 0) {
      itemScrollController.scrollTo(
          index: vm.messageList.length - 1,
          duration: Duration(milliseconds: 200));
    }
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            child: Stack(
              children: [
                // Pop Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFE6E5E6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          width: 30,
                          height: 30,
                          child: Center(child: Icon(Icons.chevron_left)),
                        ),
                      )),
                ),
                // Center User info
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "operator",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "isOnline hseg",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                // Divider
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      color: Colors.black,
                      height: 0.20,
                    )),
                // User Avatar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://yt3.ggpht.com/a/AATXAJymPwE0-PXbFjcJDrZ9unwi5qXZq3dWLB53ha7nwZw=s100-c-k-c0xffffffff-no-rj-mo")),
                          color: Colors.red,
                          shape: BoxShape.circle),
                    ),
                  ),
                )
              ],
            ),
          ),
          preferredSize: Size(double.infinity, 60),
        ),
        body: Column(
          children: [
            Flexible(child: buildChatScreen()),
            Container(
              width: double.infinity,
              color: Colors.black,
              height: 0.20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon((Icons.image)), onPressed: selectImage),
                  Flexible(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        maxLines: null,
                        style: TextStyle(fontSize: 16.0),
                        controller: _messageController,
                        decoration: InputDecoration.collapsed(
                          border: UnderlineInputBorder(),
                          hintText: 'Message',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        // onChanged: (text) => {
                        //   if(text.length > 1 && text.length <3){
                        //     SocketHelper.shared.addUsersWriting(receiver: widget.receiverID)
                        //   }
                        // },
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            if (_messageController.text.trim().isNotEmpty) {
                              SocketHelper.shared.sendMessage(
                                  message: _messageController.text,
                                  file: false,
                                  type: 'text',
                                  whoType: 'user');
                              _messageController.clear();
                            }
                          }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChatScreen() {
    return Observer(builder: (_) {
      if (vm.messageStatus == MessageStatus.empty) // EMPTY
        return Stack(
          children: [
            Center(
              child: Text('Empty:)'),
            )
          ],
        );
      else if (vm.messageStatus == MessageStatus.loading) // LOADING
        return Center(child: CircularProgressIndicator());
      else
        return MessageListView(
            // LOADED WİTH DATA
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener);
    });
  }

  getMessages() async {
    subscription = StreamControllerHelper.shared.stream.listen((index) {
      if (index > 1) {
        itemScrollController.scrollTo(
            index: index - 1, duration: Duration(milliseconds: 500));
      }
    });
    await vm.fetchMessage();
    if (vm.messageStatus != MessageStatus.empty)
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        itemScrollController.jumpTo(index: vm.messageList.length - 1);
      });
  }

  selectImage() async {
    File file = await FilePicker.getFile();
    var listImage = file.readAsBytesSync();
    var base64 = base64Encode(listImage);
    SocketHelper.shared.sendMessage(message: base64, file: true, type: 'image');
  }
}
