import { LightningElement, api } from 'lwc';

export default class DatatableWithPagination extends LightningElement {
    _allRecords = [];
    visibleData;
    
    @api
    set allRecords(value) {
        this._allRecords = value || [];
    }

    get allRecords() {
        return this._allRecords;
    }

    get columns() {
        if (!this.allRecords || this.allRecords.length === 0) return [];
        
        return Object.keys(this.allRecords[0]).map(fieldName => ({
            label: fieldName,
            fieldName: fieldName
        }));
    }

    updateRecordsHandler(event) {
        this.visibleData = event.detail.records;
    }
}