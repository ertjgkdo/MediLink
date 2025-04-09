import '../../../utils/exporter.dart';

//provider for multi-step signup form
final formStepProvider =
    NotifierProvider<FormStepController, int>(FormStepController.new);
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
final confirmPasswordVisibilityProvider = StateProvider<bool>((ref) => false);

//overall signup form
final signUpFormProvider =
    NotifierProvider<SignUpController, Patient?>(SignUpController.new);
//login form
final loginFormProvider =
    NotifierProvider.autoDispose<LoginController, Patient?>(
        LoginController.new);
final signoutProvider =
    StateNotifierProvider<SignoutController, void>(SignoutController.new);
//address form
final addressProvider = AsyncNotifierProvider<AddressController, AddressModel?>(
    AddressController.new);

//bottom navigation bar selection
final navBarSelectionProvider = StateProvider<int>((ref) => 0);
