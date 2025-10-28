public class SMSNotifier implements INotifier {
    public void send(Task__c task) {
        System.debug('SMS message sent');
    } 
}