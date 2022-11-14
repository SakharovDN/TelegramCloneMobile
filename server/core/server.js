import express from 'express'
import cors from 'cors';
import timeout from "connect-timeout";

export class BaseModule {
    async beforeHandler(app) { }
    async handler(app) { }
    async afterHandler(app) { }

    async resolve(app) {
        await this.beforeHandler(app);
        await this.handler(app);
        await this.afterHandler(app);
    }
}

class Server {
    constructor(PORT, services) {
        this.port = PORT;
        this.services = services;
        this.app = express();
        this.app.use(cors());
        this.app.use(express.json());
        this.app.use(timeout('15m'));
    }
}

Server.prototype.initServices = async function () {
    if (!this.services.length) process.exit(1);
    for (const service of this.services) {
        await service.resolve(this.app);
    }
    console.log('Services loaded');
    return Promise.resolve(this);
}

Server.prototype.run = function (callback) {
    this.app.listen(this.port, callback);
}

export default Server;