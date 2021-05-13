import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatting/chat_message.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController=TextEditingController();
  List<String> _chats=[];
  GlobalKey<AnimatedListState> _animListKey=GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
              child: AnimatedList(
                key: _animListKey,
                reverse: true,
                itemBuilder: _buildItem,
              )
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    onSubmitted: _handleSubmitted,
                    decoration: InputDecoration(
                      hintText: 'Send a Message',
                    ),
                  ),
                ),
                SizedBox(width: 8.0,),
                TextButton(
                    onPressed: () {
                     _handleSubmitted(_textEditingController.text);
                    },
                    child: Text('Send'),
                  style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.green)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildItem(context, index, animation) {
    return ChatMessage(_chats[index], animation : animation);
  }
  void _handleSubmitted(String text) {
    Logger().d('Logger.d : '+text);
    _textEditingController.clear();
    _chats.insert(0,text);
    _animListKey.currentState.insertItem(0);
  }
}
