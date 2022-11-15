import { Router } from "express";
import Validator from "#core/validation.js"
import AuthController from './controller.js';
import SignUpDto, { UUIDDto } from "./dto/sign-up-dto.js"
import SignInDto from "./dto/sign-in-dto.js"

const router = Router();

router.post('/signUp', Validator.validate(SignUpDto), AuthController.signUp());
router.post('/signIn', Validator.validate(SignInDto), AuthController.signIn());
router.get('/activate/:id', Validator.validate(UUIDDto, 'params'), AuthController.activate());

export default router;