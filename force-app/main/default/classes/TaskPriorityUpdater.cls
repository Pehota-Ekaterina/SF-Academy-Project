public with sharing class TaskPriorityUpdater implements Queueable {
    private List<Id> taskIdsList = new List<Id>();

    public TaskPriorityUpdater(List<Id> taskIds) {
        this.taskIdsList = taskIds.clone();
    }

    public void execute(QueueableContext cont) {
        List<Task__c> tasksToUpdate = [SELECT Id, Priority__c FROM Task__c WHERE Id IN : taskIdsList];
        for (Task__c task : tasksToUpdate) {
            task.Priority__c += 1;
        }
        update tasksToUpdate;
    }
}