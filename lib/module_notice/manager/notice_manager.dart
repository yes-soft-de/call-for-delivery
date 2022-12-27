import 'package:c4d/module_notice/repository/notice_repository.dart';
import 'package:c4d/module_notice/request/notice_request.dart';
import 'package:c4d/module_notice/response/notice_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class NoticeManager {
  final NoticeRepository _categoriesRepository;

  NoticeManager(this._categoriesRepository);

  Future<NoticeResponse?> getNotice() => _categoriesRepository.getNotice();

  Future<ActionResponse?> addNotice(NoticeRequest request) =>
      _categoriesRepository.addNotice(request);

  Future<ActionResponse?> updateNotice(NoticeRequest request) =>
      _categoriesRepository.updateNotice(request);
}
