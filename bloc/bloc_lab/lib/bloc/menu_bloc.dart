import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_lab/bloc/menu_event.dart';
import 'package:bloc_lab/bloc/menu_state.dart';
import 'package:bloc_lab/data/menu_repository.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository repository;

  MenuBloc(this.repository) : super(MenuLoading()) {
    on<LoadMenuEvent>(_onLoadMenu);
  }

  Future<void> _onLoadMenu(
    LoadMenuEvent event,
    Emitter<MenuState> emit,
  ) async {
    emit(MenuLoading());

    try {
      final items = await repository.fetchMenu();
      emit(MenuSuccess(items));
    } catch (e) {
      emit(MenuError("Failed to load menu"));
    }
  }
}