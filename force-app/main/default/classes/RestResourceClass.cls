@RestResource(urlMapping = '/Contact/*')
global with sharing class RestResourceClass {
    @HttpGet
    global static List<Contact> getContact() {
        RestRequest request = RestContext.request;
        String firstName = request.requestURI.substringBetween('Contact/FirstName=', '/LastName');
        String lastName = request.requestURI.substring(request.requestURI.lastIndexOf('=') + 1);
        List<Contact> thisContactList = [SELECT Id, FirstName, LastName FROM Contact WHERE LastName = :lastName AND firstName = :firstName];
        return thisContactList;
    }

    @HttpPost
    global static Id addContact() {
        RestRequest request = RestContext.request;
        Contact newContact = new Contact();
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.toString());
        for (String fieldName: params.keySet()) {
            newContact.put(fieldName, params.get(fieldName));
        }
        insert newContact;
        return newContact.Id;
    }

    @HttpDelete
    global static void deleteContact() {
        RestRequest request = RestContext.request;
        String firstName = request.requestURI.substringBetween('Contact/FirstName=', '/LastName');
        String lastName = request.requestURI.substring(request.requestURI.lastIndexOf('=') + 1);
        List<Contact> thisContactList = [SELECT Id FROM Contact WHERE LastName = :lastName AND firstName = :firstName];
        delete thisContactList;
    }
}