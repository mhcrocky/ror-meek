import { actionName } from '../helpers/actions'

actionName.setScope('backgrounds')

export const backgrounds = {
  update: actionName('update'),
  load: actionName.async('load')
}