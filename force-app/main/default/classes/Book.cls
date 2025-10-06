public with sharing class Book {
    public static List< Book__c> getAllBooks() {
        return [SELECT Id, Name, Warehouse__c, Serial_number__c FROM Book__c];
    }

    public static void setSerialNumberForBooks() {
        List<Book__c> booksToUpdate = getAllBooks();
        createSerialNumbers(booksToUpdate);
        update booksToUpdate;
    } 

    private static void createSerialNumbers(List<Book__c> booksList) {
        for (Book__c book : booksList) {
            if (book.Serial_number__c != NULL) {
                continue;
            }

            String numberPart;
            Integer numberPartLength = 5;
            String letterPart;
            Integer letterPartLength = 3;

            for (String symbol : book.Id) {
                if (numberPartLength > 0 && isNumber(symbol)) {
                    numberPart += symbol;
                    numberPartLength--;
                } else if (letterPartLength > 0) {
                    letterPart += symbol;
                    letterPartLength--;
                }
            }

            book.Serial_number__c = letterPart.substring(0, 2) + '-' + numberPart.substring(0, 1) + '-' + letterPart.substrinf(2) + '-' + numberPart.substring(1);
        }
    }

    private static Boolean isNumber(String symbol) {
        try {
            Integer.valueOf(symbol);
            return true;
        } catch (System.TypeException e) {
            return false;
        }
    }
}