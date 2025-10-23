public class AppSettings {
    private static AppSettings instance = null;
    private Integer defaultPriority; 
    private Integer maxTasksPerUser;

    private AppSettings() {
        //App_Config__c appConfig = [SELECT Default_Priority__c, Max_Tasks_Per_User__c FROM App_Config__c LIMIT 1];
        CustomSettingConfig__c appConfig = CustomSettingConfig__c.getInstance('version1');
        this.defaultPriority = Integer.valueOf(appConfig.defaultPriority__c);
        this.maxTasksPerUser = Integer.valueOf(appConfig.maxTasksPerUser__c);
    }

    public static AppSettings getInstance() {
        if (instance == null) {
            instance = new AppSettings();
        }
        return instance;
    }

    public Integer getDefaultPriority() {
        return defaultPriority;
    }
    
    public Integer getMaxTasksPerUser() {
        return maxTasksPerUser;
    }
}