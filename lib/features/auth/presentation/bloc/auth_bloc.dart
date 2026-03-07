import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/auth/data/model/register_request_model.dart';
import 'package:lms_student/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.login(event.email, event.password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }


Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
  emit(AuthLoading());
  
  final result = await authRepository.register(event.request);
  
  result.fold(
    (successResponse) {
      if (successResponse.isSuccess) {
        emit(AuthSuccess(data: successResponse));
      } else {
        emit(AuthError(message: successResponse.message));
      }
    },
    (errorMessage) {
      emit(AuthError(message: errorMessage));
    },
  );
}
}
