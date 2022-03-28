import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';

class CreateListBranchesRequest {
  final List<CreateBranchRequest>? branches;
  CreateListBranchesRequest({
    this.branches,
  });
  toJson() {
    var data = [];
    branches?.forEach((element) {
      data.add(element.toJson());
    });
    return {'branches': data};
  }
}
