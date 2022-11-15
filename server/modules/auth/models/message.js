import { Model, DataTypes } from "sequelize";
import { Model as ModelAdapter } from '#core/database.js';
import User from "./user.js"
import Chat from "./chat.js"

class Message extends Model { }

const defineModel = (sequelize) => {
    Message.init({
        body: {
            type: DataTypes.STRING(500),
            allowNull: false
        },
    }, { sequelize, tableName: 'messages' })

    return () => {
        Message.belongsTo(ModelAdapter(Chat), { foreignKey: 'chatId' });
        Message.belongsTo(ModelAdapter(User), { foreignKey: 'senderId' });
    }
}

export default { Model: Message, defineModel }