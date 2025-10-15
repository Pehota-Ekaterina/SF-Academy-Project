public class AccountSwitcherImpl implements AccountSwitcher {
    private List<TypeClass> allContacts = new List<TypeClass>(); 

    public void getAndSort() {
        List<Contact> contactsList = [SELECt Id FROM Contact];
        for (Contact contact : contactsList) {
            if (contact.Amount__c > 10000) {
                Integer cardNumber = randomNumber();
                PrivateContactClass privateContact = new PrivateContactClass(cardNumber, contact);
                allContacts.add(privateContact);
            } else {
                Integer volunteerNumber = randomNumber();
                PublicContactClass publicContact = new PublicContactClass(volunteerNumber, contact);
                allContacts.add(publicContact);
            }
        }
    }

   public DataResult switchAccount() {
        List<PrivateContactClass> privateContactsList = new List<PrivateContactClass>();
        List<PublicContactClass> publicContactsList = new List<PublicContactClass>();
        for (TypeClass contact : allContacts) {
            if (contact instanceof PrivateContactClass) {
                privateContactsList.add((PrivateContactClass)contact);
            } else if (contact instanceof PublicContactClass) {
                publicContactsList.add((PublicContactClass)contact);
            }
        }

        return new DataResult();
    }

    private Integer randomNumber() {
        return Math.round((Math.random() * (900000) + 100000));
    }
}