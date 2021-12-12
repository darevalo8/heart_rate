import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<int> {
  NavbarCubit() : super(0);

  void changePosition(int index) => emit(index);
}
