import 'package:equatable/equatable.dart';
import '../data/menu_repository.dart';

abstract class MenuState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MenuLoading extends MenuState {}

class MenuSuccess extends MenuState {
  final List<MenuItem> items;

  MenuSuccess(this.items);

  @override
  List<Object?> get props => [items];
}

class MenuError extends MenuState {
  final String message;

  MenuError(this.message);

  @override
  List<Object?> get props => [message];
}