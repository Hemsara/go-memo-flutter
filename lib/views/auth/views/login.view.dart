import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomemo/api/dto/auth/login.dto.dart';
import 'package:gomemo/bloc/auth/auth_bloc.dart';
import 'package:gomemo/global/textfield.dart';
import 'package:gomemo/res/colors.dart';
import 'package:gomemo/res/dimens.dart';
import 'package:gomemo/res/toast.dart';
import 'package:gomemo/services/navigator.dart';
import 'package:gomemo/views/base.dart';
import 'package:iconsax/iconsax.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.defaultMargin),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.calendar5,
                color: AppColors.primary,
                size: 50,
              ),
              const Center(
                child: Text(
                  "GOMEMO",
                  style: TextStyle(
                      fontSize: 58,
                      color: Color(0xff7FFA88),
                      fontWeight: FontWeight.w500),
                ),
              ),
              AppDimensions.space(2),
              InputField(
                hint: "Enter email",
                controller: emailController,
              ),
              InputField(
                showPasswordValidations: false,
                textFieldType: TextFieldType.password,
                controller: passwordController,
                hint: "Enter password",
              ),
              AppDimensions.space(4),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    ToastManager.showSuccessToast('Login successful');
                    NavigatorHelper.replaceAll(Base());
                  } else if (state is AuthFailure) {
                    ToastManager.showErrorToast('Login Failed: ${state.error}');
                  }
                },
                builder: (context, state) {
                  return Button(
                    onTap: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      final email = emailController.text;
                      final password = passwordController.text;

                      final loginDTO =
                          LoginDTO(email: email, password: password);

                      context.read<AuthBloc>().add(LoginEvent(loginDTO));
                    },
                    isLoading: state is AuthLoading,
                    text: 'Login',
                  );
                },
              ),
              AppDimensions.space(1),
              Button(
                primary: false,
                onTap: () {},
                text: 'New to GOMEMO',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final VoidCallback onTap;

  final bool primary;
  final bool isLoading;

  final String text;
  final double borderRadius;

  const Button({
    Key? key,
    required this.onTap,
    required this.text,
    this.primary = true,
    this.borderRadius = 8.0,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: primary ? AppColors.primary : Colors.transparent,
          border: primary ? null : Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: isLoading
              ? CupertinoActivityIndicator()
              : Text(
                  text,
                  style: TextStyle(
                    color: primary ? Colors.black : AppColors.primary,
                    fontSize: 26.0,
                  ),
                ),
        ),
      ),
    );
  }
}
