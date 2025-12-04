public with sharing class TaskFacade {
    public static void completeTask(Id taskId) {
        Task__c task = TaskManager.getById(taskId);
        TaskManager.completeTask(task);
        TaskScoringService.recalculatedScore(task);
        TaskNotifier.notifyTask(task);
        TaskAuditService.logTask(task);
    }

    public static void completeTaskWithoutUpdate(Id taskId) {
        Task__c task = TaskManager.getById(taskId);
        TaskScoringService.recalculatedScore(task);
        TaskNotifier.notifyTask(task);
        TaskAuditService.logTask(task);
    }
}