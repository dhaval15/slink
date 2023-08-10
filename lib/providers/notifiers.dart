import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:linkding/linkding.dart';

import 'models.dart';

class CredentialNotifier extends StateNotifier<Credential> {
  CredentialNotifier(): super(Credential.none);

	Future<bool> login(String host, String token) async{
		state = Credential(host, token);
		return true;
	}
	
}

class PaginatedBookmarksNotifier extends StateNotifier<AsyncValue<List<Bookmark>>> {
  PaginatedBookmarksNotifier({
		required this.initial,
		required this.onFetch,
	}):
		super(const AsyncValue.loading());

	final BookmarkFilter initial;
	BookmarkFilter? _filter;

	final List<Bookmark> _bookmarks = [];

	final Future<BookmarksResponse> Function(BookmarkFilter filter) onFetch;

	bool get moreBookmarksAvailable => initial != _filter;

	void init() async{
		try {
			state = const AsyncValue.loading();
			final result = await onFetch(initial);
			print(result);
			_filter = result.next ?? initial;
			_updateData(result.results);
		}
		catch (error, stack) {
			state = AsyncValue.error(error, stack);
		}
	}

	void next() async{
		print('NEXT CALLED');
		if (_filter== null || initial == _filter) {
			throw Exception('No more bookmarks availabe');
		}
		try {
			state = const AsyncValue.loading();
			final result = await onFetch(_filter!);
			_filter = result.next ?? initial;
			_updateData(result.results);
		}
		catch (error, stack) { 
			state = AsyncValue.error(error, stack);
		}
	}

	void _updateData(List<Bookmark> result){
		if(result.isEmpty) {
			state = AsyncValue.data(_bookmarks);
		}
		else {
			state = AsyncValue.data(_bookmarks..addAll(result));
		}
	}

}
