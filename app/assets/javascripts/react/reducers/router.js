import actions from '../actions'

const initialState = {
  page: null,
  params: {}
}

export default (state = initialState, action) => {
  switch (action.type) {
  case actions.router.updatePage:
    return {
      ...state,
      page: action.page || state.page,
      params: action.params || {}
    }
  default:
    return state
  }
}
