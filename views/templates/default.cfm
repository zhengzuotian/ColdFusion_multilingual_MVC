<!DOCTYPE html>
<html lang="en-CA">
	<head>
		<!-- Meta Tags -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
		<meta name="description" content="..." />
		<meta name="keywords" content="..." />

		<!-- Page Title -->
		<title>My website</title>

		<!-- External Stylesheet -->
		<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

		<!-- CCS | Custom css for all pages --> 
		<link rel="stylesheet" href="<cfoutput>#application.mvc.config.rootPubAssets#</cfoutput>/css/allpage.css"></script>

		<!-- module level css -->
		<cfif fileExists(expandPath("assets/css/#activeModule#.css"))>
			<cfoutput>
				<link rel="stylesheet" href="#application.mvc.config.rootPubAssets#/css/#activeModule#.css" type="text/css" media="screen">
			</cfoutput>
		</cfif>

		<!-- page level css -->
		<cfif fileExists(expandPath("assets/pages/#activeModule#/css/#activeAction#.css"))>
			<cfoutput>
				<link rel="stylesheet" href="#application.mvc.config.rootPubAssets#/pages/#activeModule#/css/#activeAction#.css" type="text/css" media="screen">
			</cfoutput>
		</cfif>

	</head>

	<body class="">
		<div id="wrapper" class="clearfix">
			<cfinclude template="_header.cfm">

			<cfif isDefined("mainContent")>
				<cfoutput>#mainContent#</cfoutput>
			<cfelse>
				Undefined content
			</cfif>

			<cfinclude template="_footer.cfm">
		</div>

		<div id="ajax-result" style="position: fixed; bottom: 0; z-index: 9;width: 100%; text-align: center; display: none;"></div>

		<!-- Footer Scripts -->

		<!-- external javascripts -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.3.0/jquery.form.min.js" integrity="sha384-qlmct0AOBiA2VPZkMY3+2WqkHtIQ9lSdAsAn5RUJD/3vA5MKDgSGcdmIv4ycVxyn" crossorigin="anonymous"></script>

		<script type="text/javascript">
			var url_root = '<cfoutput>#viewbag.urlRoot#</cfoutput>';
		</script>

		<!--- website root --->
		<script type="text/javascript">var website_root = '<cfoutput>#application.mvc.config.rootPub#</cfoutput>';</script>
		<!--- ajax handler --->
		<script src="<cfoutput>#application.mvc.config.rootPubAssets#</cfoutput>/scripts/ajax.js" type="text/javascript"></script>
		<!-- JS | Custom script for all pages --> 
		<script src="<cfoutput>#application.mvc.config.rootPubAssets#</cfoutput>/scripts/allpage.js"></script>

		<!-- module level js -->
		<cfif fileExists(expandPath("#application.mvc.config.rootPubAssets#/scripts/#activeModule#.js"))>
			<cfoutput>
				<script src="#application.mvc.config.rootPubAssets#/scripts/#activeModule#.js" type="text/javascript"></script>
			</cfoutput>
		</cfif>

		<!-- page level js -->
		<cfif fileExists(expandPath("#application.mvc.config.rootPubAssets#/pages/#activeModule#/scripts/#activeAction#.js"))>
			<cfoutput>
				<script src="#application.mvc.config.rootPubAssets#/pages/#activeModule#/scripts/#activeAction#.js" type="text/javascript"></script>
			</cfoutput>
		</cfif>
	</body>
</html>