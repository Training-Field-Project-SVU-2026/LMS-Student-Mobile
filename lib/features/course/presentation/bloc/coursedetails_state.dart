part of 'coursedetails_bloc.dart';

sealed class CoursedetailsState extends Equatable {
  const CoursedetailsState();
  
  @override
  List<Object> get props => [];
}

final class CoursedetailsInitial extends CoursedetailsState {}
