import { all, put, takeEvery } from 'redux-saga/effects'
import actions from '../actions'
import { API } from '../config/endpoints'
import { callAPI } from '../helpers/saga'

export function* recentSaga() {
  const collection = yield callAPI.get(API.recent)
  yield put({ type: actions.recent.load.success, collection })
}
