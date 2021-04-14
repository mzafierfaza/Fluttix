import 'package:bwa_motix/bloc/blocs.dart';
import 'package:bwa_motix/bloc/page_bloc.dart';
import 'package:bwa_motix/models/models.dart';
import 'package:bwa_motix/services/services.dart';
import 'package:bwa_motix/shared/shared.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

part 'movie_page.dart';
part 'account_confirmation_page.dart';
part 'preference_page.dart';
part 'sign_in_page.dart';
part 'wrapper.dart';
part 'splash_page.dart';
part 'main_page.dart';
part 'sign_up_page.dart';

Future<File> getImagee() async {
  final picker = ImagePicker();
  var image = await picker.getImage(source: ImageSource.gallery);
  return File(image.path);
}
