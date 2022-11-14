import { BaseModule } from "./server.js";

export const Model = (model) => model.Model;

class DatabaseAdapter extends BaseModule {
    constructor(connection) {
        super();
        this.connection = connection;
        this.models = [];
    }

    registerModels(models = []) {
        this.models = models;
        return this;
    }

    async #isConnect() {
        await this.connection.authenticate();
    }

    async #initModels() {
        const keySetter = [];
        this.models.forEach(({ defineModel }) => keySetter.push(defineModel(this.connection)));
        keySetter.forEach(exec => exec && exec(this.connection));
        await this.connection.sync({ alter: true });
    }

    async hanlder(_) {
        try {
            await this.#isConnect();
            console.log('Connection to database is established');
        } catch (ex) {
            console.error('DataBase host is unreachable');
            console.log(ex.message);
            process.exit(1);
        }
    }

    async afterHandler(_) {
        await this.#initModels();
        console.log('Models loaded');
    }
}

export default DatabaseAdapter;
