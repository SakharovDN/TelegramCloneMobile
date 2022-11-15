import crypto from 'crypto';
import passport from 'passport';

export const comparePassword = (password, hashedPassword) => {
    const [salt, currentPassword] = hashedPassword.split(':');
    const hash = crypto.pbkdf2Sync(password, salt, 1000, 64, 'sha512').toString('hex');
    return currentPassword === hash;
}

export const useGuard = (strategy = 'jwt', options = {}) => {
    return (req, res, next) => passport.authenticate(strategy, { session: false, ...options }, (_, payload) => {
        if (!payload) return res.status(401).json({ message: 'You need authorization' });
        req.user = payload;
        return next();
    })(req, res, next)
}