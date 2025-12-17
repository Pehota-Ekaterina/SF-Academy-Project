public with sharing class SOQLService {
    
    @AuraEnabled(cacheable=true)
    public static List<String> getObjectsList(){
        try {
            List<String> objectNames = new List<String>();
            for (Schema.SObjectType objType : Schema.getGlobalDescribe().values()) {
                Schema.DescribeSObjectResult objDesc = objType.getDescribe();
                if (objDesc.isQueryable() &&
                    !objDesc.getName().startsWith('Partner') &&
                    !objDesc.getName().startsWith('RecordAction')) {
                    objectNames.add(objDesc.getName());
                }
            }
            objectNames.sort();
            return objectNames;            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<String> getFieldsList(String objectName){
        try {
            List<String> fieldNames = new List<String>();
            Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
            if (objType != null) {
                Map<String, Schema.SObjectField> fieldsMap = objType.getDescribe().fields.getMap();
                for (String fieldName : fieldsMap.keySet()) {
                    Schema.SObjectField field = fieldsMap.get(fieldName);
                    Schema.DescribeFieldResult fieldDesc = field.getDescribe();
                    if (fieldDesc.isAccessible()) {
                        fieldNames.add(fieldName);
                    }
                }
                fieldNames.sort();
            }
            return fieldNames;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<SObject> executeQuery(String soqlQuery) {
        try {
            return Database.query(soqlQuery);
        } catch (QueryException e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}