trigger TaskTrigger on Task__C (after insert, after update) {
    if (Trigger.isInsert) {
        for (Task__c task : Trigger.new) {
            if (task.Priority__c == 1) {
                System.debug('High priority task created: ' + task.Name);
            }
        }
    }
    if (Trigger.isUpdate) {
        for (Task__c task : Trigger.new) {
            Task__c oldTask = Trigger.oldMap.get(task.Id);
            if (task.IsCompleted__c && !oldTask.IsCompleted__c) {
                System.debug('Task completed: ' + task.Name);
            }
        }
    }
}