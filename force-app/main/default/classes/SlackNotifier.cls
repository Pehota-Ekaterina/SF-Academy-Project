public class SlackNotifier implements INotifier {
    public void send(Task__c task) {
        System.debug('Slack message sent');
    } 
}