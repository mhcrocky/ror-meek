import { all, put, takeLatest } from 'redux-saga/effects'
import actions from '../actions'
import { API } from '../config/endpoints'
import { callAPI } from '../helpers/saga'

function* loadPage({ slug }) {
  const page = yield callAPI.get(API.landingPages(slug))
  document.title = page.title
  yield put({ type: actions.landingPages.load.success, page, slug })
}

export function* landingPagesSaga() {
  yield all([
    takeLatest(actions.landingPages.load.request, loadPage)
  ])
}