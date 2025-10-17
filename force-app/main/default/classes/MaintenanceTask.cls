public class MaintenanceTask extends BaseTask {
    private Integer priority = 3;

    public Integer getPriority() {
        return priority;
    }

    public override void completeTask() {
        System.debug('Maintenance completed');
    }
}