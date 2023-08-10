import 'dart:convert';

import 'package:linkding/linkding.dart';

class Credential {
	final String host;
	final String token;

  const Credential(this.host, this.token);

	static const none = Credential( 'NONE',  'NONE');
}

class Services {
	final BookmarksService bookmarks;
	final TagsService tags;

  Services({
		required LinkdingClient client,
		required JsonEncoder encoder,
		required JsonDecoder decoder,
	}): bookmarks = BookmarksService(client, encoder, decoder), tags = TagsService(client, encoder, decoder);
}
