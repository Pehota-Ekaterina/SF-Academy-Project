import { LightningElement} from 'lwc';

import bicycle from '@salesforce/resourceUrl/bicycle';
import earphones from '@salesforce/resourceUrl/earphones';
import clock from '@salesforce/resourceUrl/clock';
import skateboard from '@salesforce/resourceUrl/skateboard';

export default class Carousel extends LightningElement {
    bicycleIMG = bicycle;
    earphonesIMG = earphones;
    clockIMG = clock;
    skateboardIMG = skateboard;
}