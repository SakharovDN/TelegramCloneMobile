import * as yup from 'yup';

export const UUIDDto = yup.object().shape({ id: yup.string().uuid().required() });

const SignUpDto = yup.object().shape({
    email: yup.string().required().email(),
    password: yup.string().required().min(8),
    name: yup.string().required(),
    surname: yup.string(),
});

export default SignUpDto;