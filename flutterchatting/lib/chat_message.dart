import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String txt;
  final Animation<double> animation;

  const ChatMessage(
    this.txt, {
    @required Animation<double> this.animation,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1.0,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: Text('Test'),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UserName',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(txt)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
