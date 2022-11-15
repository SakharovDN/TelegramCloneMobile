import { sendEmail } from "#core/mail.js";

class MailService {
    sendTo(address) {
        this.addressTo = address;
        return this;
    }

    async activate(link) {
        const template = {
            template: "activate",
            context: { link }
        }
        await sendEmail(template, { subject: "Регистрация в TelegramClone", to: this.addressTo });
    }
}

export default MailService;
