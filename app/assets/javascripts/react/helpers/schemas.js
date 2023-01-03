import * as yup from 'yup'
import { ERRORS } from '../config/strings'

const defaultStr = yup.string().default('')

export const feedbackSchema = yup.object({
  name: defaultStr.required(),
  email: defaultStr.email().required(),
  body: defaultStr.required()
})

export const signupSchema = yup.object({
  email: defaultStr.email().required(),
  password: defaultStr.required(),
  password_confirmation: defaultStr.oneOf([yup.ref('password'), ''], ERRORS.PASSWORD_CONFIRMATION),
  first_name: defaultStr.required(),
  last_name: defaultStr.required()
})
