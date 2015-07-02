library item_detail_view;

import '../imports.dart';

@CustomTag('item-detail-view')
class ItemDetailView extends PolymerElement {
	@published Map item = {};

	ItemDetailView.created() : super.created()
	{
		new Service(['itemDetailRequest'], (m) async {
			Map response = JSON.decode(await HttpRequest.getString("$serverAddress/getItemByName?name=${m}"));
			if(response['iconUrl'] != null) {
				item = response;
			} else {
				print('(item_detail_view) bad item! iconUrl was null');
			}
		});
	}
}