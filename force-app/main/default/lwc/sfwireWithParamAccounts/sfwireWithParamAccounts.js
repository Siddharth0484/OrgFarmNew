import { LightningElement, wire } from 'lwc';
import lstAccnts from '@salesforce/apex/LWC_helper.getListofCollege';
export default class SfwireWithParamAccounts extends LightningElement {

    varData;
    varError;
    accName = 'sid';


        @wire(lstAccnts, { accName: '$accName' })
        accnt({ data, error }) {
       // handleMessage({ data, error }) {
            if (data) {
                console.log('@@ACCOUNT DATA: ', data);
               // this.varData = JSON.stringify(data);
                this.varData = data;
            } else if (error) {
                console.log('Error: ', error);
               // this.varError= error;
                const myJSON = JSON.stringify(error);
                this.varError = myJSON;
                console.log('@@Error: ', myJSON);
            }
        }
    }