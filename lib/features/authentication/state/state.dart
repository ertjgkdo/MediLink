import 'package:medilink/features/authentication/presentation/controllers/login_controller.dart';

import '../../../utils/exporter.dart';

//provider for multi-step signup form
final formStepProvider =
    NotifierProvider<FormStepController, int>(FormStepController.new);
//overall signup form
final signUpFormProvider =
    NotifierProvider<SignUpController, Patient?>(SignUpController.new);
//login form
final loginFormProvider =
    NotifierProvider<LoginController, Patient?>(LoginController.new);
//address form
final addressProvider = AsyncNotifierProvider<AddressController, AddressModel?>(
    AddressController.new);

//bottom navigation bar selection
final navBarSelectionProvider = StateProvider<int>((ref) => 0);
