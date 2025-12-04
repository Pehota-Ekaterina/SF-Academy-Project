import { LightningElement, wire} from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getProducts from '@salesforce/apex/ProductTableController.getProducts';
import deleteProduct from '@salesforce/apex/ProductTableController.deleteProduct';

export default class ProductTable extends LightningElement {
    visibleProducts;
    listProductsDefault;
    listProducts;
    listProductsRefresh;
    sortDirection = 'asc';
    sortField;
    error;
    showForm = false;
    editForm = false;
    search = '';
    productId =undefined;
    isLoaded = false;

    @wire(getProducts, {searchString: '$search'})
    wiredProducts(value) {
        this.listProductsRefresh = value;
        const { data, error} = value;
        if (data) {
            this.listProductsDefault = data;
            this.listProducts = [...data];
            this.isLoaded = true;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.listProductsDefault = undefined;
        }
    }

    updateProductsHandler(event){
        this.visibleProducts = event.detail.records;
    }

    handleSort(event) {
        this.isLoaded = false;
        const newSortField = event.currentTarget.dataset.field;
        let direction = this.sortDirection;

        if (this.sortField === newSortField) { 
            if (direction === 'desc') {
                direction = 'asc';
            } else {
                direction = 'desc';
            }
        } else {
            direction = 'asc';
        }
        this.sortData(newSortField, direction);
        this.sortField = newSortField;
        this.sortDirection = direction;
    }

    sortData(sortField, direction) {
        const data = [...this.listProductsDefault];

        data.sort((a, b) => {
            let valueA = a[sortField];
            let valueB = b[sortField];

            if (sortField === 'Name') {
                valueA = valueA.toLowerCase();
                valueB = valueB.toLowerCase();
            }

            if (sortField === 'ReleaseDate__c') {
                valueA = new Date(valueA);
                valueB = new Date(valueB);
            }

            if (direction === 'asc') {
                return valueA > valueB ? 1 : -1;
            } else {
                return valueA < valueB ? 1 : -1;
            }
        });
        
        this.listProducts = data;
        this.isLoaded = true;
    }

    handleCancelClick() {
        this.showForm = false;
    }

    handleSaveSuccess() {
        this.isLoaded = false;
        refreshApex(this.listProductsRefresh);
        this.showForm = false;
    }

    handleDeleteClick(event) {
        this.isLoaded = false;
        const productId = event.currentTarget.dataset.productId;

        deleteProduct({ productId: productId})
            .then(() => {
               refreshApex(this.listProductsRefresh);
            })
            .catch(error => {
            this.error = error;
            });
    }

    handleSearchChange(event) {
        this.isLoaded = false;
        this.search = event.target.value;
    }

    handleEditClick(event) {
        this.productId = event.currentTarget.dataset.productId;
        this.editForm = true;
    }

    handleCancelEditClick() {
        this.editForm = false;
    }

    handleEditSuccess() {
        this.isLoaded = false;
        refreshApex(this.listProductsRefresh);
        this.editForm = false;
    }

    handleNewClick() {
        this.showForm = true;
    }
}