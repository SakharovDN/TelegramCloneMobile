import { Model, DataTypes } from "sequelize";
import crypto from 'crypto';

class User extends Model { }

const defineModel = (sequelize) => {
    User.init({
        id: {
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
            primaryKey: true
        },
        email: {
            type: DataTypes.STRING(150),
            unique: true,
            allowNull: false
        },
        password: {
            type: DataTypes.STRING,
            allowNull: false
        },
        name: {
            type: DataTypes.STRING(100),
            allowNull: false
        },
        surname: {
            type: DataTypes.STRING(100),
            allowNull: false
        },
        verified: {
            type: DataTypes.BOOLEAN,
            allowNull: false,
            defaultValue: false
        }
    }, { sequelize, tableName: "users" })

    return () => {
        User.addHook('beforeCreate', async (user) => {
            const salt = crypto.randomBytes(16).toString('hex');
            const hash = crypto.pbkdf2Sync(user.password, salt, 1000, 64, 'sha512').toString('hex');
            user.password = salt + ':' + hash;
        })
    }
}

export default { Model: User, defineModel };
