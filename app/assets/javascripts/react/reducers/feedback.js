import actions from '../actions'

export const initialState = {
  name: '',
  email: '',
  body: '',
  errors: {},
  submitted: false
}

export default (state = initialState, action) => {
  switch (action.type) {
  case actions.feedback.reset:
    return initialState
  case actions.feedback.update:
    return {
      ...state,
      ...action.value
    }
  case actions.feedback.save.request:
    return {
      ...state,
      submitted: true
    }
  default:
    return state
  }
}
