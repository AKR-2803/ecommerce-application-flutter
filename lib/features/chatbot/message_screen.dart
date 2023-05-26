import 'package:ecommerce_major_project/constants/global_variables.dart';
import 'package:ecommerce_major_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

class MessageScreen extends StatefulWidget {
  final List messages;
  const MessageScreen({super.key, required this.messages});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    print("\n\n ===============> Messages are : ${widget.messages}");
    return widget.messages.isEmpty
        ? Center(
            child: SizedBox(
            height: mq.height * 0.28,
            width: mq.width * 0.6,
            child: Card(
              elevation: 1,
              color: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.01, color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.all(mq.height * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hi I'm your eSHOP buddy",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: mq.height * 0.03),
                    MaterialButton(
                      onPressed: () {},
                      child: Image.asset(
                        "assets/images/chatbot2.png",
                        height: mq.height * .1,
                      ),
                    ),
                    SizedBox(height: mq.height * 0.03),
                    const Text("How can I help you?",
                        style: TextStyle(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center),
                    SizedBox(height: mq.height * 0.02),
                    //on tapping this button send an initial message
                  ],
                ),
              ),
            ),
          ))
        : ListView.separated(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.messages.length,
            itemBuilder: (context, index) {
              return widget.messages[index]['isUserMessage']
                  ? userMessage(index)
                  : botMessage(index);
            },
            separatorBuilder: (_, __) =>
                const Padding(padding: EdgeInsets.only(top: 5)),
          );
  }

  Widget userMessage(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 10,
          color: Colors.deepPurple,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Container(
            // alignment: Alignment.centerRight,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(2),
            constraints: BoxConstraints(maxWidth: mq.width * .66),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              // border: Border.all(color: Colors.deepPurple, width: 1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(widget.messages[index]['message'],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ),
        ),
        const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/gallery.png"),
                radius: 15)),
      ],
    );
  }

  Widget botMessage(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/chatbot2.png"),
              radius: 15),
        ),
        Card(
          elevation: 10,
          // color: Colors.blueAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Container(
            // alignment: Alignment.centerLeft,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(2),
            constraints: BoxConstraints(maxWidth: mq.width * .66),
            // constraints: BoxConstraints(maxWidth: mq.width * .66),
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.deepPurple, width: 1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(widget.messages[index]['message'],
                style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ),
        )
      ],
    );
  }
}
