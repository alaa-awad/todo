abstract class TodoStates {}

class InitialState extends TodoStates {}

//state create DataBase
class CreateDataBaseState extends TodoStates {}

//state get database
class GetDatabaseLoadingState extends TodoStates {}

class GetDatabaseSuccessState extends TodoStates {}

class GetDatabaseErrorState extends TodoStates {
  String error;
  GetDatabaseErrorState(this.error);
}

class InsertDatabaseSuccessState extends TodoStates {}

class InsertDatabaseErrorState extends TodoStates {
  String error;
  InsertDatabaseErrorState(this.error);
}

class UpdateDatabaseState extends TodoStates {}

class DeleteDatabaseState extends TodoStates {}
