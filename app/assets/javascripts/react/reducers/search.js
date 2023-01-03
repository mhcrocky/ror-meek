import actions from '../actions'
import { SEARCHES } from '../config/strings'

export const initialState = {
  query: ''
}

for (let type of SEARCHES) {
  initialState[type] = { collection: [], nextPage: null }
}

export default (state = initialState, action) => {
  switch (action.type) {
  case actions.search.updateQuery:
    return {
      ...state,
      query: action.query
    }
  case actions.search.clearResult:
    return {
      ...state,
      [action.kind]: { collection: [], nextPage: null }
    }
  case actions.search.updateResult:
    return {
      ...state,
      [action.kind]: {
        collection: [
          ...state[action.kind].collection,
          ...action.collection
        ],
        nextPage: action.nextPage
      }
    }
  default:
    return state
  }
}
