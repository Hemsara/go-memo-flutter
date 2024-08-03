import 'package:bloc/bloc.dart';
import 'package:gomemo/api/api_service.dart';
import 'package:gomemo/bloc/user/user_event.dart';
import 'package:gomemo/bloc/user/user_state.dart';
import 'package:gomemo/repositories/user/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository = UserRepository(ApiService());

  UserBloc() : super(UserInitial()) {
    on<FetchCurrentUser>(_onFetchCurrentUser);
  }

  Future<void> _onFetchCurrentUser(
      FetchCurrentUser event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final user = await userRepository.getCurrentUser();
      emit(UserLoaded(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
}
