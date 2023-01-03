import { all, call, takeLatest } from 'redux-saga/effects'
import actions from '../actions'
import { angularAlert } from '../helpers/angular'

function* success({ text }) {
  yield call(angularAlert.success, text)
}

function* error({ text }) {
  yield call(angularAlert.error, text)
}

export function* alertSaga() {
  yield all([
    takeLatest(actions.alert.success, success),
    takeLatest(actions.alert.error, error)
  ])
}