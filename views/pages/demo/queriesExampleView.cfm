<cfoutput>
	<div class="main-content container">
		<div class="row">
			<div class="col-12">
				<h1>#h.tr('demo.queriesExample.linkLabel')#</h1>
				<form action="#rc.linkTo('demo', 'queriesExample')#" method="post">
					<input type="hidden" name="id" value="#viewbag.record.id#">
					<div class="form-group">
						<label for="f1">F1</label>
						<input name="f1" value="#dateFormat(viewbag.record.f1, 'yyyy-mm-dd')#" type="date" class="form-control" id="f1" required>
					</div>
					<div class="form-group">
						<label for="f1">F2</label>
						<input name="f2" value="#viewbag.record.f2#" type="number" min="0" step="1" class="form-control" id="f2" required>
					</div>
					<div class="form-check">
						<cfset checked = viewbag.record.f3 eq 1 ? "checked" : "">
						<input name="f3" #checked# type="checkbox" class="form-check-input" id="f3">
						<label class="form-check-label" for="f3">F3</label>
					</div>
					<div class="form-group">
						<label for="f4">F4</label>
						<input name="f4" value="#viewbag.record.f4#" type="text" class="form-control" id="f4" required>
					</div>
					<button name="#viewbag.submitType#" type="submit" class="btn btn-primary">#viewbag.btnLabel#</button>
				</form>
		    </div>
		</div>

		<cfif structKeyExists(viewbag, "result")>
			<div class="alert alert-info mt-4">
				#viewbag.message# 
				<br>ID: #viewbag.result.id#,  
				<br>F1: #viewbag.result.f1#
				<br>F2: #viewbag.result.f2#
				<br>F3: #YesNoFormat(viewbag.result.f3)#
				<br>F4: #viewbag.result.f4#
			</div>
		</cfif>

		<div class="row">
			<div class="col-12 mt-4">
				<div class="my-pagination">#viewbag.pagination#</div>
				<table class="table">
		    		<tr>
		    			<th>ID</th>
		    			<th>F1</th>
		    			<th>F2</th>
		    			<th>F3</th>
		    			<th>F4</th>
		    			<th>#h.tr('demo.queriesExample.labelBtnUpdate')#</th>
		    			<th>#h.tr('demo.queriesExample.labelBtnDelete')#</th>
		    		</tr>
		    		<cfloop array="#viewbag.data#" index="d">
		    			<tr>
		    				<td>#d.id#</td>
		    				<td>#d.f1#</td>
		    				<td>#d.f2#</td>
		    				<td>#d.f3#</td>
		    				<td>#d.f4#</td>
		    				<td><a href="?fetch=#d.id#"><i class="fa fa-edit"></i></a></td>
		    				<td><a href="?delete=#d.id#"><i class="fa fa-trash"></i></a></td>
		    			</tr>
		    		</cfloop>
		    	</table>
			</div>
		</div>
	</div>
</cfoutput>
