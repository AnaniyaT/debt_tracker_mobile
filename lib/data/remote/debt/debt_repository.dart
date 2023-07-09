import 'package:dartz/dartz.dart';
import 'package:debt_tracker_mobile/common/failure.dart';
import 'package:debt_tracker_mobile/data/remote/debt/debt_api.dart';
import 'package:debt_tracker_mobile/domain/debt/debt.dart';
import 'package:debt_tracker_mobile/domain/debt/debt_repository_interface.dart';
import 'package:debt_tracker_mobile/util/util.dart';

class DebtRepository extends DebtRepositoryInterface {
  final DebtApi _debtApi = DebtApi();

  Future<Either<Failure, Unit>> _patchDebt(String path, String id) async {
    try {
      await _debtApi.patchDebt(path, id);
      return const Right(unit);
    }

    on DHttpException catch(e) {
      return Left(EHandle.handleException(e));
    }

    catch (e) {
      print(e.toString());
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, Unit>> _deleteDebt(String path, String id) async {
    try {
      await _debtApi.deleteDebt(path, id);
      return const Right(unit);
    }

    on DHttpException catch(e) {
      return Left(EHandle.handleException(e));
    }

    catch (e) {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<Debt>>> getAll() async {
    try {
      final List<Debt> debts = await _debtApi.getDebts();
      return Right(debts);
    }

    on DHttpException catch(e) {
      return Left(EHandle.handleException(e));
    }

    catch (e) {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Debt>> getById(String id) async {
    try {
      final Debt debt = await _debtApi.getDebtById(id);
      return Right(debt);
    }

    on DHttpException catch(e) {
      return Left(EHandle.handleException(e));
    }

    catch (e) {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Debt>> request(RequestDebtForm requestDebtForm) async {
    try {
      final Debt debt = await _debtApi.requestDebt(requestDebtForm.toJson());
      return Right(debt);
    }

    on DHttpException catch(e) {
      return Left(EHandle.handleException(e));
    }

    catch (e) {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> approve(String id) async {
    return await _patchDebt('approve/', id);
  }

  @override
  Future<Either<Failure, Unit>> decline(String id) async {
    return await _patchDebt('decline/', id);
  }

  @override
  Future<Either<Failure, Unit>> confirm(String id) async {
    return await _patchDebt('confirm/', id);
  }

  @override
  Future<Either<Failure, Unit>> deleteRequest(String id) async {
    return await _deleteDebt('deleteRequest/', id);
  }

  @override
  Future<Either<Failure, Unit>> deleteApproved(String id) async {
    return await _deleteDebt('deleteApproved/', id);
  }
}