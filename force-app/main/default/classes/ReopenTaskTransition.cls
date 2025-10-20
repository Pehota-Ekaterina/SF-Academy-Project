public class ReopenTaskTransition extends TaskStateTransition {
    public override void apply(List<Task__c> tasks) {
        for (Task__c task : tasks) {
            task.IsCompleted__c = false;
            TaskAuditService.logTask(task);
        }
    }
}