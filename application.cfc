<cfcomponent output="false">
	
	
	<cfprocessingdirective pageencoding="utf-8" />

	<cfset THIS.Name = "demo-site">
	<cfset THIS.ApplicationTimeout = CreateTimeSpan(0, 2, 00, 0)>
	<cfset THIS.SessionManagement = "Yes">
	<cfset THIS.SessionTimeout = CreateTimeSpan(0, 2, 00, 0)>
	<cfset THIS.ClientManagement = "No">
	
	<cfsetting
		requesttimeout="20"
		showdebugoutput="true"
		enablecfoutputonly="false"
		/>

	<cffunction
		name="OnApplicationStart"
		access="public"
		returntype="boolean"
		output="false">


		<cfreturn true />
	</cffunction>

	<cffunction
		name="OnSessionStart"
		access="public"
		returntype="void"
		output="false"
		hint="I initialize the session.">
		

	</cffunction>

	<cffunction
		name="OnRequestStart"
		access="public"
		returntype="boolean" 
		output="false"
		hint="I initialize the page request.">

		<!--- DEFINING ARGUMENTS --->
		<cfargument
			name="Page"
			type="string"
			required="true"
			hint="Page requested by visitor."
			/>

		<!--- TO REINITIALIZE PAGE --->
		<cfif StructKeyExists(URL, 'restart')> 
			<cfset THIS.OnApplicationStart()>
		</cfif>
		
		<cfreturn true />
	</cffunction>

</cfcomponent>

