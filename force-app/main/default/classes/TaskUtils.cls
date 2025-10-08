public with sharing class TaskUtils {
    public static void printTasks(List<Task__c> tasks) {
        Systen.debug(tasks);
    }
}