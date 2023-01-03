import { actionName } from '../helpers/actions'

actionName.setScope('recent')

export const recent = {
  update: actionName('update'),
  load: actionName.async('load')
}
