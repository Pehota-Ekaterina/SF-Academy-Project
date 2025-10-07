public with sharing class TaskUtils {
    public static void printTaskDetails(TaskItem task) {
        task.taskDetails();
    }

    public static void printTasks(List<TaskItem> tasksList) {
        for (TaskItem task : tasksList) {
            printTaskDetails(task);
        }
    }
}