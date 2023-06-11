// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:musync/core/common/custom_snackbar.dart';
// import 'package:musync/core/common/formfiled.dart';
// import 'package:musync/config/constants/constants.dart';
// import 'package:musync/config/constants/enums.dart';
// import 'package:musync/config/router/routers.dart';
// import 'package:musync/features/auth/presentation/state/bloc/authentication_bloc.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final ScrollController _scrollController = ScrollController();

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TextEditingController _usernameController =
//       TextEditingController(text: "alexxy");
//   final TextEditingController _emailController =
//       TextEditingController(text: "aayushpandey616@gmail.com");
//   final TextEditingController _passwordController =
//       TextEditingController(text: "VerySecretPassword@100");
//   final TextEditingController _cPasswordController =
//       TextEditingController(text: "VerySecretPassword@100");

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _usernameController.dispose();
//     _cPasswordController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     Size mediaQuerySize = MediaQuery.of(context).size;

//     return BlocListener<AuthenticationBloc, AuthenticationState>(
//       listener: (context, state) {
//         if (state.status == BlocStatus.success) {
//           kShowSnackBar("User Created Successfully", context: context);
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             Routes.loginRoute,
//             (route) => false,
//           );
//         }
//         if (state.status == BlocStatus.error) {
//           kShowSnackBar(state.message!, context: context);
//         }
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
//         appBar: AppBar(
//           elevation: 0,
//           scrolledUnderElevation: 0,
//           toolbarHeight: 100,
//           backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pushNamed(
//                 context,
//                 Routes.getStartedRoute,
//               );
//             },
//             icon: Icon(
//               Icons.arrow_back_rounded,
//               color: isDark ? KColors.whiteColor : KColors.blackColor,
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pushNamedAndRemoveUntil(
//                   context,
//                   Routes.loginRoute,
//                   (route) => false,
//                 );
//               },
//               child: Text(
//                 'Login',
//                 style: GlobalConstants.textStyle(
//                   fontSize: 18,
//                   color: isDark ? KColors.whiteColor : KColors.blackColor,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   physics:
//                       constraints.maxHeight < MediaQuery.of(context).size.height
//                           ? null
//                           : const NeverScrollableScrollPhysics(),
//                   controller: _scrollController,
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: constraints.maxHeight,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         ConstrainedBox(
//                           constraints: BoxConstraints(
//                             maxHeight: 120,
//                             maxWidth: mediaQuerySize.width,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               // SignUp
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 20),
//                                 child: Text(
//                                   'Sign Up',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleLarge!
//                                       .copyWith(
//                                         fontSize: 40,
//                                       ),
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               // SignUp Description
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 20),
//                                 child: Text(
//                                   'Sign up to Musync to get started on all platforms.',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .labelLarge!
//                                       .copyWith(
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Signup Form
//                         Container(
//                           width: mediaQuerySize.width,
//                           height: mediaQuerySize.height * 0.65,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 5,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(40),
//                               topRight: Radius.circular(40),
//                             ),
//                             color: isDark
//                                 ? KColors.whiteColor
//                                 : KColors.blackColor,
//                           ),
//                           child: SignupForm(
//                             formKey: formKey,
//                             usernmaeController: _usernameController,
//                             emailController: _emailController,
//                             passwordController: _passwordController,
//                             cPasswordController: _cPasswordController,
//                             onPressed: () {
//                               context.read<AuthenticationBloc>().add(
//                                     SignupEvent(
//                                       username: _usernameController.text,
//                                       email: _emailController.text,
//                                       password: _passwordController.text,
//                                     ),
//                                   );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Positioned(
//               child: Center(
//                 child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//                   builder: (context, state) {
//                     if (state.status == BlocStatus.loading) {
//                       return const Positioned.fill(
//                         child: CircularProgressIndicator(
//                           backgroundColor: KColors.whiteColor,
//                         ),
//                       );
//                     } else {
//                       return const SizedBox.shrink();
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SignupForm extends StatelessWidget {
//   const SignupForm({
//     super.key,
//     required GlobalKey<FormState> formKey,
//     required TextEditingController usernmaeController,
//     required TextEditingController emailController,
//     required TextEditingController passwordController,
//     required TextEditingController cPasswordController,
//     required VoidCallback onPressed,
//   })  : _formKey = formKey,
//         _usernmaeController = usernmaeController,
//         _emailController = emailController,
//         _passwordController = passwordController,
//         _cPasswordController = cPasswordController,
//         _onPressed = onPressed;

//   final GlobalKey<FormState> _formKey;
//   final TextEditingController _usernmaeController;
//   final TextEditingController _emailController;
//   final TextEditingController _passwordController;
//   final TextEditingController _cPasswordController;
//   final VoidCallback _onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Username
//           CTextFormFiled(
//             controller: _usernmaeController,
//             keyboardType: TextInputType.emailAddress,
//             hintText: 'Username',
//             labelText: 'Username',
//             validator: (p0) {
//               if (p0!.isEmpty) {
//                 return 'USername is required';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           // Email
//           CTextFormFiled(
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             hintText: 'Email',
//             labelText: 'Email',
//             validator: (p0) {
//               if (p0!.isEmpty) {
//                 return 'Email is required';
//               } else if (!RegExp(
//                       r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$')
//                   .hasMatch(p0)) {
//                 return 'Email is invalid';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           //  Password
//           CPasswordFormField(
//             controller: _passwordController,
//             keyboardType: TextInputType.visiblePassword,
//             hintText: 'Password',
//             labelText: 'Password',
//             obscureText: true,
//             validator: (p0) {
//               if (p0!.isEmpty) {
//                 return 'Password is required';
//               } else if (p0.length < 8) {
//                 return 'Password must be at least 8 characters';
//               } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(p0)) {
//                 return 'Password must contain at least one uppercase letter';
//               } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(p0)) {
//                 return 'Password must contain at least one lowercase letter';
//               } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(p0)) {
//                 return 'Password must contain at least one number';
//               } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(p0)) {
//                 return 'Password must contain at least one special character';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           // Confirm Password
//           CPasswordFormField(
//             controller: _cPasswordController,
//             keyboardType: TextInputType.visiblePassword,
//             hintText: 'Confirm Password',
//             labelText: 'Confirm Password',
//             obscureText: true,
//             validator: (p0) {
//               if (p0!.isEmpty) {
//                 return 'Password is required';
//               } else if (p0.length < 8) {
//                 return 'Password must be at least 8 characters';
//               } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(p0)) {
//                 return 'Password must contain at least one uppercase letter';
//               } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(p0)) {
//                 return 'Password must contain at least one lowercase letter';
//               } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(p0)) {
//                 return 'Password must contain at least one number';
//               } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(p0)) {
//                 return 'Password must contain at least one special character';
//               } else if (p0 != _passwordController.text) {
//                 return 'Password does not match';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 40),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: KColors.accentColor,
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 50,
//                 vertical: 15,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               minimumSize: Size(
//                 MediaQuery.of(context).size.width,
//                 50,
//               ),
//             ),
//             onPressed: () {
//               _onPressed();
//             },
//             child: Text(
//               'SIGN UP',
//               style: GlobalConstants.textStyle(
//                 color: KColors.whiteColor,
//                 fontSize: 22,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: Text(
//               "By continuing, you’re agreeing to Musync Privacy policy and Terms of use.",
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.labelLarge!.copyWith(
//                     fontSize: 15,
//                     color: Theme.of(context).brightness == Brightness.dark
//                         ? KColors.blackColor
//                         : KColors.whiteColor,
//                   ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musync/core/common/custom_snackbar.dart';
import 'package:musync/core/common/formfiled.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:musync/config/constants/enums.dart';
import 'package:musync/config/router/routers.dart';
import 'package:musync/features/auth/presentation/state/bloc/authentication_bloc.dart';
import 'package:musync/features/auth/presentation/viewmodel/auth_view_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController =
      TextEditingController(text: "alexxy");
  final TextEditingController _emailController =
      TextEditingController(text: "aayushpandey616@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "VerySecretPassword@100");
  final TextEditingController _cPasswordController =
      TextEditingController(text: "VerySecretPassword@100");

  late AuthViewModel _authViewModel;

  @override
  void initState() {
    super.initState();
    _authViewModel = AuthViewModel(
      authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _usernameController.dispose();
    _cPasswordController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 100,
        backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.getStartedRoute,
            );
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDark ? KColors.whiteColor : KColors.blackColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginRoute,
                (route) => false,
              );
            },
            child: Text(
              'Login',
              style: GlobalConstants.textStyle(
                fontSize: 18,
                color: isDark ? KColors.whiteColor : KColors.blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics:
                    constraints.maxHeight < MediaQuery.of(context).size.height
                        ? null
                        : const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 120,
                          maxWidth: mediaQuerySize.width,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // SignUp
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 40,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // SignUp Description
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Sign up to Musync to get started on all platforms.',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Signup Form
                      Container(
                        width: mediaQuerySize.width,
                        height: mediaQuerySize.height * 0.65,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          color:
                              isDark ? KColors.whiteColor : KColors.blackColor,
                        ),
                        child: SignupForm(
                          formKey: formKey,
                          usernmaeController: _usernameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          cPasswordController: _cPasswordController,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              String username = _usernameController.text;
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              _authViewModel.signupUser(
                                email: email,
                                password: password,
                                username: username,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            child: Center(
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state.status == BlocStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == BlocStatus.error) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      kShowSnackBar(
                        state.message!,
                        context: context,
                      );
                    });
                  } else if (state.status == BlocStatus.success) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      kShowSnackBar(
                        state.message!,
                        context: context,
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.loginRoute,
                        (route) => false,
                      );
                    });
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController usernmaeController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController cPasswordController,
    required VoidCallback onPressed,
  })  : _formKey = formKey,
        _usernmaeController = usernmaeController,
        _emailController = emailController,
        _passwordController = passwordController,
        _cPasswordController = cPasswordController,
        _onPressed = onPressed;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _usernmaeController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _cPasswordController;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Username
          CTextFormFiled(
            controller: _usernmaeController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Username',
            labelText: 'Username',
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'USername is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Email
          CTextFormFiled(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Email',
            labelText: 'Email',
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Email is required';
              } else if (!RegExp(
                      r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$')
                  .hasMatch(p0)) {
                return 'Email is invalid';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          //  Password
          CPasswordFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Password',
            labelText: 'Password',
            obscureText: true,
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Password is required';
              } else if (p0.length < 8) {
                return 'Password must be at least 8 characters';
              } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(p0)) {
                return 'Password must contain at least one uppercase letter';
              } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(p0)) {
                return 'Password must contain at least one lowercase letter';
              } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(p0)) {
                return 'Password must contain at least one number';
              } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(p0)) {
                return 'Password must contain at least one special character';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Confirm Password
          CPasswordFormField(
            controller: _cPasswordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Confirm Password',
            labelText: 'Confirm Password',
            obscureText: true,
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Password is required';
              } else if (p0.length < 8) {
                return 'Password must be at least 8 characters';
              } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(p0)) {
                return 'Password must contain at least one uppercase letter';
              } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(p0)) {
                return 'Password must contain at least one lowercase letter';
              } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(p0)) {
                return 'Password must contain at least one number';
              } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(p0)) {
                return 'Password must contain at least one special character';
              } else if (p0 != _passwordController.text) {
                return 'Password does not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: KColors.accentColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: Size(
                MediaQuery.of(context).size.width,
                50,
              ),
            ),
            onPressed: () {
              _onPressed();
            },
            child: Text(
              'SIGN UP',
              style: GlobalConstants.textStyle(
                color: KColors.whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "By continuing, you’re agreeing to Musync Privacy policy and Terms of use.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 15,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? KColors.blackColor
                        : KColors.whiteColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
