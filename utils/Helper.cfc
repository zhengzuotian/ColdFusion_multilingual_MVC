component {
	property name="lang" type="string";

	public component function init(required string lang){
		this.lang = arguments.lang;
		return this;
	}

	public struct function getLocaleData() {
		var data = {};
		var path = expandPath("./locale");

		for (lang in application.mvc.config.supportLangs) {
			data[lang] = {};
			var filePath = "#path#\#lang#.json";

			if (fileExists(filePath)) {
				var langData = fileRead(filePath);
				if (isJSON(langData)) {
					data[lang] = deserializeJSON(langData);
				}
			}
		}

		return this.flattenStruct(data);
	}

	public struct function flattenStruct(original, delimiter=".", flattened=structNew(), prefix="") {
		var keys = structKeyArray(original);
		var key = "";
		for (key in keys) {
			if (isStruct(original[key])) {
				flattened = flattenStruct(original[key], delimiter, flattened, prefix & key & delimiter);
			} else {
				flattened[prefix & key] = original[key];
			}
		}
		return flattened;
	}


	public string function tr(keychain, data=[]) {
		var key = this.lang & "." & keychain;
		var value = "{{#key#}}";
		if (structKeyExists(application.mvc.locale, key)) {
			value = application.mvc.locale[key];
			if (isSimpleValue(data)) {
				value = replace(value, "{}", data);
			} else if (isArray(data)) {
				for (d in data) {
					value = replace(value, "{}", d);
				}
			}
		}
		return value;
	}


	public string function getAssetRoot() {
		return application.mvc.assetRoot
	}
	
	
	public string function getPath() {
		return application.mvc.path
	}


	public array function convertQuery2Array(required query q) {
		var a = []
		for(row in q) {
			var temp = {}
			for (column in q.columnList) {
				temp[lcase(column)] = q[column][q.currentRow]
			}
			arrayAppend(a, temp)
		}
		return a
	}


	public struct function convertQuery2Struct(required query q, required string key, required string value) {
		var s = {}
		for(row in q) {
			s[row[arguments.key]] = row[arguments.value]
		}
		return s
	}


	public struct function convertQuery2StructEnhanced(required query q, required string key, required string keyList) {
		var s = {}
		var arrKeys = listToArray(arguments.keyList)
		for(row in q) {
			for (key2 in arrKeys) {
				s[row[arguments.key]][key2] = row[key2]
			}			
		}
		return s
	}


	public string function getPagination(required urlbase, required page, required total, required numberPerPage) {
		if (arguments.total == 0) {
			return "";
		}
		var pagination = "";
		var totalPage = ceiling(arguments.total / arguments.numberPerPage);

		if (arguments.page != 1) {
			pagination &= '<span><a href="#arguments.urlbase#?page=#max(1, arguments.page - 1)#">&lt;&lt;</a></span>'
		}

		if (totalPage <= 20) {
			for (var i = 1; i <= totalPage; i++) {
				pagination &= '<span><a href="#arguments.urlbase#?page=#i#">#(arguments.page eq i ? "<b>#i#</b>" : i)#</a></span>'
			}
		} else {
			for (var i = 1; i <= 5; i++) {
				pagination &= '<span><a href="#arguments.urlbase#?page=#i#">#(arguments.page eq i ? "<b>#i#</b>" : i)#</a></span>';
			}

			if (arguments.page + 2 > 5 and arguments.page - 2 < totalPage - 4) {
				if (max(6, arguments.page - 2) > 6) {
					pagination &= "...";
				}

				for (var i = max(6, arguments.page - 2); i <= min(totalPage - 5, arguments.page + 2); i++) {
					pagination &= '<span><a href="#arguments.urlbase#?page=#i#">#(arguments.page eq i ? "<b>#i#</b>" : i)#</a></span>';
				}

				if (min(totalPage - 5, arguments.page + 2) lt totalPage - 5) {
					pagination &= " ...";
				}
			} else {
				if (arguments.page lte 5 or arguments.page gte totalPage - 4) {
					pagination &= " ...";
				}
			}

			for (var i = totalPage - 4; i <= totalPage; i++) {
				pagination &= '<span><a href="#arguments.urlbase#?page=#i#">#(arguments.page eq i ? "<b>#i#</b>" : i)#</a></span>';
			}
		}

		if (arguments.page != totalPage) {
			pagination &= '<span><a href="#arguments.urlbase#?page=#min(totalPage, arguments.page + 1)#">&gt;&gt;</a></span>'
		}

		var startNum = (page-1) * numberPerPage + 1;
		var endNum = min(page * numberPerPage, total);
		if (startNum < total) {
			pagination &= "#tr('general.pagingCount', [startNum, endNum, total])#";
		}

		pagination &= '
			<form action="#arguments.urlbase#">
				<div class="input-group mb-3">
					<input name="page" type="text" class="form-control" placeholder="#tr('general.skip')#" aria-label="Skip to page" aria-describedby="basic-addon2">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" type="submit"><i class="fa fa-thumbs-up"></i></button>
					</div>
				</div>
			</form>
		';

		return pagination;
	}


	public string function formValueKeeper(required fieldName, optionValue = '', fieldType = 'text'){
		var str = ''
		if (structKeyExists(FORM, arguments.fieldName) OR structKeyExists(URL, arguments.fieldName)) {
			var fieldValue = structKeyExists(URL, arguments.fieldName) ? URL[arguments.fieldName] : FORM[arguments.fieldName]
			switch (arguments.fieldType) {
				case 'radio':
				case 'checkbox':
					if (fieldValue == arguments.optionValue) {
						str = 'checked'
					}
					break
				case 'select':
					if (fieldValue == arguments.optionValue) {
						str = 'selected'
					}
					break
				case 'selectMultiple':
					if (listFindNoCase(fieldValue, arguments.optionValue)) {
						str = 'selected'
					}
					break
				default:
					str = fieldValue
					break
			}
		}
		return str
	}
}
