part of 'debt_bloc.dart';

abstract class DebtEvent extends Equatable {
  const DebtEvent();

  @override
  List<Object> get props => [];
}

abstract class DebtEventWithId extends DebtEvent {
  final String id;
  const DebtEventWithId(this.id);

  @override
  List<Object> get props => [id];
}

class GetDebts extends DebtEvent {}

class GetDebt extends DebtEventWithId {
  const GetDebt(String id) : super(id);
}

class ApproveDebt extends DebtEventWithId {
  const ApproveDebt(String id): super(id);
}

class DeclineDebt extends DebtEventWithId {
  const DeclineDebt(String id): super(id);
}

class ConfirmDebt extends DebtEventWithId {
  const ConfirmDebt(String id): super(id);
}

class DeleteRequest extends DebtEventWithId {
  const DeleteRequest(String id): super(id);
}

class DeleteApproved extends DebtEventWithId {
  const DeleteApproved(String id): super(id);
}

class RequestDebt extends DebtEvent {
  final RequestDebtForm requestDebtForm;
  const RequestDebt(this.requestDebtForm);

  @override
  List<Object> get props => [requestDebtForm];
}


