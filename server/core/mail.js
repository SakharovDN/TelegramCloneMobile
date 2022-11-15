import { BaseModule } from './server.js';
import nodemailer from 'nodemailer';
import hbs from 'nodemailer-express-handlebars';
import { resolve } from "path";

export let sendEmail;

const defaultOptions = {
    viewEngine: { defaultLayout: false },
    viewPath: resolve() + '/modules/mail/views/',
    extName: ".hbs"
}

class MailModule extends BaseModule {
    #tranport;
    #hbsOption
    constructor(auth, hbsOption = {}) {
        super();
        this.#hbsOption = { ...defaultOptions, ...hbsOption };
        this.#tranport = nodemailer.createTransport(
            { pool: true, service: "Gmail", auth },
            { from: "TelegramClone <deafsah@gmail.com>" }
        );
        sendEmail = this.makeSend.bind(this);
    }

    #makeHBS() {
        this.#tranport.use('compile', hbs(this.#hbsOption));
    }

    async makeSend(templateOptions, data) {
        this.#makeHBS();
        await this.#tranport.sendMail({ ...templateOptions, ...data });
    }
}

export default MailModule;