import actions from '../actions'

export const initialState = {}

export default (state = initialState, action) => {
  switch (action.type) {
  case actions.categories.updateAll:
    return action.value
  case actions.categories.updateOne:
    return { ...state, [action.slug]: action.value }
  default:
    return state
  }
}
