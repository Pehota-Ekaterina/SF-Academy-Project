public with sharing class Warehouse {
    public static  List<Warehouse__c> getAllWarehouses() {
        return [SELECT Id, Name, Number_of_books__c, (SELECT Name FROM Books__r) FROM Warehouse__c];
    }

    public static void setNumberOfBooks() {
        List<Warehouse__c> warehousesToUpdate = getAllWarehouses();
        calculateNumberOfBooks(warehousesToUpdate);
        update warehousesToUpdate;
    }

    private static void calculateNumberOfBooks(List<Warehouse__c> warehousesList) {
        for (Warehouse__c warehouse : warehousesList) {
            if (warehouse.Number_of_books__c == NULL) {
                warehouse.Number_of_books__c = warehouse.Books__r.size();
            }
        }
    }
}