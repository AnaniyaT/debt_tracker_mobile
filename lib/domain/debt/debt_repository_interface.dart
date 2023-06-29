import 'package:dartz/dartz.dart';
import 'package:debt_tracker_mobile/common/failure.dart';
import 'debt.dart';

abstract class DebtRepositoryInterface {
  Future<Either<Failure, Debt>> request(RequestDebtForm requestDebtForm);
  Future<Either<Failure, Unit>> approve(String id);
  Future<Either<Failure, Unit>> decline(String id);
  Future<Either<Failure, Unit>> confirm(String id);
  Future<Either<Failure, Unit>> deleteRequest(String id);
  Future<Either<Failure, Unit>> deleteApproved(String id);
}