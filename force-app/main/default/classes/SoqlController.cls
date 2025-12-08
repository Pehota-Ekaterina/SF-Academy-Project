public with sharing class SoqlController {
    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchRecords(String soqlQuery) {
        try {
            String query = soqlQuery.trim();
            
            if (!query.toLowerCase().startsWith('select')) {
                throw new AuraHandledException('Only SELECT queries are allowed.');
            }
            
            return Database.query(query);
        } catch (QueryException e) {
            throw new AuraHandledException('Invalid SOQL: ' + e.getMessage());
        } catch (Exception e) {
            throw new AuraHandledException('Error: ' + e.getMessage());
        }
    }
}