import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sumit_GPT/model/chat_message_model.dart';
import '../bloc/chat_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ChatBloc chatBloc = ChatBloc();
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {
          
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/bg-image.png",
                      ),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 15, right: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 75,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "SumitGPT",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.image_search,
                                size: 30,
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.transparent,
                            elevation: 11,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: Colors.grey.shade900.withOpacity(0.8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    messages[index].role == "user"
                                        ? "user"
                                        : "SumitGPT",
                                    style: TextStyle(
                                        fontSize: 21,
                                        color: messages[index].role == "user"
                                            ? Colors.amber
                                            : Colors.purple),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    messages[index].parts.first.text,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (chatBloc.generating)
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Lottie.asset("assets/images/loader.json"),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text("Loading. . .")
                        ],
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      height: 80,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                hintText: "Enter Prompt. . . .",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60),
                                    borderSide: BorderSide.none),
                                fillColor: Colors.grey.shade900,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 32,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade900,
                                radius: 31,
                                child: Icon(Icons.send),
                              ),
                            ),
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                String text = textEditingController.text;
                                textEditingController.clear();
                                chatBloc.add(
                                  ChatGenerateNewtextMessageEvent(
                                      inputMessage: text),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
