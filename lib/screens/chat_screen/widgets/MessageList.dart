import 'package:flutter/material.dart';
import 'package:ira_app/provider/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import './messageItem.dart';

class MessageList extends StatelessWidget {
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  MessageList({this.itemScrollController, this.itemPositionsListener});
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          //remove scroll glow ListView
          notification.disallowGlow();
          if (notification is UserScrollNotification) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
          return;
        },
        child: ScrollablePositionedList.builder(
          padding: EdgeInsets.all(20),
          itemCount: chatProvider.messageCount,
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemBuilder: (context, index) {
            final message = chatProvider.messages[index];
            return ChatMessageItem(message: message);
          },
        ),
      );
    });
  }
}
