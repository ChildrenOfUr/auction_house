library item_browse;

import '../imports.dart';
import 'package:core_elements/core_collapse.dart';

@CustomTag('item-browse')
class ItemBrowse extends PolymerElement {
	@published Map<String, List<Item>> items = toObservable({});

	ItemBrowse.created() : super.created() {
		//generate the item list dynamically from the server in the future
		getItems();
	}

	getItems() async {
		String response = await HttpRequest.getString('$serverAddress/getItems');
		List<Item> itemList = decode(response, type: const TypeHelper<List<Item>>().type);
		itemList.sort((Item a, Item b) => a.name.compareTo(b.name));
		itemList.forEach((Item i) {
			if(items.containsKey(i.category)) {
				items[i.category].add(i);
			}
			else {
				items[i.category] = [i];
			}
		});
	}

	search(Event event, var detail, Element target) async {
		String itemName = target.text;

		new Message('itemDetailRequest', itemName);

		//show auctions
		Map parameters = {'where':"item_name = '$itemName'"};
		List<Auction> auctions = await AuctionSearch.getAuctions(parameters);
		new Message('auctionSearchUpdate', auctions);
	}

	toggleChildren(Event event, var detail, Element target) {
		CoreCollapse children = target.nextElementSibling as CoreCollapse;
		children.toggle();
		target.classes.toggle('collapsed');
		target.classes.toggle('not-collapsed');
	}
}