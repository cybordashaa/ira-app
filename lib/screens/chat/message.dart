import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/screens/chat/hero_image.dart';
import 'package:ira_app/viewModel/chat_view_model.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatMessage extends StatelessWidget {
  final ChatViewModel message;
  ChatMessage({this.message, bool file});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (message.file) {
      return buildImage(context);
    } else {
      return buildText(context);
    }
  }

  Widget buildImage(BuildContext context) {
    return Align(
      alignment: message.whoType == 'user'
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: message.whoType == 'user'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HeroImage(
                          imageProvider: NetworkImage(
                              '$serverURL/app/upload/images/${message.content}')))),
              child: Container(
                decoration: BoxDecoration(
                    color: message.whoType == 'user'
                        ? Color(0xFF1289FD)
                        : Color(0xFFE5E4EA),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Hero(
                        tag: '',
                        // child: Image(
                        //   image: AssetImage('assets/images/cardimage.jpg'),
                        //   fit: BoxFit.cover,
                        //   height: 125,
                        //   width: 350,
                        // )
                        child: CachedNetworkImage(
                          imageUrl:
                              "$serverURL/app/upload/images/${message.content}",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            height: 125,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/images/place.png",
                            fit: BoxFit.cover,
                            height: 125,
                            width: MediaQuery.of(context).size.width,
                          ),
                          height: 125,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
              child: Text(
                  DateFormat('HH:mm').format(DateTime.parse(message.createdAt)),
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            )
          ],
        ),
      ),
    );
  }

  Widget buildText(BuildContext context) {
    return Align(
      alignment: message.whoType == 'user'
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
        child: Column(
          crossAxisAlignment: message.whoType == 'user'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: message.whoType == 'user'
                      ? Color(0xFF1289FD)
                      : Color(0xFFE5E4EA)),
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              child: message.file
                  ? Image.memory(base64Decode(message.content))
                  : Text(message.content,
                      style: TextStyle(
                          color: message.whoType == 'user'
                              ? Colors.white
                              : Colors.black)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 4),
              child: Text(
                DateFormat('HH:mm')
                    .format(DateTime.parse(message.createdAt).toLocal()),
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
