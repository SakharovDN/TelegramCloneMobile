const errorParser = (errors) => errors.inner.map(e => {
    return {
        type: e.type,
        stack: e.path.split('.'),
        message: e.message
    }
})

class Validator {
    static validate = (schema, payloadKey = 'body', options = {}) => async (req, res, next) => {
        const data = req[payloadKey];
        options = { abortEarly: false, ...options };
        try {
            await schema.validate(data, options);
            next();
        } catch (ex) {
            const errors = errorParser(ex);
            return res.status(422).json({ errors });
        }
    }
}

export default Validator;