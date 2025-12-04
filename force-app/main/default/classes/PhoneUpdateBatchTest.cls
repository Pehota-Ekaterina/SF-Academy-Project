@IsTest
private class PhoneUpdateBatchTest {
    @TestSetup
    static void makeData(){
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 10; i++) {
            Contact contact = new Contact(
                LastName = 'Test' + i,
                FirstName = 'Test' + i
            );
            contacts.add(contact);
        }        
        insert contacts;
    }

    static void makeBigData(Integer countRecords){
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < countRecords; i++) {
            Contact contact = new Contact(
                LastName = 'Test' + i,
                FirstName = 'Test' + i
            );
            contacts.add(contact);
        }        
        insert contacts;
    }

    @IsTest
    private static void testPositive() {
        Integer initial = [SELECT COUNT() FROM Contact WHERE Phone = null OR Phone = ''];

        Test.startTest();
            ID jobId = Database.executeBatch(new PhoneUpdateBatch());
        Test.stopTest();

        Integer resultEmpty = [SELECT COUNT() FROM Contact WHERE Phone = null OR Phone = ''];
        Integer resultNotEmpty = [SELECT COUNT() FROM Contact WHERE Phone <> null AND Phone <> ''];
        System.assertEquals(0, resultEmpty);
        System.assertEquals(initial, resultNotEmpty);
    }

    @IsTest
    private static void testBigData() {
        makeBigData(210);
        Integer initial = [SELECT COUNT() FROM Contact WHERE Phone = null OR Phone = ''];

        Test.startTest();
            ID jobId = Database.executeBatch(new PhoneUpdateBatch(), 220);
        Test.stopTest();

        Integer resultEmpty = [SELECT COUNT() FROM Contact WHERE Phone = null OR Phone = ''];
        Integer resultNotEmpty = [SELECT COUNT() FROM Contact WHERE Phone <> null AND Phone <> ''];
        System.assertEquals(0, resultEmpty);
        System.assertEquals(initial, resultNotEmpty);
    }
}