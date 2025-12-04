@IsTest
public class TestFactory {
    
    public static void makeData(Integer numberOfRecords) {

        List<Crow__c> crowsToAdd = new List<Crow__c>();

        for (Integer i = 0; i < numberOfRecords; i++) {
            crowsToAdd.add(new Crow__c());
        }

        insert crowsToAdd;
    }

}