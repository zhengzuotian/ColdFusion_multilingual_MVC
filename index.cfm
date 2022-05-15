<cfscript>
	// cache the mvc objects in application scope, except dev environment or manually clean cache
	if (not structKeyExists(application, "mvc") or (structKeyExists(application, "mvc") && application.mvc.config.env eq "dev") or structKeyExists(url, "cleancache")) {
		application.mvc = {
			"controllers": {},
			"locale": {},
			"config": {}
		}
	}

	// read config
	if (structIsEmpty(application.mvc.config)) {
		include "config/env.cfm";
		application.mvc.config = appconfig;
	}

	// request controller
	if (! structKeyExists(application.mvc.controllers, "requestController")) {
		application.mvc.controllers["requestController"] = createObject("component", "controllers.RequestController").init();
	}
	requestController = application.mvc.controllers["requestController"];
	rc = requestController; // alias

	// module, action, lang
	activeModule = requestController.getModule();
	activeAction = requestController.getAction();
	// Remember to set a rule in web.config to redirect home page to default language page, so that we know always active lang
	activeLang = requestController.getLang();

	// helper
	if (! structKeyExists(application.mvc.controllers, "helper")) {
		application.mvc.controllers["helper"] = createObject("component", "utils.helper").init(activeLang);
	}
	helper = application.mvc.controllers["helper"];
	h = helper; // alias

	// home page
	if (activeLang == "" || activeModule == "" || activeAction == "") {
		activeModule = "default";
		activeAction = "home";
	}

	// 404 page
	activeControllerPath = "./controllers/#activeModule#Controller.cfc";
	if (not fileExists(expandPath(activeControllerPath))) {
		activeModule = "default";
		activeAction = "p404";
	}

	// load locale data
	if (structIsEmpty(application.mvc.locale)) {
		application.mvc.locale = helper.getLocaleData();
	}

	// get active controller
	if (not structKeyExists(application.mvc.controllers, "#activeModule#Controller")) {
		application.mvc.controllers["#activeModule#Controller"] = createObject("component", "controllers.#activeModule#Controller").init(application.mvc.config.env, application.mvc.config.dsn, activeLang, helper, requestController);
	}
	activeController = application.mvc.controllers["#activeModule#Controller"];

	// Unknown action: redirect to 404 page
	if (not structKeyExists(activeController, "#activeAction#Action")) {
		activeModule = "default";
		activeAction = "p404";
	}
</cfscript>

<!--- call the active method to process the request and return response data in viewbag --->
<cfinvoke  
    component="#activeController#"  
    method="#activeAction#Action"
    returnVariable="viewbag"> 

<cfscript>
	if (isStruct(viewbag)) {
		viewbag.module = activeModule;
		viewbag.env = application.mvc.config.env;
		viewbag.db = application.mvc.config.dsn;
	}

	// debug die dump
	if (structKeyExists(url, "dump")) {
		writeDump(viewbag);
		abort;
	}
</cfscript>

<!--- renderer the page --->
<cfset pageType = isDefined("viewbag.pageType") ? viewbag.pageType : "normal">
<cfif structKeyExists(url,"ajax") or structKeyExists(form,"ajax")>
	<cfset pageType = "ajax">
</cfif>

<cfswitch expression="#pageType#">
	<cfcase value="normal">
		<cfset page = isDefined("viewbag.page") ? viewbag.page : activeAction>
		<cfset pageFile = "views/pages/#activeModule#/#page#View.cfm">

		<cfsavecontent variable="mainContent">
			<cfif not fileExists(expandPath(pageFile))>
				<cfoutput>Warning! Can not find view page: #pageFile#</cfoutput>
			<cfelse>
				<cfinclude template="#pageFile#">
			</cfif>	
		</cfsavecontent>

		<cfset template = isDefined("viewbag.template") ? viewbag.template : "default">
		<cfset templateFile = "views/templates/#template#.cfm">

		<cfif not fileExists(expandPath(templateFile))>
			<cfoutput>Warning! Can not find template: #templateFile#</cfoutput>
		<cfelse>
			<cfinclude template="#templateFile#">
		</cfif>
	</cfcase>

	<cfcase value="ajax">
		<cfswitch expression="#viewbag.dataType#">
			<cfcase value="page">
				<cfinclude template="views/pages/#activeModule#/#activeAction#AjaxView.cfm">
			</cfcase>
			<cfcase value="html">
				<cfoutput>#viewbag.data#</cfoutput>
			</cfcase>
			<cfcase value="json">
				<cfoutput>#serializeJSON(viewbag.data)#</cfoutput>
			</cfcase>
			<cfdefaultcase>
				<cfoutput>#viewbag.data#</cfoutput>
			</cfdefaultcase>
		</cfswitch>
	</cfcase>

	<cfcase value="file">
		<cfheader name="Content-Disposition" value="attachment; filename=#viewbag.fileName#">
		<cfcontent type="#viewbag.contentType#; charset=utf-8" file="#viewbag.filePath#">	
	</cfcase>

	<cfdefaultcase>
		<cfoutput>Unknown page type #pageType#</cfoutput>
	</cfdefaultcase>
</cfswitch>