import 'package:c4d/generated/l10n.dart';

class UpdateDistanceRequest {
  num storeBranchToClientDistance;
  int id;
  UpdateDistanceRequest(
      {required this.id, required this.storeBranchToClientDistance});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeBranchToClientDistance'] = storeBranchToClientDistance;
    data['id'] = id;
    return data;
  }
}
