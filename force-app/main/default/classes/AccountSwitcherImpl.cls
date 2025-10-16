public class AccountSwitcherImpl implements AccountSwitcher {
        
    public class DataResult {
        public List<PrivateContactClass> changedPrivateContacts = new List<PrivateContactClass>();
        public List<PublicContactClass> changedPublicContacts = new List<PublicContactClass>();
        public List<PrivateContactClass> nonChangedPrivateContacts = new List<PrivateContactClass>();
    }
    
    private List<TypeClass> allContacts = new List<TypeClass>();

    public List<TypeClass> getAllContacts() {
        return allContacts;
    }

    public void getAndSort() {
        List<Contact> contactsList = [SELECt Id, Amount__c FROM Contact];
        for (Contact contact : contactsList) {
            if (contact.Amount__c > 10000) {
                Integer cardNumber = randomSixDigitalNumber();
                PrivateContactClass privateContact = new PrivateContactClass(cardNumber, contact);
                allContacts.add(privateContact);
            } else {
                Integer volunteerNumber = randomSixDigitalNumber();
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

        Integer size = Math.min(privateContactsList.size(), publicContactsList.size());
        DataResult result = new DataResult();
        List<Contact> contactToUpdate = new List<Contact>();

        for (Integer i = 0; i < size; i++) {
            if (privateContactsList[i].getContactType() == 'Premier') {
                result.nonChangedPrivateContacts.add(privateContactsList[i]);
            } else {
                Contact privateContactRecord = privateContactsList[i].getContactRecord();
                Contact publicContactRecord = publicContactsList[i].getContactRecord();
                Id switchId = privateContactRecord.Id;
                privateContactRecord.Id = publicContactRecord.Id;
                publicContactRecord.Id = switchId;
                result.changedPrivateContacts.add(privateContactsList[i]);
                result.changedPublicContacts.add(publicContactsList[i]);
                contactToUpdate.add(privateContactRecord);
                contactToUpdate.add(publicContactRecord);
            }
        }

        if (!contactToUpdate.isEmpty()) {
            update contactToUpdate;
        }

        return result;
    }

    private Integer randomSixDigitalNumber() {
        return Math.round((Math.random() * (900000) + 100000));
    }
}