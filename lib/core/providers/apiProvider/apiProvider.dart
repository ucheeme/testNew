import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../service/apiService.dart';


final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});
