@IsTest
public class CrowCalcTest {

    @TestSetup
    static void makeData(){
        List<Crow__c> crowsToAdd = new List<Crow__c>();

        for (Integer i = 0; i < 10; i++) {
            crowsToAdd.add(new Crow__c());
        }

        insert crowsToAdd;
    }

    @IsTest
    public static void testAddCrows() {

        TestFactory.makeData(5);
        Integer initialCrows = [SELECT COUNT() FROM Crow__c];

        Integer numberToAdd = 10;
        Boolean addCrowsResult = CrowCalc.addCrows(numberToAdd);
        Integer crowsAfter = [SELECT COUNT() FROM Crow__c] - initialCrows;

        System.assert(crowsAfter == numberToAdd, 'Wrong answer!');
        System.assert(addCrowsResult, 'Success addition not "true"');
    }

    @IsTest
    public static void testAddCrowsBigData() {

        TestFactory.makeData(5);
        Integer initialCrows = [SELECT COUNT() FROM Crow__c];
      
        Integer numberToAdd = 100;
        Boolean addCrowsResult = CrowCalc.addCrows(numberToAdd);
        Integer crowsAfter = [SELECT COUNT() FROM Crow__c] - initialCrows;

        System.assert(crowsAfter == numberToAdd, 'Wrong answer!');
        System.assert(addCrowsResult, 'Success addition not "true"');
    }

    @IsTest
    public static void testSubtractCrows() {
        TestFactory.makeData(5);
        Integer numberOfDelete = 3;
        Integer initialCrows = [SELECT COUNT() FROM Crow__c];
        Boolean subtractCrowsResult = CrowCalc.subtractCrows(numberOfDelete);
        Integer crowsAfter = [SELECT COUNT() FROM Crow__c];

        System.assert(crowsAfter == (initialCrows - numberOfDelete), 'Wrong answer!');
        System.assert(subtractCrowsResult, 'Success addition not "true"');
    }

    @IsTest
    public static void testGetTotal() {
        TestFactory.makeData(5);

        Integer getTotalResult = CrowCalc.getTotal();
        Integer crowsAfter = [SELECT COUNT() FROM Crow__c];

        System.assert(crowsAfter == getTotalResult, 'Wrong answer!');
    }

    @IsTest
    public static void testResetCalc() {
        TestFactory.makeData(5);

        Boolean resetCalcResult = CrowCalc.resetCalc();
        Integer crowsAfter = [SELECT COUNT() FROM Crow__c];

        System.assert(crowsAfter == 0, 'Wrong answer!');
        System.assert(resetCalcResult, 'Success addition not "true"');
    }

    @IsTest
    public static void testAddCrowsNegative() {
        Boolean addCrowsResult = CrowCalc.addCrows(null);
        System.assert(!addCrowsResult, 'Success addition not "false"');
    }

    @IsTest
    public static void testSubtractCrowsNegative() {
        Boolean addSubtractResult = CrowCalc.subtractCrows(null);
        System.assert(!addSubtractResult, 'Success addition not "false"');
    }
}