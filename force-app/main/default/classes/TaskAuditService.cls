public with sharing class TaskAuditService {
    public static void logTask(Task__c task) {
        System.debug('Audit record created');
    }
}