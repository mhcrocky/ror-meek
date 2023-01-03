import actions from '../actions'

export const initialState = {
  email: '',
  password: '',
  password_confirmation: '',
  first_name: '',
  last_name: '',
  submitted: false,
  errors: {}
}

export default (state = initialState, action) => {
  switch (action.type) {
  case actions.user.reset:
    return initialState
  case actions.user.update:
    return {
      ...state,
      ...action.value
    }
  case actions.user.signup.request:
    return {
      ...state,
      submitted: true
    }
  default:
    return state
  }
}
