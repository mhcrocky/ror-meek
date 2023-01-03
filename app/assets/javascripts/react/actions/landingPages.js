import { actionName } from '../helpers/actions'

actionName.setScope('landing pages')

export const landingPages = {
  load: actionName.async('load')
}
