import actions from '../actions'

const initialState = {}

export default (state = initialState, action) => {
  switch (action.type) {
  case actions.angularResources.update:
    return {
      ...state,
      [action.resource]: action.value
    }
  default:
    return state
  }
}
