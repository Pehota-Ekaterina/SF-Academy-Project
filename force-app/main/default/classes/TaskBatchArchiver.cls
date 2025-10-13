public with sharing class TaskBatchArchiver implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Name, IsCompleted__c, CreatedDate__c, Archived__c FROM Task__c WHERE IsCompleted = true AND CreatedDate__c < TODAY() - 30';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Task__c> scope) {
        for (Task__c task : scope) {
            task.Archived__c = true;
        }
        update scope;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch process completed.');
    }
}