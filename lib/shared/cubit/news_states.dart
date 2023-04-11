abstract class NewsStates{}

class NewsInitial extends NewsStates{}

class BottomNavbarChange extends NewsStates{}
class ChangeThemeMode extends NewsStates{}

class BusinessGetDataLoadingState extends NewsStates{}
class BusinessGetDataSuccessState extends NewsStates{}
class BusinessGetDataErrorState extends NewsStates{
  final String error;
  BusinessGetDataErrorState(this.error);
}

class SportsGetDataLoadingState extends NewsStates{}
class SportsGetDataErrorState extends NewsStates{
  final String sportsError;
  SportsGetDataErrorState(this.sportsError);
}
class SportsGetDataSuccessState extends NewsStates{}

class ScienceGetDataErrorState extends NewsStates{
  final String scienceError;
  ScienceGetDataErrorState(this.scienceError);
}
class ScienceGetDataSuccessState extends NewsStates{}
class ScienceGetDataLoadingState extends NewsStates{}

class SearchGetDataLoadingState extends NewsStates{}
class SearchGetDataSuccessState extends NewsStates{}
class SearchGetDataErrorState extends NewsStates{
  final String errorSearch;
  SearchGetDataErrorState(this.errorSearch);
}