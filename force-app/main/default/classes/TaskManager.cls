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

    @future
    public static void notifyTaskCompletion(Id taskId) {
        Task__c task = [SELECT Id, Name From Task__c WHERE Id = :taskId];
        System.debug('Notification: Task completed -> ' + task.Name);
    }

    public static void updateTaskPriority(List<Id> taskIds) {
        System.enqueueJob(new TaskPriorityUpdater(taskIds));
    }

    public static Decimal getTaskScore(Task__c task, ITaskScoreStrategy strategy) {
        return strategy.calculateScore(task);
    }

    public static Task__c getById(Id taskId) {
        return [SELECT Id, Name, Priority__c, IsCompleted__c FROM Task__c WHERE Id = :taskId];
    }

    public static void completeTask(Task__c task) {
        task.IsCompleted__c = true;
        update task;
        System.debug('Task updated');
    }
}