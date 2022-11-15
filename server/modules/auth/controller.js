import AuthService from "./services/auth-service.js";
import _ from 'lodash'

class AuthController {
    constructor() {
        this.authService = new AuthService();
    }

    signIn = () => async function (req, res) {
        console.log('hfghg');
        const { email, password } = req.body;
        const [token, user, notFound, notVeriefied, wrongPassword] = await this.authService.signIn(email, password);

        if (notFound) return res.status(404).json({ message: "Invalid email" });
        if (notVeriefied) return res.status(403).json({ message: "Account is not verified" });
        if (wrongPassword) return res.status(405).json({ message: "Wrong password" });
        return res.status(200).json({ user, token });
    }.bind(this)

    activate = () => async function (req, res) {
        try {
            const { id } = req.params;
            await this.authService.activate(id);
            return res.redirect('https://www.google.ru/'); //TODO: change redirect
        }
        catch (ex) {
            res.status(500).json({ message: "Oops, something went wrong" });
        }
    }.bind(this);

    signUp = () => async function (req, res) {
        try {
            await this.authService.createUser(_.pick(req.body, 'email', 'password', 'name', 'surname'));
            return res.status(201).send();
        }
        catch (ex) {
            console.log(ex.message);
            ex?.name == "SequelizeUniqueConstraintError" ?
                res.status(409).json({ message: "Email already exists" }) :
                res.status(500).json({ message: "Oops, something went wrong" });
        }
    }.bind(this)
}

export default new AuthController;
