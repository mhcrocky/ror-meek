import { actionName } from '../helpers/actions'

actionName.setScope('router')

export const router = {
  updatePage: actionName('update page'),
  setParams: actionName('set params'),
  go: actionName('go')
}