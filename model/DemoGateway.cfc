component extends="Gateway" {

	public query function getDataTotal() {
		var qryString = "
			SELECT count(*) AS num
			FROM examples
		";
		var qryParam = [];
		return doQuery(qryString, qryParam);
	}

	public query function getData(page, numberPerPage) {
		var offset = (page - 1 ) * numberPerPage;
		var qryString = "
			SELECT id, f1, f2, f3, f4
			FROM examples
			ORDER BY id
			OFFSET #offset# ROWS
			FETCH NEXT #numberPerPage# ROWS ONLY
		";
		var qryParam = [];
		return doQuery(qryString, qryParam);
	}


	public query function exampleWithMoreParams(idList, f1) {
		var queryService = new query();
		queryService.setDatasource(this.datasource);

		var qryString = "
			SELECT id, f1, f2, f3, f4
			FROM examples
			WHERE	id IN (:idList)
			AND f1 > :f1
		";

		queryService.addParam(name="idList",value="#coursIdList#",cfsqltype="cf_sql_integer", list="true");
		queryService.addParam(name="f1",value="#f1#",cfsqltype="cf_sql_date");
		var result = queryService.execute(sql=qryString);

    	return result.getResult();
	}
}
