import { Strategy as JwtStrategy, ExtractJwt } from 'passport-jwt';
import jwt from 'jsonwebtoken';
import _ from 'lodash';

export const PassportJwt = () => {
    const options = {
        jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
        secretOrKey: process.env.TOKEN_SECRET
    }

    return new JwtStrategy(options, async (token, done) => {
        // TODO: check user exist
        return done(null, _.omit(token, 'iat', 'exp'));
        // return done(null, false);
    })
}

class TokenService {
    static generateToken(payload) {
        try {
            const expiresIn = process.env.TOKEN_EXPIRE || '180d';
            return jwt.sign(payload, process.env.TOKEN_SECRET, { expiresIn });
        }
        catch (ex) {
            throw new Error(ex.message);
        }
    }

    static checkToken(token) {
        try {
            return jwt.verify(token, process.env.TOKEN_SECRET);
        }
        catch (ex) {
            throw new Error(ex.message);
        }
    }
}

export default TokenService;
