@IsTest
private with sharing class RestResourceClassTest {

    @TestSetup
    private static void makeData(){
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact contact = new Contact(
                LastName = 'Test',
                FirstName = 'Test'
            );
            contacts.add(contact);
        }
        insert contacts;
    }

    @IsTest
    private static void testGetContact() {
        Contact contact = [SELECT FirstName, LastName, Id FROM Contact LIMIT 1];
        String firstName = contact.FirstName;
        String lastName = contact.LastName;
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/Contact/FirstName=' + firstName + '/LastName=' + lastName;
        request.httpMethod = 'GET';
        RestContext.request = request;

        List<Contact> contactListGet = RestResourceClass.getContact();
        List<Contact> contactListSOQL = [SELECT FirstName, LastName, Id FROM Contact WHERE FirstName = :firstName AND LastName = :lastName];
        
        System.assert(contactListGet != null);
        System.assertEquals(contactListSOQL.size(), contactListGet.size());
        System.assertEquals(firstName, contactListGet[0].FirstName);
        System.assertEquals(lastName, contactListGet[0].LastName);
    }

    @IsTest
    private static void testAddContact() {
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/Contact';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf('{"FirstName": "Jon", "LastName": "Doy"}');

        RestContext.request = request;

        Id thisContactId = RestResourceClass.addContact();
        Contact thisContact = [SELECT FirstName, LastName, Id FROM Contact WHERE Id = :thisContactId];

        System.assert(thisContactId != null);
        System.assert(thisContact != null);
        System.assertEquals('Jon', thisContact.FirstName);
        System.assertEquals('Doy', thisContact.LastName);
    }
    
    @IsTest
    private static void testDeleteContact() {
        Contact newContact = new Contact(
            LastName = 'Test1',
            FirstName = 'Test1'
        );
        insert newContact;

        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/Contact/FirstName=' + 'Test' + '/LastName=' + 'Test';
        request.httpMethod = 'DELETE';
        RestContext.request = request;

        RestResourceClass.deleteContact();
        List<Contact> contactList = [SELECT FirstName, LastName, Id FROM Contact];

        System.assert(contactList != null);
        System.assertEquals(1, contactList.size());
    }

}