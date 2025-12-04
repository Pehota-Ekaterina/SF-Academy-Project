public class TaskFactory {
    public static BaseTask createTask(String taskType) {
        switch on taskType {
            when 'Bug' {
                return new BugTask();                                
            }
            when 'Feature' {
                return new FeatureTask();                                
            }
            when 'Maintenance' {
                return new MaintenanceTask();                                
            }
            when else {
                return null;
            }
        }
    }
}