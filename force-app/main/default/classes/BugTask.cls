public class BugTask extends BaseTask {
    private Integer priority = 1;

    public Integer getPriority() {
        return priority;
    }

    public override void completeTask() {
        System.debug('Bug resolved and closed');
    }
} 