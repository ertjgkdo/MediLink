import 'package:flutter_secure_storage/flutter_secure_storage.dart';

export 'package:flutter/material.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:equatable/equatable.dart';
export 'dart:convert';
export 'package:flutter/services.dart';
export 'package:http/http.dart';

// exporting common  ui components
export 'package:medilink/components/forms.dart';
export 'package:medilink/components/bottom_navigation_bar.dart';
export 'package:medilink/components/topbar.dart';
export 'package:medilink/features/search/presentation/widgets/search_bar.dart';
export 'package:medilink/components/back_button.dart';
export 'package:medilink/components/topbar_extended.dart';

//exporting home page
export 'package:medilink/home_screen/home.dart';

//exporting authentication pages
export 'package:medilink/features/authentication/presentation/screens/sign_up.dart';
export 'package:medilink/features/authentication/presentation/screens/log_in.dart';
export 'package:medilink/features/authentication/presentation/widgets/general_info_form.dart';
export 'package:medilink/features/authentication/presentation/widgets/address_form.dart';
export 'package:medilink/features/authentication/presentation/widgets/password_form.dart';
export 'package:medilink/features/authentication/state/state.dart';

//exporting hospital directory pages
export 'package:medilink/features/hospital_directory/presentation/screens/explore.dart';
export 'package:medilink/features/hospital_directory/presentation/screens/hospital_detail.dart';
export 'package:medilink/features/hospital_directory/presentation/screens/department_detail.dart';
export 'package:medilink/features/hospital_directory/presentation/screens/doctor_detail.dart';

//exporting models
export 'package:medilink/features/authentication/domain/patient_model.dart';
export 'package:medilink/features/authentication/domain/address_model.dart';
export 'package:medilink/features/hospital_directory/domain/department_model.dart';
export 'package:medilink/features/hospital_directory/domain/hospital_model.dart';
export 'package:medilink/features/hospital_directory/domain/doctor_model.dart';
export 'package:medilink/features/hospital_directory/domain/schedule_model.dart';
export 'package:medilink/features/hospital_directory/domain/appointment_slots_model.dart';

//exporting states
export 'package:medilink/features/hospital_directory/state/state.dart';

//exporting controllers
export 'package:medilink/features/hospital_directory/presentation/controllers/all_object_controller.dart';

export 'package:medilink/features/authentication/presentation/controllers/form_step_controller.dart';
export 'package:medilink/features/authentication/presentation/controllers/sign_up_controller.dart';
export 'package:medilink/features/authentication/presentation/controllers/address_controller.dart';
// export 'package:medilink/features/hospital_directory/presentation/controllers/hospital_controller.dart';

//exporting base repository
export 'package:medilink/utils/repository.dart';

//exporting repositories
export 'package:medilink/features/authentication/data/auth_repository.dart';
export 'package:medilink/features/hospital_directory/data/hospital_repo.dart';
export 'package:medilink/features/hospital_directory/data/department_repo.dart';
export 'package:medilink/features/hospital_directory/data/doctor_repo.dart';
export 'package:medilink/features/hospital_directory/data/schedule_repo.dart';
export 'package:medilink/features/hospital_directory/data/slots_repo.dart';

//flutter secure storage
const storage = FlutterSecureStorage(wOptions: WindowsOptions.defaultOptions);
