import { LightningElement, api } from 'lwc';

export default class Pagination extends LightningElement {

    currentPage = 1;
    totalPage = 0;
    totalRecords;
    visibleRecords;
    pageSize = 5;

    @api 
    set records(data) {
        if (data) {
            this.totalRecords = [...data];
            this.totalPage = Math.ceil(this.totalRecords.length / this.pageSize);
            this.currentPage = 1;
            this.updateRecords();
        }
    }

    get records() {
        return this.visibleRecords;
    }

    get disablePrevious(){ 
        return this.currentPage <= 1;
    }

    get disableNext(){ 
        return this.currentPage >= this.totalPage;
    }

    previousHandler() {
        if (this.currentPage > 1) {
            this.currentPage--;
            this.updateRecords();
        }
    }

    nextHandler() {
        if (this.currentPage < this.totalPage) {
            this.currentPage++;
            this.updateRecords();
        }
    }

    pageSizeHandler(event) {
        this.pageSize = Number(event.target.value);
        this.totalPage = Math.ceil(this.totalRecords.length / this.pageSize);
        this.currentPage = 1;
        this.updateRecords();
    }

    pageNumberHandler(event) {
        const page = Number(event.target.value);
        if (page < 1) {
            this.currentPage = 1;
        } else if (page > this.totalPage) {
            this.currentPage = this.totalPage;
        } else {
            this.currentPage = page;
        }
        this.updateRecords();
    }

    updateRecords() {
        const start = (this.currentPage - 1) * this.pageSize;
        const end = this.pageSize * this.currentPage;
        this.visibleRecords = this.totalRecords.slice(start, end);
        this.dispatchEvent(new CustomEvent('update',{ 
            detail:{ 
                records:this.visibleRecords
            }
        }));
    }
}