import { all, put, takeLatest } from 'redux-saga/effects'
import actions from '../actions'
import { angularRouteTo } from '../helpers/angular'

function* go({ page, params }) {
  try {
    yield angularRouteTo(page, params)

  } catch (e) { console.warn(e) }
}

function* checkSignup({ page, params }) {
  if (params['#'] === 'signup') {
    yield put({ type: actions.router.go, page, params: { '#': null } })
    yield put({ type: actions.modal.show, name: 'signUpDialog' })
  }
}

export function* routerSaga() {
  yield all([
    takeLatest(actions.router.go, go),
    takeLatest(actions.router.updatePage, checkSignup)
  ])
}