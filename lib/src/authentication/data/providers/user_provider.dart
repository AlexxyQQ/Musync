import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musync/src/authentication/data/models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);
