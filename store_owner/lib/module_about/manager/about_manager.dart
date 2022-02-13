import 'package:c4d/module_about/repository/about_repository.dart';
import 'package:c4d/module_about/request/create_appointment_request.dart';
import 'package:injectable/injectable.dart';

@injectable
class AboutManager {
  final AboutRepository _aboutRepository;
  AboutManager(this._aboutRepository);
  dynamic createAppointment(CreateAppointmentRequest request) => _aboutRepository.createAboutAppointment(request);
}