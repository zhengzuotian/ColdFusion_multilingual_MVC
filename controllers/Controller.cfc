component {
	property name="env" type="string";
	property name="datasource" type="string";
	property name="lang" type="string";
    property name="urlRoot" type="string";
	property name="helper" type="component";

	public component function init(required string env, required string datasource, required string lang, required component helper, required component requestController){
		this.env = arguments.env;
		this.datasource = arguments.datasource;
		this.lang = arguments.lang;
        this.urlRoot = replaceNoCase(CGI.SCRIPT_NAME, "index.cfm", "");
		this.helper = arguments.helper;
		this.requestController = arguments.requestController;
		this.dataService = createObject("component", "model.DataService").init(arguments.datasource, arguments.lang, this.helper);
		this.demoService = createObject("component", "model.DemoService").init(arguments.datasource, arguments.lang, this.helper);
		return this;
	}

	public struct function initViewbag() {
		return {
            "error": false
            , "message": ""
            , "pageType": "normal"
            , "urlRoot": this.urlRoot
            , "helper": this.helper
            , "env": this.env
            , "lang": this.lang
            , "admin": structKeyExists(session, "admin") ? session.admin : {}
        };
	}

    public struct function initAjaxViewbag() {
        var viewbag = {}
        viewbag.pageType = "ajax";
        viewbag.dataType = "json";
        viewbag.data = {};
        viewbag.data["error"] = false;
        viewbag.data["message"] = "";

        return viewbag;
    }

	
}
