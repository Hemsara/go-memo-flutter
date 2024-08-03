part of 'calendar_bloc.dart';

sealed class CalendarState extends Equatable {
  const CalendarState();
}

final class CalendarInitial extends CalendarState {
  @override
  List<Object> get props => [];
}
