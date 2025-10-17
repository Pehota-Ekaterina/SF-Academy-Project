public class VipTaskScoreStrategy implements ITaskScoreStrategy {
    public Decimal calculateScore(Task__c task) {
        return 100 / task.Priority__c;
    }
}