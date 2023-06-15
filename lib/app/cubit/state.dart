abstract class AppStates {}

class AppInitialState extends AppStates {}

class AddNotesSuccess extends AppStates {}

class AddFileError extends AppStates {
    final String message;

  AddFileError(this.message);
}
class AddNotesError extends AppStates {
    final String message;

  AddNotesError(this.message);
}
class LoadingTrue extends AppStates {}
class LoadingFalse extends AppStates {}

class SuccessLogin extends AppStates {}
class SuccessSignUp extends AppStates {}

