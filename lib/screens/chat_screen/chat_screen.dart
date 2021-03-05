import 'package:emoji_picker/emoji_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ira_app/components/widgets/custom_tile.dart';
import 'package:ira_app/helper/socket_helper.dart';
import 'package:ira_app/provider/chat_provider.dart';
import 'package:ira_app/universal_variables.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:ira_app/helper/stream_controller_helper.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ira_app/core/get_it.dart';
import './widgets/MessageList.dart';
import './widgets/modal.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = '/chat_screen';

  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamSubscription<int> subscription;
  // scroll positioned
  ItemScrollController itemScrollController;
  ItemPositionsListener itemPositionsListener;

  FocusNode textFieldFocus = FocusNode();
  bool isWriting = false;
  bool showEmojiPicker = false;
  var chat = getIt<ChatProvider>();
  @override
  void initState() {
    super.initState();
    itemScrollController = new ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    getMessages();
  }

  void dispose() async {
    subscription.cancel();
    textEditingController.dispose();
    super.dispose();
  }

  getMessages() async {
    subscription = StreamControllerHelper.shared.stream.listen((index) {
      if (index > 1) {
        itemScrollController.scrollTo(
            index: index - 1, duration: Duration(milliseconds: 500));
      }
    });
    final fetchMessages = Provider.of<ChatProvider>(context, listen: false);
    await Future.microtask(() => fetchMessages.getMessages());
    if (fetchMessages.messageCount > 0)
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        itemScrollController.jumpTo(index: fetchMessages.messageCount - 1);
      });
  }

  // void _scrollToBottom() {
  //   if (Provider.of<ChatProvider>(context, listen: false).messageCount != 0) {
  //     _listScrollController.animateTo(
  //         _listScrollController.position.maxScrollExtent,
  //         duration: Duration(milliseconds: 300),
  //         curve: Curves.elasticOut);
  //   } else {
  //     Timer(Duration(milliseconds: 400), () => _scrollToBottom());
  //   }
  // }

  showKeyBoard() => textFieldFocus.requestFocus();
  hideKeyBoard() => textFieldFocus.unfocus();

  hideEmojicontainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
      ),
      backgroundColor: Color(0xFFF5F6F9),
      body: Column(
        children: [
          Flexible(
              child: MessageList(
            itemPositionsListener: itemPositionsListener,
            itemScrollController: itemScrollController,
          )),
          chatControls(),
          showEmojiPicker
              ? Container(
                  child: emojiContainer(),
                )
              : Container()
        ],
      ),
    );
  }

  // emoji
  emojiContainer() {
    return EmojiPicker(
      bgColor: UniversalVariables.separatorColor,
      indicatorColor: Colors.blue,
      rows: 3,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        setState(() {
          isWriting = true;
        });
        textEditingController.text = textEditingController.text + emoji.emoji;
      },
      recommendKeywords: ["face", "happy", "party", "sad"],
      numRecommended: 30,
    );
  }

  // chat controlls
  Widget chatControls() {
    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }

    sendMessage() {
      var text = textEditingController.text;
      setState(() {
        isWriting = false;
      });

      if (textEditingController.text.trim().isNotEmpty) {
        SocketHelper.shared.sendMessage(
            message: text, file: false, type: 'text', whoType: 'user');
        textEditingController.clear();
        // Timer(
        //     Duration(milliseconds: 500),
        //     () => _listScrollController
        //         .jumpTo(_listScrollController.position.maxScrollExtent));
      }
    }

    selectImageSend() async {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result != null) {
        // if (!allowedImageTypes.contains(result.files.single.extension)) {
        //   print(" no not ");
        // }
        SocketHelper.shared.sendMessage(
            message: result.files.single.name,
            file: true,
            type: 'image',
            whoType: 'user',
            fileData: result.files.single.bytes);
      } else {
        // User canceled the picker
      }
    }

    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => showMaterialModalBottomSheet(
              context: context,
              builder: (context) => ModalFit(
                imageFunction: selectImageSend,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  gradient: UniversalVariables.fabGradient,
                  shape: BoxShape.circle),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: textEditingController,
                  focusNode: textFieldFocus,
                  onTap: () {
                    Timer(
                        Duration(milliseconds: 300),
                        () => itemScrollController.scrollTo(
                              duration: Duration(seconds: 2),
                              curve: Curves.elasticOut,
                              index: chat.messageCount - 1,
                            ));

                    hideEmojicontainer();
                  },
                  onChanged: (val) {
                    (val.length > 0 && val.trim() != "")
                        ? setWritingTo(true)
                        : setWritingTo(false);
                  },
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(50.0)),
                        borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    filled: true,
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    if (!showEmojiPicker) {
                      // keyboard is visible
                      hideKeyBoard();
                      showEmojiContainer();
                    } else {
                      //keyboard is hidden
                      showKeyBoard();
                      hideEmojicontainer();
                    }
                  },
                  icon: Icon(
                    Icons.face_outlined,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
          ),
          isWriting
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.record_voice_over),
                ),
          isWriting
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      gradient: UniversalVariables.fabGradient,
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 15,
                    ),
                    onPressed: () => sendMessage(),
                  ))
              : Container()
        ],
      ),
    );
  }
}

class ModalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function onTap;

  const ModalTile(
      {@required this.title,
      @required this.subtitle,
      @required this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomTile(
        mini: false,
        onTap: onTap,
        leading: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: UniversalVariables.receiverColor,
          ),
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            color: UniversalVariables.greyColor,
            size: 38,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: UniversalVariables.greyColor,
            fontSize: 14,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
