import { actionName } from '../helpers/actions'

actionName.setScope('feedback')

export const feedback = {
  update: actionName('update'),
  reset: actionName('reset'),
  save: actionName.async('save')
}