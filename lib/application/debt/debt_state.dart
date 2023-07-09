part of 'debt_bloc.dart';

abstract class DebtState extends Equatable {
  const DebtState();
  
  @override
  List<Object> get props => [];
}

class DebtInitial extends DebtState {}

class DebtLoading extends DebtState {}

class DebtSuccess extends DebtState {
  final Debt debt;
  const DebtSuccess(this.debt);

  @override
  List<Object> get props => [debt];
}

class DebtSuccessMultiple extends DebtState {
  final List<Debt> debts;
  const DebtSuccessMultiple(this.debts);

  @override
  List<Object> get props => [debts];
}

class DebtEditSuccess extends DebtState {
  final String message;
  const DebtEditSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class DebtFailure extends DebtState {
  final Failure failure;
  const DebtFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
