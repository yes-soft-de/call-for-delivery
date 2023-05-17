// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';

import '../response/notice_response.dart';

class NoticeModel extends DataModel {
  String? msg = '';
  String? title = '';
  String? appType = '';
  List<NoticeImage>? images;

  int id = -1;

  List<NoticeModel> _model = [];

  NoticeModel({
    required this.title,
    required this.id,
    required this.msg,
    required this.appType,
    required this.images,
  });

  NoticeModel.withData(List<Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(
        NoticeModel(
          id: element.id ?? -1,
          title: element.title,
          appType: element.appType,
          msg: element.msg,
          images: _getImages(element.images),
        ),
      );
    }
  }
  List<NoticeModel> get data => _model;
}

class NoticeImage {
  int? id;
  String image;
  bool isRemote;
  bool toDelete;
  bool uploadError;

  NoticeImage({
    this.id = 0,
    required this.image,
    this.isRemote = false,
    this.toDelete = false,
    this.uploadError = false,
  });

  NoticeImage copyWith({
    int? id,
    String? image,
    bool? isRemote,
    bool? toDelete,
    bool? uploadError,
  }) {
    return NoticeImage(
      id: id ?? this.id,
      image: image ?? this.image,
      isRemote: isRemote ?? this.isRemote,
      toDelete: toDelete ?? this.toDelete,
      uploadError: uploadError ?? this.uploadError,
    );
  }
}

List<NoticeImage> _getImages(List<ImageResponse>? images) {
  List<NoticeImage> list = [];

  images?.forEach(
    (element) {
      list.add(NoticeImage(
        id: element.id ?? 0,
        image: element.image ?? '',
        isRemote: true,
      ));
    },
  );

  return list;
}
