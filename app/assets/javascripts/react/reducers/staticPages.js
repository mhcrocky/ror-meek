import actions from '../actions'

const initialState = {}

export default (state = initialState, action) => {
  switch (action.type) {
  case actions.staticPages.load.success:
    return {
      ...state,
      [action.slug]: action.page
    }
  default:
    return state
  }
}
