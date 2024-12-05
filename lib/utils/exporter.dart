export 'package:flutter/material.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart';

// exporting common form ui components
export 'package:medilink/components/forms.dart';

//exporting authentication pages
export 'package:medilink/features/authentication/presentation/screens/sign_up.dart';
export 'package:medilink/features/authentication/presentation/screens/log_in.dart';
export 'package:medilink/features/authentication/presentation/widgets/general_info_form.dart';
export 'package:medilink/features/authentication/presentation/widgets/address_form.dart';
export 'package:medilink/features/authentication/presentation/widgets/password_form.dart';
export 'package:medilink/features/authentication/state/state.dart';

//exporting models
export 'package:medilink/features/authentication/domain/user_model.dart';

//exporting controllers
export 'package:medilink/features/authentication/presentation/controllers/form_step_controller.dart';
export 'package:medilink/features/authentication/presentation/controllers/sign_up_controller.dart';
