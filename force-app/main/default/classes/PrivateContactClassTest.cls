@isTest
public class PrivateContactClassTest {
    @isTest
    public static void PrivateContactClassPersonTest() {
        Contact testContact = new Contact(LastName = 'Test', FirstName = 'Test');
        insert testContact;
        Integer cardNumber = 123456;
        PrivateContactClass privateContact = new PrivateContactClass(cardNumber, testContact);

        System.assertEquals(cardNumber, privateContact.getCardNumber());
        System.assertEquals(testContact, privateContact.getContactRecord());
        System.assertEquals('Person', privateContact.getContactType());
    }

    @isTest
    public static void PrivateContactClassPremierTest() {
        Contact testContact = new Contact(LastName = 'Test', FirstName = 'Test');
        insert testContact;
        Integer cardNumber = 123433;
        PrivateContactClass privateContact = new PrivateContactClass(cardNumber, testContact);

        System.assertEquals(cardNumber, privateContact.getCardNumber());
        System.assertEquals(testContact, privateContact.getContactRecord());
        System.assertEquals('Premier', privateContact.getContactType());
    }
}
