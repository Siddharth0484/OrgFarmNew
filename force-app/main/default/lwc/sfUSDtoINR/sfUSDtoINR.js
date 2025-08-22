import { LightningElement } from 'lwc';
import convertUsdToInr from '@salesforce/apex/CurrencyRateController.convertUsdToInr';

export default class UsdToInrConverter extends LightningElement {
    usdAmount;
    convertedAmount;
    error;
    hasResult = false;
    hasError = false;

    handleChange(event) {
        this.usdAmount = event.target.value;
    }

    handleConvert() {
        if (!this.usdAmount || isNaN(this.usdAmount)) {
            this.error = 'Please enter a valid number';
            this.convertedAmount = undefined;
            this.hasError = true;
            this.hasResult = false;
            return;
        }
        
        convertUsdToInr({ amount: parseFloat(this.usdAmount) })
            .then(result => {
                this.convertedAmount = result.toFixed(2);
                this.error = undefined;
                this.hasResult = true;
                this.hasError = false;
            })
            .catch(error => {
                this.error = error.body.message;
                this.convertedAmount = undefined;
                this.hasError = true;
                this.hasResult = false;
            });
    }
}