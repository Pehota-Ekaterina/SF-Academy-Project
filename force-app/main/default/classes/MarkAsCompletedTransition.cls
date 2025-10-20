public class MarkAsCompletedTransition extends TaskStateTransition {
    public override void apply(List<Task__c> tasks) {
        for (Task__c task : tasks) {
            task.IsCompleted__c = true;
            TaskFacade.completeTaskWithoutUpdate(task.Id);
        }
    }
}