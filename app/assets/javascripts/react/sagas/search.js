import { all, takeLatest, put } from 'redux-saga/effects'
import actions from '../actions'
import { API } from '../config/endpoints'
import { callAPI } from '../helpers/saga'
import { SEARCHES } from '../config/strings'

function* search({ query, kind, page = 1 }) {
  try {
    const { data, next_page } = yield callAPI.get(API.searches(query, kind, page))
    yield put({ type: actions.search.updateResult, kind, collection: data, nextPage: next_page })

  } catch ({ errors }) { yield put({ type: actions.alert.error, text: errors.toString() }) }
}

function* searchAll({ query }) {
  yield put({ type: actions.router.go, page: 'search', params: { search: query } })

  for (let kind of SEARCHES) {
    yield put({ type: actions.search.clearResult, kind })
    yield search({ query, kind })
  }
}

export function* searchSaga() {
  yield all([
    takeLatest(actions.search.searchAll.request, searchAll),
    takeLatest(actions.search.loadMore.request, search)
  ])
}