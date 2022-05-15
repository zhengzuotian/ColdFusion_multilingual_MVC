<cfoutput>
	<div class="main-content container">
		<div class="row">
		    <div class="col-12">
		    	<h1>#h.tr('demo.pagingExample.linkLabel')#</h1>
		    	<table class="table">
		    		<tr>
		    			<th>#helper.tr('demo.pagingExample.item')#</th>
		    			<th>#helper.tr('demo.pagingExample.description')#</th>
		    		</tr>
		    		<cfloop array="#viewbag.data#" index="d">
		    			<tr>
		    				<td>#d.itemNum#</td>
		    				<td>#d.description#</td>
		    			</tr>
		    		</cfloop>
		    	</table>
		    	<div class="my-pagination">#viewbag.pagination#</div>
		    </div>
		</div>
	</div>
</cfoutput>
