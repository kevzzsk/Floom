import 'package:meta/meta.dart';

@immutable
abstract class CartState {}
  
class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState{}