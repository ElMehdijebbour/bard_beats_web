import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormValidationController extends StateNotifier<bool> {
  FormValidationController() : super(false);

  void validateForm(GlobalKey<FormState> formKey) {
    state = formKey.currentState?.validate() ?? false;
  }
}

final formValidationProvider = StateNotifierProvider.autoDispose<FormValidationController, bool>((ref) {
  return FormValidationController();
});

