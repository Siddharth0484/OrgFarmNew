import { LightningElement } from 'lwc';

export default class SfWorld extends LightningElement {

    varString = 'Sample Name';
    varData;

    handleClick() {
        
         this.varData = this.varString;
         alert('the entered value is ' + this.varData);
         console.log('the entered value is '+ this.varString);


    }

    handleNameChange(event) {
        // Example: update cValue when input changes
        this.varString = event.target.value;
        //alert('the entered value is '+ this.varString);

    
    }
}