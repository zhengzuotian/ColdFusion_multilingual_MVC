component {
    property name="datasource" type="string";
    property name="lang" type="string";

    public component function init( required string datasource, required string lang){
        this.datasource = arguments.datasource;
        this.lang = arguments.lang;
        return this;
    }

    private function doQuery(required string qryString, required qryParam) {
        return QueryExecute(qryString, qryParam,  {datasource = this.datasource});
    }

    private function execQuery(required string qryString, required qryParam) {
        var qry = new Query()
        qry.setDatasource(this.datasource)
        qry.setSQL(qryString)
        for (param in qryParam) {
            qry.addParam(name: param, value: qryParam[param], null: qryParam[param]=="")
        }
        var qryResult = qry.execute()
        return qryResult.getPrefix();
    }

    public numeric function add(required String tableName, required String fields, required String fieldValuesPlaceholder, required struct params) {
        var qryString = "
            INSERT INTO #arguments.tableName# (#arguments.fields#)
            VALUES (#fieldValuesPlaceholder#)
        "
        var result = execQuery(qryString, arguments.params)
        return structKeyExists(result, "generatedkey") ? result.generatedkey : -1
    }

    public numeric function delete(required String tableName, required string primaryKey, required numeric primaryValue) {
        var qryString = "
            DELETE FROM #arguments.tableName#
            WHERE #primaryKey# = :value
        "
        var result = execQuery(qryString, {"value": primaryValue})
        return result.recordcount
    }


    public numeric function update(required String tableName, required String primaryKey, required String setSyntax, required struct params) {
        var qryString = "
            UPDATE #arguments.tableName# 
            SET #arguments.setSyntax#
            WHERE #arguments.primaryKey# = :#primaryKey#
        "
        return execQuery(qryString, arguments.params).recordcount
    }


    public query function load(required String tableName, required string key, required string value, orderBy = "") {
        var qryString = "
            SELECT * 
            FROM #arguments.tableName# 
            WHERE #arguments.key# = ?
        "
        if (arguments.orderBy != "") {
            qryString &= " ORDER BY #arguments.orderBy#"
        }
        var qryParam = [arguments.value]
        return doQuery(qryString, qryParam)
    }
}