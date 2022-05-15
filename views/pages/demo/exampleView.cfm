<cfoutput>
	<div class="main-content container">
		<div class="row">
			<div class="col-12" style="min-height: 400px;padding-top: 50px;">
				<h1>#viewbag.title#</h1>
				<form action="#rc.linkTo('demo', 'example')#" method="post">
					<div class="form-group">
						<label for="formGroupExampleInput">#helper.tr('demo.example.input1Label')#</label>
						<input type="text" name="input1" class="form-control" id="formGroupExampleInput" placeholder="#helper.tr('demo.example.input1Label')#">
					</div>
					<div class="form-group">
						<label for="formGroupExampleInput2">#helper.tr('demo.example.input2Label')#</label>
						<input type="text" name="input2" class="form-control" id="formGroupExampleInput2" placeholder="#helper.tr('demo.example.input2Label')#">
					</div>
					<button type="submit" class="btn btn-primary">#helper.tr('demo.example.submit')#</button>
				</form>
			</div>
		</div>

		<cfif structKeyExists(viewbag, "data")>
			<div class="row">
				<div class="col-12">
					<h2>#helper.tr('demo.example.received')#</h2>
					<cfdump var="#viewbag.data#">
				</div>
			</div>
		</cfif>

		<div class="row">
			<div class="col-12" style="min-height: 400px;padding-top: 50px;">
				<h1>#viewbag.titleAjax#</h1>
				<form class="ajax-form" action="#rc.linkTo('demo', 'exampleAjax')#" method="post">
					<div class="form-group">
						<label for="formGroupExampleInput">#helper.tr('demo.example.input1Label')#</label>
						<input type="text" name="input1" class="form-control" id="formGroupExampleInput" placeholder="#helper.tr('demo.example.input1Label')#">
					</div>
					<div class="form-group">
						<label for="formGroupExampleInput2">#helper.tr('demo.example.input2Label')#</label>
						<input type="text" name="input2" class="form-control" id="formGroupExampleInput2" placeholder="#helper.tr('demo.example.input2Label')#">
					</div>
					<button type="submit" class="btn btn-primary">#helper.tr('demo.example.ajaxSubmit')#</button>
				</form>
			</div>
		</div>
	</div>
</cfoutput>
