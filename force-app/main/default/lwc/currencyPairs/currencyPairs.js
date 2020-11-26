import { LightningElement, track } from 'lwc';
import getRates from "@salesforce/apex/RatesApi.getRates";

const columns = [
    { label: 'Base', fieldName: 'baseCurrency' },
    { label: 'Currency', fieldName: 'rateCurrency' },
    { label: 'Rate', fieldName: 'rate' }
];

export default class CurrencyPairs extends LightningElement {
    @track rates;

    columns = columns;

    async connectedCallback() {
        const data = await getRates();
        this.rates = data;
    }

    async handleUpdate() {
        const data = await getRates();
        this.rates = data;
    }
}