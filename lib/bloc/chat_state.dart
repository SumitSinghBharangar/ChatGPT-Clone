part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatblocInitial extends ChatState {}

class ChatSuccessState extends ChatState{
  final List<ChatMessageModel> messages;

  ChatSuccessState({required this.messages});
}