/*
table and id are custom variables in getMetaData, in which
- "table" maps to table name in db
- "key" maps to the name of primary key
- property list match to the fields in the table in db. For the fields not on the list, they will be not managed.
*/
component table="examples" key="id" extends="model.beans.Entity" {
	property name="id" type="numeric"; // prime key
	property name="f1" type="date";
	property name="f2" type="numeric";
	property name="f3" type="boolean";
	property name="f4" type="string";

}
