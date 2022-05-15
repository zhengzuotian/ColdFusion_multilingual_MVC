abstract component {

	public component function init( struct data = {} ){
    	initProperties(arguments.data)
        return this
    }

    private void function initProperties(struct data) {
    	var properties = getMetaData(this).properties
    	for (prop in properties) {
    		if (structKeyExists(arguments.data, prop.name)) {
    			this[prop.name] = arguments.data[prop.name]
    		} else {
    			this[prop.name] = ""
    		}
    	}
    }

    public boolean function isInfoComplete(string props) {
    	var isComplete = true;
    	for (prop in props) {
			if (isNULL(this[prop]) or this[prop] == "") {
				isComplete = false
				break
			}
    	}
    	return isComplete
    }

    public struct function toStruct(excluding="", including="") {
    	var sReturn = {}
    	var properties = getMetaData(this).properties
    	for (prop in properties) {
    		if (not listFindNoCase(arguments.excluding, prop.name) and (arguments.including == "" or listFindNoCase(arguments.including, prop.name))) {
    			sReturn[prop.name] = this[prop.name]
    		}
    	}
    	return sReturn
    }
}
