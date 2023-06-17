import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/features/search_delegate/my_search_screen.dart';
import 'package:ecommerce_major_project/main.dart';
import 'package:flutter/material.dart';

import 'package:dialog_flowtter/dialog_flowtter.dart';

import 'message_screen.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  late DialogFlowtter dialogFlowtter;

  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];
  bool isUserTyping = false;

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: GlobalVariables.getAppBar(
            title: "eSHOP Support",
            wantActions: false,
            context: context,
            onClickSearchNavigateTo: MySearchScreen()),
        body: Stack(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: mq.height * .8,
              opacity: AlwaysStoppedAnimation(.015),
              colorBlendMode: BlendMode.dst,
            ),
            Container(
              child: Column(children: [
                Expanded(child: MessageScreen(messages: messages)),
                messages.isNotEmpty || isUserTyping
                    ? SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          suggestedMessages(
                              text: "Become a member", onTapFunction: () {}),
                          suggestedMessages(
                              text: "Return a product", onTapFunction: () {}),
                        ],
                      ),
                SizedBox(height: mq.height * .01),
                Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 8),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 213, 213, 213),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                  onChanged: (val) {
                                    if (val.isNotEmpty) {
                                      setState(() {
                                        isUserTyping = true;
                                      });
                                    } else {
                                      setState(() {
                                        isUserTyping = false;
                                      });
                                    }
                                  },
                                  cursorColor: Colors.black,
                                  controller: _controller,
                                  // style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      hintText: "Message",
                                      border: InputBorder.none)))),
                      IconButton(
                        onPressed: () {
                          sendMessage(_controller.text);
                          FocusScope.of(context).unfocus();
                          _controller.clear();
                        },
                        icon: Icon(Icons.send, color: Colors.grey.shade800),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Empty field")));
    }
    //handling user message
    else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) {
        return;
      }
      //handling dialog flowtter message
      else {
        setState(() {
          addMessage(response.message!);
        });
      }
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add(
        {'message': message.text!.text![0], 'isUserMessage': isUserMessage});
  }

  suggestedMessages(
      {required String text, required VoidCallback onTapFunction}) {
    return InkWell(
      onTap: () {
        sendMessage(text);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          constraints: BoxConstraints(maxWidth: mq.width * .66),
          decoration: BoxDecoration(
            color: Colors.black87,
            // border: Border.all(color: Colors.black, width: .5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(text, style: GlobalVariables.whiteTextStlye),
        ),
      ),
    );
  }
}
