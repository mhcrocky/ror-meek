import actions from '../actions'

const initialState = {
  loaded: false
}

export default (state = initialState, action) => {
  switch (action.type) {
  case actions.backgrounds.load.success:
    return {
      ...state,
      [action.name]: action.data,
      loaded: true
    }
  default:
    return state
  }
}
