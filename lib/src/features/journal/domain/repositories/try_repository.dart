import 'package:mood_journal_app/src/features/journal/domain/entities/user.dart';

abstract class UserRepository{

    Future<List<User>> getUsers();

}