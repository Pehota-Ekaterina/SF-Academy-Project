public class NotifierDecorator implements INotifier{
    private List<INotifier> notifiers = new List<INotifier>();
    public NotifierDecorator(List<INotifier> notifiers) {
        this.notifiers = notifiers; 
    }

    public void send(Task__c task) {
        for(INotifier notifier : notifiers) {
            notifier.send(task);
        }
    }
}