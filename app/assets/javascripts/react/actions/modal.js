import { actionName } from '../helpers/actions'

actionName.setScope('modal')

export const modal = {
  show: actionName('show'),
  close: actionName('close')
}