import { LightningElement } from 'lwc';
import getObjectsList from '@salesforce/apex/SOQLService.getObjectsList';
import getFieldsList from '@salesforce/apex/SOQLService.getFieldsList';
import executeQuery from '@salesforce/apex/SOQLService.executeQuery';

export default class SOQLBuilber extends LightningElement {
    showFields = false;
    showCondition = false;
    showLimitOffset = false;
    showQuery = false;
    showQueryResult = false;

    queryString = '';
    selectedObject = '';
    _selectedFields = [];
    valueConditionField = '';
    valueConditionOperator = '';
    conditionValue = '';
    limitValue = 100; 
    offsetValue = 0;

    objectsList = [];
    fieldsToChoose = [];

    data = null;
    error = '';

    connectedCallback() {
        this.loadObjectsList();
    }

    async loadObjectsList() {
        try {
            const result = await getObjectsList();
            this.objectsList = result.map(obj => ({ label: obj, value: obj }));
        } catch (error) {
            this.error = error;
        }
    }

    handleChangeObject(event) {
        this.selectedObject = event.detail.value;
        this.loadFieldsList();
        this.showFields = true;
    }

    async loadFieldsList() {
        try {
            const fieldsList = await getFieldsList({ objectName: this.selectedObject });
            this.fieldsToChoose = fieldsList.map(field => ({ label: field, value: field }));
        } catch (error) {
            this.error = error;
        }
    }

    get selectedFields() {
        return this._selectedFields.length ? this._selectedFields : 'none';
    }

    handleChangeFields(event) {
        this._selectedFields = event.detail.value;
        this.showCondition = true;
    }

    get conditionOperatorsList() {
        return [
            { label: 'Equals', value: '=' },
            { label: 'Not Equals', value: '!=' },
            { label: 'Greater Than', value: '>' },
            { label: 'Less Than', value: '<' },
            { label: 'LIKE', value: 'LIKE' },
            // { label: '!', value: '!' }
        ];
    }

    handleChangeConditionField(event) {
        this.valueConditionField = event.detail.value;
        this.isShowLimitOffsetAndQuery();
    }

    handleChangeConditionOperator(event) {
        this.valueConditionOperator = event.detail.value;
        this.isShowLimitOffsetAndQuery();
    }
    
    handleChangeConditionValue(event) {
        this.conditionValue = event.target.value;
        this.isShowLimitOffsetAndQuery();
    }

    isShowLimitOffsetAndQuery() {
        if (this.valueConditionField && this.valueConditionOperator && this.conditionValue) {
            this.showLimitOffset = true;
            this.generateQuery();
        }
    }

    handleChangeLimitValue(event) {
        this.limitValue = parseInt(event.target.value, 10) || 100;
        this.generateQuery();
    }
    
    handleChangOffsetValue(event) {
        this.offsetValue = parseInt(event.target.value, 10) || 0;
        this.generateQuery();
    }

    generateQuery() {
        if (!this.selectedObject || this.selectedFields === 'none') return;

        const fields = this.selectedFields.join(', ');
        let query = `SELECT ${fields} FROM ${this.selectedObject}`;

        if (this.valueConditionField && this.valueConditionOperator && this.conditionValue) {
            query += ` WHERE ${this.valueConditionField} ${this.valueConditionOperator} ${this.conditionValue}`;
        }

        query += ` LIMIT ${this.limitValue}`;
        if (this.offsetValue > 0) {
            query += ` OFFSET ${this.offsetValue}`;
        }
        
        this.queryString = query;
        this.showQuery = true;
    }

    async loadQuery() {
        try {
            const result = await executeQuery({ soqlQuery: this.queryString });
            this.data = JSON.parse(JSON.stringify(result));
            this.showQueryResult = true;
        } catch (error) {
            this.error = error;
        }
    }
}