<cfoutput>
	<div class="container">
		
		<div class="row">
			<div class="col-md-6">
				<a href="#rc.linkTo('default', 'home')#">#helper.tr('general.home')#</a>
				<header>#helper.tr('general.header')#</header>
			</div>
			<div class="col-md-6 text-right">
				<cfloop array="#application.mvc.config.supportLangs#" index="lang">
					<cfif lang neq activeLang>
						<a href="#rc.linkTo(activeModule, activeAction, lang)#">#uCase(lang)#</a>
					</cfif>
				</cfloop>
			</div>
		</div>
	</div>
	
	<hr>
</cfoutput>