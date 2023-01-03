import { all, put, takeLatest } from 'redux-saga/effects'
import actions from '../actions'
import { angularLogout, angularSignup } from '../helpers/angular'
import { userSignupDAO } from '../helpers/DAO'

function* logout() {
  try {
    angularLogout()

  } catch (e) { console.warn(e) }
}

function* signup({ value }) {
  try {
    yield angularSignup(userSignupDAO(value))
    yield put({ type: actions.router.go, page: 'setupAccountComplete' })

  } catch ({ data }) {
    if (data && data.errors) {
      yield put({ type: actions.user.update, value: { errors: data.errors } })
    }
  }
}

export function* userSaga() {
  yield all([
    takeLatest(actions.user.logout.request, logout),
    takeLatest(actions.user.signup.request, signup)
  ])
}