public class FeatureTask extends BaseTask {
    private Integer priority = 2;

    public Integer getPriority() {
        return priority;
    }

    public override void completeTask() {
        System.debug('Feature created');
    }
}