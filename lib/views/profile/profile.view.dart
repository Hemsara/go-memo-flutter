import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gomemo/bloc/auth/auth_bloc.dart';
import 'package:gomemo/bloc/user/user_bloc.dart';
import 'package:gomemo/bloc/user/user_state.dart';
import 'package:gomemo/res/dimens.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: AppDimensions.defaultMargin,
          left: AppDimensions.defaultMargin,
          right: AppDimensions.defaultMargin,
        ),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.user;
              return ListView(
                children: [
                  const Text(
                    "Hello!",
                    style: TextStyle(fontSize: 40),
                  ),
                  AppDimensions.space(2),
                  ProfileInfo(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("E-mail address"),
                        Text(
                          user.email,
                          style:
                              const TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  GoogleAccessComponent(
                    isGoogleAuthenticated: user.isGoogleAuthenticated,
                  )
                ],
              );
            } else if (state is UserError) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const Center(child: Text('Initializing...'));
          },
        ),
      ),
    );
  }
}

class GoogleAccessComponent extends StatelessWidget {
  final bool isGoogleAuthenticated;

  const GoogleAccessComponent({super.key, required this.isGoogleAuthenticated});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(const GrantGoogleAccessEvent());
          },
          child: ProfileInfo(
            child: (state is GoogleAccessLoading)
                ? const CupertinoActivityIndicator(
                    color: Colors.white,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Google Calendar"),
                      const Gap(5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: isGoogleAuthenticated
                                ? Colors.green
                                : Colors.redAccent,
                            radius: 5,
                          ),
                          const Gap(5),
                          Text(
                            isGoogleAuthenticated ? "Linked" : "Not Linked",
                            style: TextStyle(
                                color: isGoogleAuthenticated
                                    ? Colors.green
                                    : Colors.redAccent,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const Gap(5),
                      SizedBox(
                        child: state is GoogleAccessError
                            ? Text(state.error)
                            : null,
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final Widget child;

  const ProfileInfo({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      margin: EdgeInsets.symmetric(vertical: AppDimensions.defaultMargin / 2),
      padding: EdgeInsets.all(AppDimensions.defaultMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withOpacity(0.1),
      ),
    );
  }
}
