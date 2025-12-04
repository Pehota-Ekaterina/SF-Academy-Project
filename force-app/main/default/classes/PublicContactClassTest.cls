@isTest
public class PublicContactClassTest {
    @isTest
    public static void PublicContactClassTest() {
        Contact testContact = new Contact(LastName = 'Test', FirstName = 'Test');
        insert testContact;
        PublicContactClass publicContact = new PublicContactClass(123456, testContact);
        System.assertEquals(123456, publicContact.getVolunteerNumber());
        System.assertEquals(testContact, publicContact.getContactRecord());
        System.assertEquals('Person', publicContact.getContactType());
    }
    
}