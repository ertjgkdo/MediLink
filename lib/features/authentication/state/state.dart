import '../../../utils/exporter.dart';

final formStepProvider =
    NotifierProvider<FormStepController, int>(FormStepController.new);

final signUpFormProvider =
    NotifierProvider.autoDispose<SignUpController, UserModel?>(
        SignUpController.new);
