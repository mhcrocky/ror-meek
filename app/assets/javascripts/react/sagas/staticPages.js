import { all, put, takeLatest } from 'redux-saga/effects'
import actions from '../actions'
import { API } from '../config/endpoints'
import { callAPI } from '../helpers/saga'

function* loadPage({ slug }) {
  try {
    const page = yield callAPI.get(API.staticPages(slug))
    document.title = page.title
    yield put({ type: actions.staticPages.load.success, page, slug })
  } catch ({ errors }) {
    yield put({ type: actions.feedback.update, errors })
  }
}

export function* staticPagesSaga() {
  yield all([
    takeLatest(actions.staticPages.load.request, loadPage)
  ])
}