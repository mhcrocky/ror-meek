import { all, put, takeLatest } from 'redux-saga/effects'
import actions from '../actions'
import { API } from '../config/endpoints'
import { callAPI } from '../helpers/saga'

function* load({ name }) {
  try {
    const data = yield callAPI.get(API.backgrounds(name))
    yield put({ type: actions.backgrounds.load.success, data, name })
    document.title = data.title
  } catch ({ errors }) {
    yield put({ type: actions.alert.error, text: errors.toString() })
  }
}

export function* backgroundsSaga() {
  yield all([
    takeLatest(actions.backgrounds.load.request, load)
  ])
}