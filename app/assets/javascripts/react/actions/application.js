import { actionName } from '../helpers/actions'

actionName.setScope('application')

export const application = {
  init: actionName('init')
}