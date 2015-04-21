library item_detail_view;

import '../imports.dart';

@CustomTag('item-detail-view')
class ItemDetailView extends PolymerElement
{
	@published Map item = {};

	String serverAddress = "http://robertmcdermot.com:8181";

	ItemDetailView.created() : super.created()
	{
		new Service(['itemDetailRequest'], (Message m) async {
			Map response = JSON.decode(await HttpRequest.getString("$serverAddress/getItemByName?name=${m.content}"));
			if(response['iconUrl'] != null)
			{
				item = response;
			}
		});
	}
}