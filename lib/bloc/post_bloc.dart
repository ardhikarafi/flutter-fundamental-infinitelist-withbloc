import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list_withbloc/model/model.dart';

//BLOC EVENT
class PostEvent {}
//END

//BLOC STATE
abstract class PostState {}

class PostUninitialized extends PostState {}

class PostLoaded extends PostState {
  List<PostModel> posts;
  bool hasReachedMax;

  PostLoaded({this.posts, this.hasReachedMax});
  PostLoaded copyWith({List<PostModel> posts, bool hasReachedMax}) {
    return PostLoaded(
        posts: posts ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }
}
//END STATE

//REAL BLOC
class PostBloc extends Bloc<PostEvent, PostState> {
  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    List<PostModel> posts;

    if (state is PostUninitialized) {
      posts = await PostModel.konekToAPI(0, 10);
      yield PostLoaded(posts: posts, hasReachedMax: false);
    } else {
      PostLoaded postLoaded = state as PostLoaded;
      posts = await PostModel.konekToAPI(postLoaded.posts.length, 10);
      yield (posts.isEmpty)
          ? postLoaded.copyWith(hasReachedMax: true)
          : PostLoaded(posts: postLoaded.posts + posts, hasReachedMax: false);
    }
  }
}
//END
