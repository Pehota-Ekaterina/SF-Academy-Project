@isTest
public class AccountSwitcherImplTest {

    @isTest
    public static void getAndSortTest() {
        List<Contact> contactsList = createContacts(10);
        insert contactsList;
        
        AccountSwitcherImpl impl = new AccountSwitcherImpl();
        impl.getAndSort();
        List<TypeClass> allContacts = impl.getAllContacts();

        System.assertEquals(10, allContacts.size());
    }

    @isTest
    public static void switchAccountTest() {
        List<Contact> contactsList = createContacts(10);
        for (Integer i = 0; i < contactsList.size(); i++) {
            if (i < 5) {
                contactsList[i].Amount__c = 15000;
            } else {
                contactsList[i].Amount__c = 5000;
            }
        }
        insert contactsList;

        AccountSwitcherImpl impl = new AccountSwitcherImpl();
        impl.getAndSort();

        List<TypeClass> allContacts = impl.getAllContacts();
        Integer countPersonPublic = 5;
        Integer countPersonPrivate = 5;
        Integer countPremierPrivate = 0;
        for (TypeClass contact : allContacts) {
            if (contact.getContactType()  == 'Premier') {
                countPremierPrivate++;
            }
        }    
        countPersonPrivate -= countPremierPrivate;

        AccountSwitcherImpl.DataResult result = impl.switchAccount();

        System.assertEquals(countPersonPublic, result.changedPublicContacts.size());
        System.assertEquals(countPersonPrivate, result.changedPrivateContacts.size());
        System.assertEquals(countPremierPrivate, result.nonChangedPrivateContacts.size());
    }

    private static List<Contact> createContacts(Integer howMany) {
        List<Contact> contactsList = new List<Contact>();
        for (Integer i = 0; i < howMany; i++) {
            Contact contact = new Contact(
                LastName = 'Test' + i,
                FirstName = 'Test' + i
            );
            contactsList.add(contact);
        }
        return contactsList;
    }
}