import { all, put, takeEvery } from 'redux-saga/effects'
import actions from '../actions'
import { API } from '../config/endpoints'
import { callAPI } from '../helpers/saga'

function* load({ kind }) {
  try {
    const collection = yield callAPI.get(API.trends(kind))
    yield put({ type: actions.trends.load.success, collection, kind })
  } catch ({ errors }) {
    yield put({ type: actions.feedback.update, errors })
  }
}

export function* trendsSaga() {
  yield all([
    takeEvery(actions.trends.load.request, load)
  ])
}