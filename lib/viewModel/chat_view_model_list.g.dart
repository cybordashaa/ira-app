part of 'chat_view_model_list.dart';

mixin _$ChatListState on ChatListVM, Store {
  final _$messageStatusAtom = Atom(name: 'ChatListVM.messageStatus');

  @override
  MessageStatus get messageStatus {
    _$messageStatusAtom.reportRead();
    return super.messageStatus;
  }

  @override
  set messageStatus(MessageStatus value) {
    _$messageStatusAtom.reportWrite(value, super.messageStatus, () {
      super.messageStatus = value;
    });
  }

  final _$messageListAtom = Atom(name: 'ChatListVM.messageList');

  @override
  ObservableList<ChatViewModel> get messageList {
    _$messageListAtom.reportRead();
    return super.messageList;
  }

  @override
  set messageList(ObservableList<ChatViewModel> value) {
    _$messageListAtom.reportWrite(value, super.messageList, () {
      super.messageList = value;
    });
  }

  final _$fetchMessageAsyncAction = AsyncAction('ChatListVM.fetchMessage');

  @override
  Future<void> fetchMessage() {
    return _$fetchMessageAsyncAction.run(() => super.fetchMessage());
  }

  final _$ChatListVMActionController = ActionController(name: 'ChatListVM');

  @override
  dynamic addMessage(
      {String message, User user, String op, bool file, String file_type}) {
    final _$actionInfo =
        _$ChatListVMActionController.startAction(name: 'ChatListVM.addMessage');
    try {
      return super.addMessage(
          message: message, op: op, file: file, file_type: file_type);
    } finally {
      _$ChatListVMActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messageStatus: ${messageStatus},
messageList: ${messageList}
    ''';
  }
}
