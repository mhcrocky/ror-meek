import { actionName } from '../helpers/actions'

actionName.setScope('trends')

export const trends = {
  update: actionName('update'),
  load: actionName.async('load')
}