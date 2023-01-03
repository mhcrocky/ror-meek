import { actionName } from '../helpers/actions'

actionName.setScope('static pages')

export const staticPages = {
  load: actionName.async('load')
}
