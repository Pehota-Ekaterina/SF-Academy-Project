import { LightningElement, track } from 'lwc';
import searchContactsByAccount from '@salesforce/apex/AccountContactService.searchContactsByAccount';

export default class SectionThirteen extends LightningElement {
    @track timeMinsk = '';
    @track timeWarsaw = '';
    @track timeLondon = '';

    intervalId;

    connectedCallback() {
        this.updateTime();

        this.intervalId = setInterval(() => {
            this.updateTime();
        }, 1000);
    }

    disconnectedCallback() {
        if (this.intervalId) {
            clearInterval(this.intervalId);
            this.intervalId = null;
        }
    }

    updateTime() {
        const now = new Date();

        this.timeMinsk = now.toLocaleString('en-GB', {
            timeZone: 'Europe/Minsk',
            weekday: 'long',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: true
        });

        this.timeWarsaw = now.toLocaleString('en-GB', {
            timeZone: 'Europe/Warsaw',
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: false
        });

        this.timeLondon = now.toLocaleString('en-GB', {
            timeZone: 'Europe/London',
            dateStyle: 'medium',
            timeStyle: 'medium'
        });
    }

    handleDefaultButton() {
        this.changeBackgroundColor('aliceblue');
    }
    
    handleBlueButton() {
        this.changeBackgroundColor('rgb(78, 137, 192)');
    }

    handleGreyButton() {
        this.changeBackgroundColor('rgb(153, 153, 153)');
    }

    handleWhiteButton() {
        this.changeBackgroundColor('white');
    }

    changeBackgroundColor(color) {
        const itemsTimeZone = this.template.querySelectorAll('.time-zone-item');
        itemsTimeZone.forEach(item => {
            item.style.backgroundColor = color;
        });
    }
    
    @track resultCoin = '   ';
    @track isTossing = false;

    flipCoin() {
        this.isTossing = true;
        this.resultCoin = '';

        setTimeout(() => {
            this.resultCoin = Math.random() <0.5 ? 'heads' : 'tails';
            this.isTossing = false;
        }, 3000);
    }

    @track resultComper = '';

    comperObjects() {

        let obj1;
        let obj2;

        try {
            obj1 = JSON.parse(this.template.querySelector('.object1').value);
        } catch (e) {
            this.resultComper = 'Invalid JSON in Object 1';
            return;
        }

        try {
            obj2 = JSON.parse(this.template.querySelector('.object2').value);
        } catch (e) {
            this.resultComper = 'Invalid JSON in Object 2';
            return;
        }

        const areEqual = this.isObjectSubset(obj1, obj2);

        this.resultComper = areEqual
            ? 'Objects are equal'
            : 'Objects are not equal';
    }

    isObjectSubset(obj1, obj2) {
        for (let key in obj2) {

            const val1 = obj1[key];
            const val2 = obj2[key];

            if (!(key in obj1)) return false;

            if (typeof val1 === 'object' && val1 !== null &&
                typeof val2 === 'object' && val2 !== null) {
                if (!this.isObjectSubset(val1, val2)) return false;
            } else if (val1 !== val2) {
                return false;
            }
        }
        return true;
    }

    @track resultCheckPhoneNumber = '';

    checkPhoneNumber() {
        this.resultCheckPhoneNumber = '';
        setTimeout(() => {
            const phoneNumber = this.template.querySelector('.input-phone').value;
            const phoneRegex = /^(\+?\d{3}[-\s]?\(?(\d{2})\)?[-\s]?(\d{3})[-\s]?(\d{2})[-\s]?(\d{2}))|(\d{3}\(\d{2}\)\d{7})$/;
            const result = phoneRegex.test(phoneNumber.trim());
            this.resultCheckPhoneNumber = result ? 'Valid' : 'Invalid';
        }, 1000); 
    }

    object = {};
    @track objectJson = '{}';

    @track attributeNameNew = '';
    @track attributeValueNew = '';
    @track getAttributeName = '';
    
    @track resultPutNewAttr = '';
    @track valueResult = '';

    handleAttributeNewNameChange(event) {
        this.attributeNameNew = event.target.value;
    }
    handleAttributeValueChange(event) {
        this.attributeValueNew = event.target.value;
    }
    putNewAttribute() {
        const name = this.attributeNameNew.trim();

        if (!name) {
            this.resultPutNewAttr = 'name of attribute musnt be empty';
            return;
        }

        let value;
        try {
            value = JSON.parse(this.attributeValueNew);
        } catch (e) {
            value = this.attributeValueNew;
        }

        this.object[name] = value;
        this.resultPutNewAttr = `Name of attribute "${name}" added with value "${value}"`;
        
        this.updateObjectDisplay();
        this.attributeNameNew = '';
        this.attributeValueNew = '';
    }

    handleGetAttributeNameChange(event) {
        this.getAttributeName = event.target.value;
    }
    getAttributeValue() {
        const name = this.getAttributeName.trim();

        if (!name) {
            this.valueResult = 'name of attribute musnt be empty';
            return;
        }

        if (this.object.hasOwnProperty(name)) {
            this.valueResult = `${name}: ${JSON.stringify(this.object[name])}`;
        } else {
            this.valueResult = 'does not exist';
        }

        this.getAttributeName = '';
    }

    updateObjectDisplay() {
        this.objectJson = JSON.stringify(this.object, null, 2);
    }

    @track accountName = '';
    @track findResult = null;
    @track contactsJson = '';

    handleAccountNameChange(event) {
        this.accountName = event.target.value;
    }

    async findContacts() {
        const name = this.accountName.trim();
        if (!name) {
            alert('name musnt be empty');
            return;
        }

        try {
            const data = await searchContactsByAccount({ accountName: name });

            this.contactsJson = JSON.stringify(data, null, 2);
            this.findResult = true;
        } catch (error) {
            this.findResult = false;
            this.contactsJson = '';
            alert(error.body.message || 'Searching error');
        }
    }
}