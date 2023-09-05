import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_chat_v2/model/chat/chat_model.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_chat_v2/presistance/chat_hive_helper.dart';
import 'package:c4d/module_chat_v2/state_manager/chat_state_manager.dart';
import 'package:c4d/module_chat_v2/ui/widget/image_dialog_picker.dart';
import 'package:c4d/module_chat_v2/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

@injectable
class Chat2Page extends StatefulWidget {
  final Chat2StateManager _chatStateManager;
  final ImageUploadService _uploadService;
  final AuthService _authService;
  final ChatHiveHelper _chatHiveHelper;

  Chat2Page(this._chatStateManager, this._uploadService, this._authService,
      this._chatHiveHelper);

  @override
  State<StatefulWidget> createState() => Chat2PageState();
}

class Chat2PageState extends State<Chat2Page> with WidgetsBindingObserver {
  final List<types.Message> _messages = [];
  late types.User _user;
  late String chatRoomId;
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    _user = types.User(id: widget._authService.username);
    _newMessageEvents();
    super.initState();
  }

  void _newMessageEvents() {
    streamSubscription =
        widget._chatStateManager.chatBlocStream.listen((event) {
      if (event.isNotEmpty) {
        _addNonExistingOnesToList(event);
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  late ChatArgument args;
  bool sendSupport = false;
  bool requestDataAfterGettingRoomIDArguments = true;

  @override
  Widget build(BuildContext context) {
    if (requestDataAfterGettingRoomIDArguments) {
      args = ModalRoute.of(context)?.settings.arguments as ChatArgument;
      chatRoomId = args.roomID;
      sendSupport = args.support;
      widget._chatStateManager.getMessages(chatRoomId);
      requestDataAfterGettingRoomIDArguments = false;
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
          appBar: CustomC4dAppBar.appBar(context,
              title: args.name ?? S.current.chatRoom),
          body: Chat(
            onAttachmentPressed: () {
              showImageDialogPicker(context,
                  onGallery: () => _pickImageFromGallery(),
                  onCamera: () => _pickImageFromCamera());
            },
            isAttachmentUploading: uploadingImage,
            bubbleRtlAlignment:
                Localizations.localeOf(context).languageCode == 'ar'
                    ? BubbleRtlAlignment.left
                    : BubbleRtlAlignment.right,
            emptyState: Visibility(
              visible: widget._chatStateManager.tryToGettingMessages,
              replacement: SizedBox(
                height: 500,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flushbar(
                      padding: const EdgeInsets.all(16.0),
                      borderRadius: BorderRadius.circular(10),
                      icon: const Icon(
                        Icons.message_rounded,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      title: S.current.note,
                      message: S.current.firstSendMessage,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Center(
                  child: Lottie.asset('assets/animations/empty_state.json')),
            ),
            messages: _messages,
            showUserNames: true,
            onSendPressed: _handleMessageSendPressed,
            showUserAvatars: true,
            user: _user,
            dateLocale: 'en',
            dateHeaderBuilder: (dateHeader) {
              var formattedDate =
                  DateFormat('yyyy MMM d', 'en').format(dateHeader.dateTime);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                    width: double.maxFinite,
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Spacer(),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  isDateToday(formattedDate, 'yyyy MMM d')
                                      ? S.current.today
                                      : formattedDate,
                                  style: TextStyle(
                                      color: Theme.of(context).disabledColor),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    )),
              );
            },
            theme: DefaultChatTheme(
                inputBackgroundColor: Theme.of(context).colorScheme.primary,
                primaryColor: Theme.of(context).colorScheme.primary),
          )),
    );
  }

  void _handleMessageSendPressed(types.PartialText message) {
    int milli = DateTime.now().millisecondsSinceEpoch;
    String uuid = const Uuid().v1();
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: milli,
      id: uuid,
      text: message.text,
    );
    //_addMessage(textMessage);
    widget._chatStateManager.sendMessage(chatRoomId, message.text,
        widget._authService.username, milli, args, uuid, 1);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _addNonExistingOnesToList(List<ChatModel> newChats) {
    newChats.sort((c, c1) {
      return DateTime.fromMillisecondsSinceEpoch(
              c.sentDate ?? DateTime.now().millisecondsSinceEpoch)
          .compareTo(DateTime.fromMillisecondsSinceEpoch(
              c1.sentDate ?? DateTime.now().millisecondsSinceEpoch));
    });
    int index = _messages.length - 1;
    if (index < 0) index = 0;
    for (int i = index; i < newChats.length; i++) {
      if (chatExist(newChats[i])) {
        continue;
      }
      if ((newChats[i].messageType == 1 || newChats[i].messageType == null) &&
          newChats[i].msg?.contains(Urls.IMAGES_ROOT) == false) {
        _messages.insert(
            0,
            types.TextMessage(
              createdAt: newChats[i].sentDate,
              text: newChats[i].msg ?? '',
              id: newChats[i].id ??
                  newChats[i].sentDate?.toString() ??
                  const Uuid().v1(),
              type: types.MessageType.text,
              author: types.User(
                id: newChats[i].sender ?? S.current.unknown,
                firstName: newChats[i].senderName ??
                    newChats[i].sender ??
                    S.current.unknown,
              ),
            ));
      } else if (newChats[i].messageType == 2 ||
          newChats[i].msg?.contains(Urls.IMAGES_ROOT) == true) {
        _messages.insert(
            0,
            types.ImageMessage(
              createdAt: newChats[i].sentDate,
              name: newChats[i].msg?.split('/').last ?? S.current.unknown,
              size: 1024,
              uri: newChats[i].msg?.contains(Urls.IMAGES_ROOT) == true
                  ? newChats[i].msg!
                  : Urls.IMAGES_ROOT + (newChats[i].msg ?? ''),
              id: newChats[i].id ??
                  newChats[i].sentDate?.toString() ??
                  const Uuid().v1(),
              type: types.MessageType.image,
              author: types.User(
                id: newChats[i].sender ?? S.current.unknown,
                firstName: newChats[i].senderName ??
                    newChats[i].sender ??
                    S.current.unknown,
              ),
            ));
      } else {
        _messages.insert(
            0,
            types.TextMessage(
              createdAt: newChats[i].sentDate,
              text: newChats[i].msg ?? '',
              id: newChats[i].id ??
                  newChats[i].sentDate?.toString() ??
                  const Uuid().v1(),
              type: types.MessageType.text,
              author: types.User(
                id: newChats[i].sender ?? S.current.unknown,
                firstName:newChats[i].senderName ?? newChats[i].sender ?? S.current.unknown,
              ),
            ));
      }
    }
  }

  bool chatExist(ChatModel chatModel) {
    for (var message in _messages) {
      if (message.id == chatModel.sentDate.toString() ||
          message.id == chatModel.id) {
        return true;
      }
    }
    return false;
  }

  bool uploadingImage = false;

  Future<void> _pickImageFromGallery() async {
    Navigator.of(context).pop();
    var value = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    uploadingImage = true;
    setState(() {});
    var url = await getIt<ImageUploadService>().uploadImage(value?.path);
    uploadingImage = false;
    setState(() {});
    _handleOnImageMessageSend(url ?? '');
  }

  Future<void> _pickImageFromCamera() async {
    Navigator.of(context).pop();
    var value = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    uploadingImage = true;
    setState(() {});
    var url = await getIt<ImageUploadService>().uploadImage(value?.path);
    uploadingImage = false;
    setState(() {});
    _handleOnImageMessageSend(url ?? '');
  }

  void _handleOnImageMessageSend(String uri) {
    int milli = DateTime.now().millisecondsSinceEpoch;
    String uuid = const Uuid().v1();
    final imageMessage = types.ImageMessage(
      author: _user,
      createdAt: milli,
      id: uuid,
      uri: uri,
      size: 1024,
      name: Urls.IMAGES_ROOT + uri.split('/').last,
    );
    //_addMessage(imageMessage);
    widget._chatStateManager.sendMessage(
        chatRoomId, uri, widget._authService.username, milli, args, uuid, 2);
  }
}
