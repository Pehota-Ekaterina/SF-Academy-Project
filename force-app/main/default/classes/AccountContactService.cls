public with sharing class AccountContactService {
    
    public class AccountContactWrapper {
        @AuraEnabled public String accountId;
        @AuraEnabled public String accountName;
        @AuraEnabled public List<ContactWrapper> contacts;

        public AccountContactWrapper(Account acc) {
            this.accountId = acc.Id;
            this.accountName = acc.Name;
            this.contacts = new List<ContactWrapper>();
        }
    }

    public class ContactWrapper {
        @AuraEnabled public String contactId;
        @AuraEnabled public String name;
        @AuraEnabled public String email;
        @AuraEnabled public String phone;

        public ContactWrapper(Contact c) {
            this.contactId = c.Id;
            this.name = c.Name;
            this.email = c.Email;
            this.phone = c.Phone;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<AccountContactWrapper> searchContactsByAccount(String accountName) {
        if (String.isBlank(accountName)) {
            throw new AuraHandledException('name musnt be empty');
        }

        List<Account> accounts = [
            SELECT Id, Name,
                   (SELECT Id, Name, Email, Phone FROM Contacts)
            FROM Account
            WHERE Name LIKE :('%' + accountName + '%')
        ];

        List<AccountContactWrapper> result = new List<AccountContactWrapper>();

        for (Account acc : accounts) {
            AccountContactWrapper wrapper = new AccountContactWrapper(acc);
            for (Contact con : acc.Contacts) {
                wrapper.contacts.add(new ContactWrapper(con));
            }
            result.add(wrapper);
        }

        return result;
    }
}