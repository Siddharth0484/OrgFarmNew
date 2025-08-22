import { LightningElement } from 'lwc';

export default class SfAddition extends LightningElement {

    result;
    firstNumber = 0;
    secondNumber = 0;

    handlefirstNumber(event) {
        this.firstNumber = Number(event.target.value);
    }
    handlesecondNumber(event) {
        this.secondNumber = Number(event.target.value);
    }

    
    handleClick() {
          //this.result = parseFloat(this.firstNumber) + parseFloat(this.secondNumber);
           this.result = (this.firstNumber) + (this.secondNumber);
        alert('The result of addition is ' + this.result);
        console.log('The result of addition is ' + this.result);
    }
}