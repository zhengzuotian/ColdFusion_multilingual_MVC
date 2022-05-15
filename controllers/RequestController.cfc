component {
	property name="lang" type="string";
	property name="routeMap" type="struct";
	property name="urlMap" type="struct";

	public component function init(){
		 // home page
		this.routeMap = {
			"/en/" : "Default/home",
			"/fr/" : "Default/home",
			"/es/" : "Default/home"
		}
		this.urlMap = {
			"en": {
				"Default/home" : "/en/"
			},
			"fr": {
				"Default/home" : "/fr/"
			},
			"es": {
				"Default/home" : "/es/"
			}
		}

		var rs = routeSettings();
		
		for (lang in rs) {
			for (key in rs[lang]) {
				var urlStr = "/" & lang & key;
				var ctrlActStr = rs[lang][key];
				// route map for other pages
				this.routeMap[urlStr] = ctrlActStr;
				// url map, opposite to route map with struct slightly different
				this.urlMap[lang][ctrlActStr] = urlStr;
			}
		}
		return this;
	}

	private struct function routeSettings() {
		// Format in route map: "path/to/page": "module_name/action_name"
		return {
			"en": {
				"/demo/example": "demo/example",
				"/demo/paging/example": "demo/pagingExample",
				"/demo/queries/example": "demo/queriesExample",
				"/demo/longer/url/exemple": "demo/anySpecificName",
				"/demo/exampleAjax": "demo/exampleAjax"
			},
			"fr": {
				"/demo/exemple": "demo/example",
				"/demo/pagination/exemple": "demo/pagingExample",
				"/demo/requetes/exemple": "demo/queriesExample",
				"/demo/plus/url/exemple": "demo/anySpecificName",
				"/demo/exempleAjax": "demo/exampleAjax"
			},
			"es": {
				"/demostracion/ejemplo": "demo/example",
				"/demostracion/paginacion/ejemplo": "demo/pagingExample",
				"/demostracion/consultas/ejemplo": "demo/queriesExample",
				"/demo/plus/url/ejemplo": "demo/anySpecificName",
				"/demo/ejemploAjax": "demo/exampleAjax"
			}
		}
	}

	private string function getRoute() {
		var key = CGI.PATH_INFO;
		if (key == "") {
			key = "/";
		}
		return structKeyExists(this.routeMap, key) ? this.routeMap[key] : "Default/p404";
	}

	public string function getModule() {
		var route = getRoute();
		return listFirst(route, "/");
	}

	public string function getAction() {
		var route = getRoute();
		return listLast(route, "/");
	}

	// web.config should redirect "/" to "/en/" or "/fr/"
	public string function getLang() {
		var pathInfo = CGI.PATH_INFO;
		if (len(pathInfo) < 3) {
			this.lang = "";
		}
		var langInUrl = mid(pathInfo, 2, 2);
		if (arrayContains(application.mvc.config.supportLangs, langInUrl)) {
			this.lang = langInUrl;
		} else {
			this.lang = "";
		}

		return this.lang;
	}

	public string function linkTo(module, action, lang="") {
		var myLang = arguments.lang;
		if (myLang == "") {
			myLang = this.lang;
		}
		var ctrlActStr = module & "/" & action;
		return structKeyExists(this.urlMap[myLang], ctrlActStr) ? this.urlMap[myLang][ctrlActStr] : "";
	}
	
}
