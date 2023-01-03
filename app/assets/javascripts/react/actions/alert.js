import { actionName } from '../helpers/actions'

actionName.setScope('alert')

export const alert = {
  success: actionName('success'),
  error: actionName('error')
}