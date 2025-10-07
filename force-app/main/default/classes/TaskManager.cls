public with sharing class TaskManager {
    static List<TaskItem> tasksList = new List<TaskItem>();

    public static void addTask(TaskItem task) {
        tasksList.add(task);
    }

    public static List<TaskItem> getAllTasks() {
        return tasksList;
    }

    public static List<TaskItem> getPendingTasks() {
        List<TaskItem> tasksListFilter = new List<TaskItem>();
        for (TaskItem task : tasksList) {
            if (task.getIsCompleted() == false) {
                tasksListFilter.add(task);
            }
        }
        return tasksListFilter;
    }

    public static List<TaskItem> getCompletedTasks() {
        List<TaskItem> tasksListFilter = new List<TaskItem>();
        for (TaskItem task : tasksList) {
            if (task.getIsCompleted()) {
                tasksListFilter.add(task);
            }
        }
        return tasksListFilter;
    }

    public static List<TaskItem> findTasksByPriority(Integer priority) {
        List<TaskItem> tasksListFilter = new List<TaskItem>();
        for (TaskItem task : tasksList) {
            if (task.getPriority() == priority) {
                tasksListFilter.add(task);
            }
        }
        return tasksListFilter;
    }

    public static TaskItem findTaskByTitle(String title) {
        for (TaskItem task : tasksList) {
            if (task.getTitle() == title) {
                return task;
            }
        }
        return NULL;
    }
}