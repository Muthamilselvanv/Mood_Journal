import 'package:mood_journal_app/src/features/journal/domain/entities/user.dart';
import 'package:mood_journal_app/src/features/journal/domain/repositories/try_repository.dart';

class GetUsers{
  final UserRepository repository;

    GetUsers(this.repository);

    Future<List<User>> call(){

        return repository.getUsers();

    } 
}