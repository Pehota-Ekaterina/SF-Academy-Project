public with sharing class TaskItem {
    private String id;
    private String title;
    private String description;
    private Integer priority;
    private Boolean isCompleted;
    private Date createdDate;
    private Boolean isArchived;

    public TaskItem(String idTask, String titleTask, String descriptionTask, Integer priorityTask) {
        this.id = idTask;
        this.title = titleTask;
        this.description = descriptionTask;
        this.priority = priorityTask;
        this.isCompleted = false;
        this.createdDate = Date.today();
        this.isArchived = false;
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