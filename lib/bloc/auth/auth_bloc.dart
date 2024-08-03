import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gomemo/api/api_service.dart';
import 'package:gomemo/api/dto/auth/login.dto.dart';
import 'package:gomemo/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository(ApiService());

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLoginRequested);
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
}
