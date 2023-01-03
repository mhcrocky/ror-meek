import { actionName } from '../helpers/actions'

actionName.setScope('player')

export const player = {
  play: actionName('play'),
  update: actionName.async('update')
}