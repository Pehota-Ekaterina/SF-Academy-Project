public with sharing class PhoneUpdateBatch implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Phone FROM Contact');
    }

    public void execute(Database.BatchableContext bc, List<Contact> records) {
        for (Contact item : records) {
            if (item.Phone == null || item.Phone == '') {
                item.Phone = updatePhoneNumber();
            }
        }
        update records;
    }

    public void finish(Database.BatchableContext bc) {
        
    }

    private String updatePhoneNumber() {
        return formatPhoneNumber(
                    createRandomNumber(1000).repeat('-', 2) + '-' + createRandomNumber(10000)
                );
    }

    private String formatPhoneNumber (String phoneNumber) {
        return '(' + phoneNumber.substring(0, 3) + ')' + phoneNumber.substring(3);
    }

    private String createRandomNumber (Integer size) {
        String randomNumber = String.valueOf(Integer.valueof((Math.random() * size)));

        if (randomNumber.length() < size) {
            randomNumber = randomNumber + '0'.repeat(String.valueOf(size).length() - 1 - randomNumber.length());
        }

        return randomNumber;
    }
}