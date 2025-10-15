public class PrivateContactClass extends TypeClass {
    private Integer cardNumber;
    private Contact contactRecord;

    public PrivateContactClass(Integer cardNumber, Contact contactRecord) {
        this.cardNumber = cardNumber;
        this.contactRecord = contactRecord;
        this.contactType = getContactType(cardNumber);
    }

    public Integer getCardNumber() {
        return CardNumber;
    }
    public Contact getContactRecord() {
        return ContactRecord;
    }

    private String getContactType(Integer cardNumber) {
        Integer sameNumber = 0;

        List<Integer> cartNumberLists = new List<Integer>();
        for (Integer i = 0; i < 6; i++) {
            cartNumberLists.add(cardNumber -  cardNumber / 10 * 10);
            cardNumber = cardNumber / 10;
        }

        for (Integer i = 0; i < 4; i++) {
            Integer numberToCheck = cartNumberLists[i];
            for (Integer j = i + 1; j < 6; j++) {
                if (numberToCheck == cartNumberLists[j]) {
                    sameNumber++;
                }
            }
            if (sameNumber >= 3) {
                return 'Premier';
            }            
        }
        return 'Person';
    }
}