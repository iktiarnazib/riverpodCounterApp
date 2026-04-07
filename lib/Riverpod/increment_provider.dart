import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final incrementProvider = StateProvider<int>((ref) {
  return 1;
});
