import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:debt_tracker_mobile/common/failure.dart';
import 'package:debt_tracker_mobile/data/remote/debt/debt.dart';
import 'package:debt_tracker_mobile/domain/debt/debt.dart';
import 'package:equatable/equatable.dart';

part 'debt_event.dart';
part 'debt_state.dart';

class DebtBloc extends Bloc<DebtEvent, DebtState> {
  final DebtRepository _debtRepository = DebtRepository();

  DebtBloc() : super(DebtInitial()) {
    on<GetDebt>((event, emit) async {
      emit(DebtLoading());

      final result = await _debtRepository.getById(event.id);

      result.fold(
        (l) => emit(DebtFailure(l)),
        (r) => emit(DebtSuccess(r)),
      );
    });

    on<GetDebts>((event, emit) async {
      emit(DebtLoading());

      final result = await _debtRepository.getAll();

      result.fold(
        (l) => emit(DebtFailure(l)),
        (r) => emit(DebtSuccessMultiple(r)),
      );
    });

    on<RequestDebt> (
      (event, emit) async {
        emit(DebtLoading());

        final result = await _debtRepository.request(event.requestDebtForm);

        result.fold(
          (l) => emit(DebtFailure(l)),
          (r) => emit(DebtSuccess(r)),
        );
      });

    on<ApproveDebt>((event, emit) async {
      emit(DebtLoading());

      final result = await _debtRepository.approve(event.id);

      result.fold(
        (l) => emit(DebtFailure(l)),
        (r) => emit(DebtEditSuccess('Debt approved')),
      );
    });

    on<DeclineDebt>((event, emit) async {
      emit(DebtLoading());

      final result = await _debtRepository.decline(event.id);

      result.fold(
        (l) => emit(DebtFailure(l)),
        (r) => emit(DebtEditSuccess('Debt declined')),
      );
    });

    on<ConfirmDebt>((event, emit) async {
      emit(DebtLoading());

      final result = await _debtRepository.confirm(event.id);

      result.fold(
        (l) => emit(DebtFailure(l)),
        (r) => emit(DebtEditSuccess('Payment confirmed')),
      );
    });

    on<DeleteRequest>((event, emit) async {
      emit(DebtLoading());

      final result = await _debtRepository.deleteRequest(event.id);

      result.fold(
        (l) => emit(DebtFailure(l)),
        (r) => emit(DebtEditSuccess('Debt request deleted')),
      );
    });

    on<DeleteApproved>((event, emit) async {
      emit(DebtLoading());

      final result = await _debtRepository.deleteApproved(event.id);

      result.fold(
        (l) => emit(DebtFailure(l)),
        (r) => emit(DebtEditSuccess('Debt deleted')),
      );
    });

    

  }
}
