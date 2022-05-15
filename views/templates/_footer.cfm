<cfoutput>
	<hr>
	<!-- Footer -->
	<footer id="footer" class="footer divider layer-overlay overlay-dark-9" >
		<div class="footer-bottom bg-black-333">
			<div class="container pt-20 pb-20">
				<div class="row">
					<div class="col-md-6">
						<p class="font-11 text-black-777 m-0">Copyright &copy;<cfoutput>#DatePart("yyyy",Now())#</cfoutput> - #helper.tr('general.company')#</p>
					</div>
					<div class="col-md-6 text-right">
						#helper.tr('general.footer')#
					</div>
				</div>
			</div>
		</div>
	</footer>
</cfoutput>