import { actionName } from '../helpers/actions'

actionName.setScope('search')

export const search = {
  updateQuery: actionName('update query'),
  updateResult: actionName('update result'),
  clearResult: actionName('clear result'),
  searchAll: actionName.async('search all'),
  loadMore: actionName.async('load more')
}