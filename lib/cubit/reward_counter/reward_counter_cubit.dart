import 'package:bloc/bloc.dart';

class RewardCounterCubit extends Cubit<int> {
  RewardCounterCubit() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);
}
