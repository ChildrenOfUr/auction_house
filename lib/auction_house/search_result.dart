library search_result;

import 'imports.dart';

class SearchResult
{
	Item item;
	bool isFav = false;
	static Map<String,String> favSaves = null;

	SearchResult(this.item)
	{
		if(favSaves == null)
		{
			if(window.localStorage.containsKey('favSaves'))
				favSaves = JSON.decode(window.localStorage['favSaves']);
			else
				favSaves = {};
		}

		if(favSaves[item.name] == "true")
			isFav = true;
	}

	static changeFav(String itemName, bool isFav)
	{
		favSaves[itemName] = isFav.toString();
		window.localStorage['favSaves'] = JSON.encode(favSaves);
	}
}