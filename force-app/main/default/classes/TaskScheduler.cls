public class TaskScheduler implements Schedulable {
    public void execute(Schedulablecontext sc) {
        Database.executeBatch(new TaskBatchArchiver(), 200);
    }
}