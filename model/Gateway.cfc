abstract component {
	property name="datasource" type="string";
    property name="lang" type="string";

	public component function init( required string datasource, required string lang){
        this.datasource = arguments.datasource;
        this.lang = arguments.lang;
        return this;
    }

    private function doQuery(required string qryString, required array qryParam) {
    	return QueryExecute(qryString, qryParam,  {datasource = this.datasource});
    }

    private function execQuery(required string qryString, required array qryParam) {
    	QueryExecute(qryString, qryParam,  {datasource = this.datasource, result="qryResult"});
    	return qryResult;
    }
}