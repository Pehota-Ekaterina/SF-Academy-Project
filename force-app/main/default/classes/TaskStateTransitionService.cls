public class TaskStateTransitionService {
    public static void applyTransition(List<Id> taskIds, TaskStateTransition transition) {
        List<Task__c> tasks = [SELECT Id, Name, IsCompleted__c FROM Task__c WHERE Id IN :taskIds];
        transition.apply(tasks);
        update tasks;
    }
}