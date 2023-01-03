import { all, put, takeLatest } from 'redux-saga/effects'
import actions from '../actions'
import { API } from '../config/endpoints'
import { feedbackDAO } from '../helpers/DAO'
import { callAPI } from '../helpers/saga'

function* save({ value }) {
  try {
    yield callAPI.post(API.feedback, feedbackDAO(value))
    yield put({ type: actions.feedback.reset })
    yield put({ type: actions.alert.success, text: 'Your feedback has been submitted. Thank You.' })
  } catch ({ errors }) {
    yield put({ type: actions.feedback.update, errors })
  }
}

export function* feedbackSaga() {
  yield all([
    takeLatest(actions.feedback.save.request, save)
  ])
}