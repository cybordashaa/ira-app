import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/models/message.dart';
import 'package:intl/intl.dart';
import '../hero_image.dart';

class ChatMessageItem extends StatelessWidget {
  final Message message;
  ChatMessageItem({@required this.message});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        alignment: message.whoType == 'operator'
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: message.whoType == 'operator'
            ? receiverLayout(message, context)
            : senderLayout(message, context),
      ),
    );
  }

  // client message sender layout
  Widget senderLayout(message, context) {
    Radius messageRadius = Radius.circular(10);
    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
            topLeft: messageRadius,
            topRight: messageRadius,
            bottomLeft: messageRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(context, message),
      ),
    );
  }

  Widget receiverLayout(Message message, context) {
    Radius messageRadius = Radius.circular(10);

    if (message.file) {
      if (message.file_type == 'image') {
        return Container(
          margin: EdgeInsets.only(top: 12),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: messageRadius,
              topRight: messageRadius,
              bottomLeft: messageRadius,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: getMessage(context, message),
          ),
        );
      }
    }
    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(context, message),
      ),
    );
  }

  // get message
  getMessage(context, Message message) {
    if (message.file) {
      if (message.file_type == 'image') {
        return buildImage(context, message);
      }
    }
    return Text(
      '${message.message}',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget buildImage(BuildContext context, message) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HeroImage(
                  imageProvider: NetworkImage(
                      'http://192.168.0.117:8001/app/upload/images/${message.message}')))),
      child: Container(
        decoration: BoxDecoration(
            color: message.whoType == 'user'
                ? Color(0xFF1289FD)
                : Color(0xFFE5E4EA),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Hero(
              tag: '${message.message}',
              // child: Image(
              //   image: AssetImage('assets/images/cardimage.jpg'),
              //   fit: BoxFit.cover,
              //   height: 125,
              //   width: 350,
              // )
              child: CachedNetworkImage(
                imageUrl:
                    "http://192.168.0.117:8001/app/upload/images/${message.message}",
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
    );
  }
}
