import { Model, DataTypes } from "sequelize";
import { Model as ModelAdapter } from '#core/database.js';
import User from "./user.js"
import Message from "./message.js"

class Chat extends Model { }

const defineModel = (sequelize) => {
    Chat.init({
        title: {
            type: DataTypes.STRING(20),
            allowNull: true
        }

    }, { sequelize, tableName: 'chats' })

    return () => {
        Chat.belongsToMany(ModelAdapter(User), { through: 'user_chats' });
        Chat.hasMany(ModelAdapter(Message), { foreignKey: 'chatId' });
    }
}

export default { Model: Chat, defineModel }