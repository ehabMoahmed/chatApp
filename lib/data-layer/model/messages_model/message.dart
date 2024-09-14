class MessageModel{
  final String text;
  final String id;
  MessageModel(this.text,this.id);

  factory MessageModel.fromjson( jsonData)
  {
    return MessageModel(jsonData['message'],jsonData['id']);
  }
}