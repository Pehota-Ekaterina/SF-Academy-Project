public class RegularTaskScoreStrategy implements ITaskScoreStrategy {
    public Decimal calculateScore(Task__c task) {
        return task.Priority__c * 10;
    }
}