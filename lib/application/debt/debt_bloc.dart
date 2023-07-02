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

  }
}
