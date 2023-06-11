// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/response/feature_response/feature_response/feature_response.dart';

class FeatureModel extends DataModel {
  late int id;
  late String featureName;
  late bool featureStatus;

  late FeatureModel _featureModel;
  FeatureModel get data => _featureModel;

  FeatureModel({
    required this.id,
    required this.featureName,
    required this.featureStatus,
  });

  FeatureModel.withData(FeatureResponse response) {
    var data = response.data;

    _featureModel = FeatureModel(
      id: data?.id ?? -1,
      featureName: data?.featureName ?? S.current.unknown,
      featureStatus: data?.featureStatus ?? false,
    );
  }
}
