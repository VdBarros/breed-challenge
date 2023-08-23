import 'package:dartz/dartz.dart';
import 'package:breed_challenge/core/erros/failures.dart';

abstract class Usecase<Output, Input> {
  Future<Either<Failure, Output>> call(Input param);
}

abstract class UsecaseNoParams<Output> {
  Future<Either<Failure, Output>> call();
}
