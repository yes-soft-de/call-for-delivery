
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';

class CreateListBranchesRequest {
  final List<CreateBranchRequest>? branches;
  final int? storeOwnerProfileId;
  CreateListBranchesRequest( {
    this.branches,
    this.storeOwnerProfileId,
  });
  toJson() {
    var data = [];
    branches?.forEach((element) {
      data.add(element.toJson());
    });
    return {'branches': data,
      'storeOwnerProfileId' : storeOwnerProfileId};
  }
}
