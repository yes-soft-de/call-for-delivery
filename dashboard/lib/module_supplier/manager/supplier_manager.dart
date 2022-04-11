import 'package:c4d/module_supplier/repository/supplier_repository.dart';
import 'package:c4d/module_supplier/request/enable_supplier.dart';
import 'package:c4d/module_supplier/request/update_supplier_request.dart';
import 'package:c4d/module_supplier/response/in_active_supplier_response.dart';
import 'package:c4d/module_supplier/response/supplier_need_support_response/supplier_need_support_response.dart';
import 'package:c4d/module_supplier/response/supplier_profile_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class SuppliersManager {
  final SupplierRepository _repository;

  SuppliersManager(this._repository);

  Future<SupplierResponse?> getSuppliers() => _repository.getSuppliers();

  Future<SupplierResponse?> getInActiveSupplier() =>
      _repository.getInActiveSupplier();

  Future<SupplierProfileResponse?> getSupplierProfile(int id) =>
      _repository.getSupplierProfile(id);

  Future<ActionResponse?> enableSupplier(EnableSupplierRequest request) =>
      _repository.enableSupplier(request);

  Future<ActionResponse?> updateSupplier(UpdateSupplierRequest request) =>
      _repository.updateSupplier(request);

  Future<SupplierNeedSupportResponse?> getSupplierSupport() =>
      _repository.getSupplierSupport();
}
