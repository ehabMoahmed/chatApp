class MessageModel{
  final String text;
  MessageModel(this.text);

  factory MessageModel.fromjson( jsonData)
  {
    return MessageModel(jsonData['message']);
  }
}