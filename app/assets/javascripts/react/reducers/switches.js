import actions from '../actions'
import { VIEW_MODES } from '../config/strings'

export const initialState = {
  viewMode: VIEW_MODES.LIST
}

export default (state = initialState, action) => {
  switch (action.type) {
  case actions.switches.setViewMode:
    return {
      ...state,
      viewMode: action.mode
    }
  default:
    return state
  }
}
