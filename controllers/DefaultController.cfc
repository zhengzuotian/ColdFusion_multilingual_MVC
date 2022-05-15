component extends="Controller" {

	public struct function homeAction() {
		var viewbag = initViewbag();
		viewbag.title = this.helper.tr("default.home.title");
		viewbag.description = this.helper.tr("default.home.description");
		return viewbag;
	}


	public struct function p404Action() {
		return initViewbag();
	}

	
}
