import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';

import '../../injection/app_injection_container.dart';

class BlocProvidersList {
  static final blocList = [
    BlocProvider<AuthenticationCubit>(create: (context) => get()),
    BlocProvider<QueryCubit>(create: (context) => get()),
  ];
}
