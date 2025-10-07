public with sharing class TaskItem {
    String id;
    String title;
    String description;
    Integer priority;
    Boolean isCompleted;

    public TaskItem(String idTask, String titleTask, String descriptionTask, Integer priorityTask) {
        this.id = idTask;
        this.title = titleTask;
        this.description = descriptionTask;
        this.priority = priorityTask;
        this.isCompleted = false;
    }

    public void markAsCompleted() {
        this.isCompleted = true;
    }

    public void reopenTask() {
        this.isCompleted = false;
    }

    public void taskDetails() {
        System.debug('Id: ' + this.id);
        System.debug('Title: ' + this.title);
        System.debug('Description: ' + this.description);
        System.debug('Priority: ' + this.priority);
        System.debug('Is Completed: ' + this.isCompleted);
    }

    public String getTitle() {
        return this.title;
    }

    public Integer getPriority() {
        return this.priority;
    }

    public Boolean getIsCompleted() {
        return this.isCompleted;
    }
}