import { BaseModule } from "./server.js";
import { Router as ExpressRouter } from "express";

class Routing extends BaseModule {
    #mainRouter;
    constructor(routes = []) {
        super();
        this.#mainRouter = ExpressRouter();
        routes.forEach(({ prefix, router }) => this.#mainRouter.use(prefix ?? '', router));
    }

    async handler(app) {
        app.use('/', this.#mainRouter);
        console.log('Routes loaded');
    }
}

export default Routing;