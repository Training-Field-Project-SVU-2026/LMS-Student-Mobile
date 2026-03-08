import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/features/auth/domain/repositories/auth_repository.dart';
import 'package:lms_student/features/auth/presentation/bloc/form_controller_mixin.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with FormControllersMixin {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ClearFormEvent>(_onClearForm);
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

    if (!validateForm()) {
      emit(AuthError(message: 'Please fill all fields correctly'));
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      emit(AuthError(message: 'Passwords do not match'));
      return;
    }

    emit(AuthLoading());

    final request = getRegisterRequest();

    final result = await authRepository.register(request);

    result.fold(
      (successResponse) {
        if (successResponse.isSuccess) {
          clearControllers();
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

  void _onClearForm(ClearFormEvent event, Emitter<AuthState> emit) {
    clearControllers();
  }

  @override
  Future<void> close() {
    disposeControllers(); 
    return super.close();
  }

}
