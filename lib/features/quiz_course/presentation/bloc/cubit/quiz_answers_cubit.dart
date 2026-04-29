import 'package:flutter_bloc/flutter_bloc.dart';

class QuizAnswersCubit extends Cubit<Map<String, List<String>>> {
  QuizAnswersCubit() : super({});

  void toggleAnswer(String questionSlug, String choiceSlug, bool isMultiple) {
    final currentAnswers = Map<String, List<String>>.from(state);
    if (!isMultiple) {
      currentAnswers[questionSlug] = [choiceSlug];
    } else {
      final currentSelected = List<String>.from(currentAnswers[questionSlug] ?? []);
      if (currentSelected.contains(choiceSlug)) {
        currentSelected.remove(choiceSlug);
      } else {
        currentSelected.add(choiceSlug);
      }
      currentAnswers[questionSlug] = currentSelected;
    }
    emit(currentAnswers);
  }
}
