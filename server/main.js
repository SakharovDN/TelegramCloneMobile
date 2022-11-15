import dotenv from 'dotenv';
import { Sequelize } from "sequelize";
import Server from './core/server.js';
import Routing from './core/routes.js';
import DatabaseAdapter from './core/database.js';
import MailModule from './core/mail.js';
import ProfileModels from "#auth/models/_index.js";
import PassportModule from './core/passport.js';
import AuthRouter from "#auth/router.js";
import { PassportJwt } from "#auth/services/jwt-service.js";

dotenv.config({ path: `.env.${process.env.NODE_ENV}` });
const APP_PORT = process.env.PORT || 5000;

new Server(
    APP_PORT,
    [
        new MailModule({ user: process.env.MAIL_USER, pass: process.env.MAIL_PASS }),
        new DatabaseAdapter(new Sequelize(
            process.env.DB_NAME,
            process.env.DB_USER,
            process.env.DB_PASS,
            {
                dialect: 'postgres',
                host: process.env.DB_HOST || 'localhost',
                port: process.env.DB_PORT || 5432,
                logging: false
            }
        )).registerModels([...ProfileModels()]),
        new Routing([{ router: AuthRouter, prefix: "/auth" }]),
        new PassportModule([
            { name: "jwt", strategy: PassportJwt() }
        ])
    ]
)
    .initServices()
    .then(server => server.run(() => console.log('Server started on port %s', APP_PORT)));
