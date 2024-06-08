part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ChatGenerateNewtextMessageEvent extends ChatEvent{
  final String inputMessage;

  ChatGenerateNewtextMessageEvent({required this.inputMessage});

    
}
