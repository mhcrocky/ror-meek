import actions from '../actions'

const initialState = {}

export default (state = initialState, action) => {
  switch (action.type) {
  case actions.recent.load.success:
    return {
      ...state,
      [action.kind]: action.collection
    }
  default:
    return state
  }
}
