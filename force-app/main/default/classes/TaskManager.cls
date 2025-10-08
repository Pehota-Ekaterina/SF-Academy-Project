public with sharing class TaskManager {
    public static void addTask(Task__c task) {
        insert task;
    }

    public static List<Task__c> getAllTasks() {
        return [SELECT Id, Name, Priority__c, Description__c, IsCompleted__c FROM Task__c];
    }

    public static List<Task__c> getPendingTasks() {
        return [
            SELECT Id, Name, Priority__c, Description__c, IsCompleted__c 
            FROM Task__c
            WHERE IsCompleted__c = false
        ];
    }

    public static List<Task__c> getCompletedTasks() {
        return [
            SELECT Id, Name, Priority__c, Description__c, IsCompleted__c 
            FROM Task__c
            WHERE IsCompleted__c = true
        ];
    }

    public static List<Task__c> findTasksByPriority(Integer priority) {
        return [
            SELECT Id, Name, Priority__c, Description__c, IsCompleted__c 
            FROM Task__c
            WHERE Priority__c = :priority
        ];
    }

    public static List<List<Task__c>> findTaskByTitle(String title) {
        return [FIND :title IN NAME FIELDS RETURNING Task__c];
    }
}