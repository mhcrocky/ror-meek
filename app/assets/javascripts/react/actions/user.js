import { actionName } from '../helpers/actions'

actionName.setScope('user')

export const user = {
  reset: actionName('reset'),
  update: actionName('update'),
  logout: actionName.async('logout'),
  signup: actionName.async('signup')
}