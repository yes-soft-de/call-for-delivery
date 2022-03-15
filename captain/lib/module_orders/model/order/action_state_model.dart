import 'package:c4d/generated/l10n.dart';

class ActionStateModel {
  String? _error;
  ActionStateModel.error(this._error);
  ActionStateModel.empty();
  bool get hasError => _error != null;

  String get error => _error ?? S.current.errorHappened;
}
