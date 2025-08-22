import { LightningElement, api } from 'lwc';
import convertUsdToInr from '@salesforce/apex/CurrencyRateController.convertUsdToInr';
import updateCollegeBudget from '@salesforce/apex/CurrencyRateController.updateCollegeBudget';

export default class UsdToInrConverter extends LightningElement {
    @api recordId; // College record ID
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
                this.updateCollegeBudget(); // Call method to update the College record
            })
            .catch(error => {
                this.error = error.body.message;
                this.hasError = true;
                this.hasResult = false;
            });
    }

    updateCollegeBudget() {
        if (this.recordId && this.convertedAmount) {
            updateCollegeBudget({ collegeId: this.recordId, totalBudget: this.convertedAmount })
                .then(() => {
                    console.log('College budget updated successfully');
                     window.location.reload();
                })
                .catch(error => {
                    this.error = error.body.message;
                    this.hasError = true;
                });
        }
    }
}