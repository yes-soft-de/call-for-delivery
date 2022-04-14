import 'package:c4d/module_about/repository/about_repository.dart';
import 'package:c4d/module_about/request/create_appointment_request.dart';
import 'package:injectable/injectable.dart';

import '../response/company_info_response/company_info_response.dart';

@injectable
class AboutManager {
  final AboutRepository _aboutRepository;
  AboutManager(this._aboutRepository);

  Future<CompanyInfoResponse?> getCompanyInfo() => _aboutRepository.getCompanyInfo();

}
