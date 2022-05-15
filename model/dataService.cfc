component {
	property name="gateway" type="component";
    property name="helper" type="component";


	public component function init( required string datasource, required string lang, required component helper){
        this.helper = arguments.helper;
        this.gateway = createObject("component", "model.dataGateway").init(arguments.datasource, arguments.lang);
        return this;
    }


    public void function save(required component obj) {
        var metaData = getMetadata(obj);
        var tableName = metaData.table;
        var primaryKey = metadata.key;
        var params = obj.toStruct(excluding="#primaryKey#");
        var fields = structKeyList(params);

    	if (obj[primaryKey] == "") {
            
            // prepare value placeholder like :field1,:field2,...
            var fieldValuesPlaceholder = arrayToList(listToArray(fields).map(function(f){return ":#f#"}));
            // update id after inserted
            obj[primaryKey] = this.gateway.add(tableName, fields, fieldValuesPlaceholder, params);
        } else {
            // prepare set syntax in string like field1=:field1,field2=:field2,...
            var setSyntax = arrayToList(listToArray(fields).map(function(f){return "#f#=:#f#"}));
            // add value for primaryKey
            params[primaryKey] = obj[primaryKey];
            this.gateway.update(tableName, primaryKey, setSyntax, params);
        }
    }


    public struct function delete(required component obj) {
        var result = {"error": false, "message": ""};
        var metaData = getMetadata(obj);
        var tableName = metaData.table;
        var primaryKey = metadata.key;

        if (obj[primaryKey] != "") {
            this.gateway.delete(tableName, primaryKey, obj[primaryKey]);
        } else {
            result = {"error": true, "message": "Record not found."};
        }
        return result;
    }


    public void function deleteEntities(required string entity, required string key, required string value) {
        var tableName = getTableName(arguments.entity);
        this.gateway.delete(tableName, arguments.key, arguments.value);
    }


    public component function createEntity(string entity, struct data) {     
        return createObject("component", "model.beans.#entity#").init(data);
    }


    public component function loadEntity(string entity, string columnName, string columnValue) {
        var tableName = getTableName(arguments.entity);
        var q = this.gateway.load(tableName, columnName, columnValue);
        var data = {};
        if (q.recordcount != 0) {
            data = this.helper.convertQuery2Array(q)[1];
        }       
        return createObject("component", "model.beans.#entity#").init(data);
    }


    public array function loadEntities(string entity, string columnName, string columnValue, string orderBy = "") {
        var tableName = getTableName(arguments.entity);
        var entities = [];
        var q = this.gateway.load(tableName, columnName, columnValue, orderBy);
        var data = this.helper.convertQuery2Array(q);
        for (d in data) {
            arrayAppend(entities, createObject("component", "model.beans.#entity#").init(d).toStruct());
        }     
        return entities;
    }


    private string function getTableName( required string entity) {
        var obj = createEntity(arguments.entity, {});
        var metaData = getMetadata(obj);
        return metaData.table;
    }

}