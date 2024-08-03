import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gomemo/api/api_service.dart';
import 'package:gomemo/api/dto/auth/login.dto.dart';
import 'package:gomemo/repositories/auth/auth_repository.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for launching URL

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository(ApiService());

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLoginRequested);
    on<GrantGoogleAccessEvent>(_onGrantGoogleAccessRequested);
  }

  Future<void> _onLoginRequested(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final tokenResponse = await authRepository.loginUser(event.loginDTO);
      await tokenResponse.saveTokens();
      emit(const AuthSuccess());
    } catch (err) {
      emit(AuthFailure(err.toString()));
    }
  }

  Future<void> _onGrantGoogleAccessRequested(
    GrantGoogleAccessEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const GoogleAccessLoading());
    try {
      final googleAccessUri = await authRepository.grantGoogleAccess();
      emit(GoogleAccessSent(googleAccessUri));

      if (await canLaunchUrl(googleAccessUri)) {
        bool success = await launchUrl(googleAccessUri);
        if (!success) {
          emit(const GoogleAccessError("Failed to grant access"));
        } else {
          emit(const GoogleAccessGranted());
        }
      } else {
        emit(const GoogleAccessError('Could not launch URL'));
      }
    } catch (err) {
      emit(GoogleAccessError(err.toString()));
    }
  }
}
