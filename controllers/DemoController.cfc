component extends="Controller" {

	public struct function exampleAction() {
		var viewbag = initViewbag();
		viewbag.title = this.helper.tr("demo.example.title");
		viewbag.titleAjax = this.helper.tr("demo.example.titleAjax");

		if (!structIsEmpty(form)) {
			viewbag.data = form;
		}

		return viewbag;
	}


	public struct function exampleAjaxAction() {
		var viewbag = initAjaxViewbag();
		var returnJson = {
			"input1": form.input1,
			"input2": form.input2
		}
		// keys need to be lower case for front-end json
		var dataReceived = {
			"input1": form.input1,
			"input2": form.input2
		}

		viewbag.data.message = this.helper.tr('demo.example.received') & ": " & serializeJSON(dataReceived);
		return viewbag;
	}


	public struct function anySpecificNameAction() {
		var viewbag = initViewbag();
		viewbag.message = this.helper.tr('demo.anySpecificName.message');
		viewbag.data = "Any other data in string, array or collection that you want to pass to view file"
		return viewbag;
	}

	
	public struct function pagingExampleAction() {
		var viewbag = initViewbag();

		var urlbase = this.requestController.linkTo('demo', 'pagingExample');
		var page = structKeyExists(URL, "page") && isValid("range", URL.page, 1, 999999) ? URL.page : 1;
		var total = this.demoService.getExamplePageTotal();
		var numberPerPage = 10;

		viewbag.data = this.demoService.getExampleData(page, numberPerPage, total);

		viewbag.pagination = this.helper.getPagination(urlbase, page, total, numberPerPage);
		return viewbag;
	}


	public struct function queriesExampleAction() {
		var viewbag = initViewbag();
		// Record for the form, empty for new record adding by default
		viewbag.record = this.dataService.createEntity('Example', {});
		viewbag.btnLabel = this.helper.tr('demo.queriesExample.labelBtnAdd');
		viewbag.submitType = "add";

		// Add new record
		if (structKeyExists(form, "add")) {
			var data = {
				"f1": form.f1,
				"f2": form.f2,
				"f3": structKeyExists(form, "f3") ? 1 : 0,
				"f4": form.f4
			}
			var newRecord = this.dataService.createEntity('Example', data);
			this.dataService.save(newRecord);
			viewbag.result = newRecord;
			viewbag.message = this.helper.tr('demo.queriesExample.recordAdded');
		}

		// Fetch existing record to update
		if (structKeyExists(url, "fetch")) {
			if (isValid("integer", url.fetch)) {
				// Record for the form
				viewbag.record = this.dataService.loadEntity('Example', 'id', url.fetch);
				viewbag.btnLabel = this.helper.tr('demo.queriesExample.labelBtnUpdate');
				viewbag.submitType = "update";
			}
		}

		// Update record
		if (structKeyExists(form, "update")) {
			if (isValid("integer", form.id)) {
				var record = this.dataService.loadEntity('Example', 'id', form.id);
				record.f1 = form.f1;
				record.f2 = form.f2;
				record.f3 = structKeyExists(form, "f3") ? 1 : 0;
				record.f4 = form.f4;
				this.dataService.save(record);
				viewbag.result = record;
				viewbag.message = this.helper.tr('demo.queriesExample.recordUpdated');
			}
		}

		// Delete record
		if (structKeyExists(url, "delete")) {
			if (isValid("integer", url.delete)) {
				var record = this.dataService.loadEntity('Example', 'id', url.delete);
				this.dataService.delete(record);
				viewbag.result = record;
				viewbag.message = this.helper.tr('demo.queriesExample.recordDeleted');
			}
		}

		// Existing data
		var urlbase = this.requestController.linkTo('demo', 'queriesExample');
		var page = structKeyExists(URL, "page") && isValid("range", URL.page, 1, 999999) ? URL.page : 1;
		var total = this.demoService.getDataTotal();
		var numberPerPage = 5;
		viewbag.data = this.demoService.getData(page, numberPerPage);
		viewbag.pagination = this.helper.getPagination(urlbase, page, total, numberPerPage);

		return viewbag;
	}
}
