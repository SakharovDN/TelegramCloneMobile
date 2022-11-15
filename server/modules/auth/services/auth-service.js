import { Model } from "#core/database.js";
import UserModel from "../models/user.js"
import { comparePassword } from "./guards.js"
import TokenService from "./jwt-service.js"
import MailService from "../../mail/mail-service.js";
import _ from 'lodash'

class AuthService {
    #mailService;
    constructor() {
        this.#mailService = new MailService();
    }

    async createUser(user) {
        const { id, email } = await Model(UserModel).build(user).save();
        this.#mailService.sendTo(email).activate(`${process.env.APP_DOMAIN}/auth/activate/${id}`);
    }

    activate = async (id) => await Model(UserModel).update({ verified: true }, { where: { id } });

    async signIn(email, password) {
        const user = await Model(UserModel).findOne({ where: { email }, raw: true, nest: true });

        if (!user || !comparePassword(password, user.password)) return [null, null, true, false];
        if (!user.verified) return [null, null, false, true];

        const token = TokenService.generateToken(_.pick(user, 'id'));
        return [token, _.omit(user, 'password', 'verified', 'createdAt', 'updatedAt'), false, false];
    }
}

export default AuthService;