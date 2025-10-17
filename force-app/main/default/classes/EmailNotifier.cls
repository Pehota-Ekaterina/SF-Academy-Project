public class EmailNotifier implements INotifier {
    public void send(Task__c task) {
        System.debug('Email sent');
    }    
}