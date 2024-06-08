import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sumit_GPT/model/chat_message_model.dart';
import 'package:sumit_GPT/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewtextMessageEvent>(chatGenerateNewtextMessageEvent);
  }
  List<ChatMessageModel> messages = [];
  bool generating = false;

  FutureOr<void> chatGenerateNewtextMessageEvent(
      ChatGenerateNewtextMessageEvent event, Emitter<ChatState> emit) async {
    messages.add(ChatMessageModel(
        parts: [ChatPartModel(text: event.inputMessage)], role: "user"));
    emit((ChatSuccessState(messages: messages)));
    generating = true;
    String generatedText = await ChatRepo.chatTextGenerationRepo(messages);
    if (generatedText.length > 0) {
      messages.add(ChatMessageModel(
          parts: [ChatPartModel(text: generatedText)], role: "Model"));
      emit((ChatSuccessState(messages: messages)));
    }
    generating = false;
  }
}
