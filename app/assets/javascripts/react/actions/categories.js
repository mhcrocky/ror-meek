import { actionName } from '../helpers/actions'

actionName.setScope('categories')

export const categories = {
  updateAll: actionName('update all'),
  updateOne: actionName('update one'),
  loadAll: actionName.async('load all'),
  loadOne: actionName.async('load one')
}