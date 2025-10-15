public class PublicContactClass extends TypeClass {
    private Integer volunteerNumber;
    private Contact contactRecord;

    public PublicContactClass(Integer volunteerNumber, Contact contactRecord) {
        this.volunteerNumber = volunteerNumber;
        this.contactRecord = contactRecord;
        contactType = 'Person';
    }

    public Integer getVolunteerNumber() {
        return VolunteerNumber;
    }
    public Contact getContactRecord() {
        return ContactRecord;
    }
}