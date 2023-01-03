import { all, put, takeLatest } from 'redux-saga/effects'
import actions from '../actions'
import { callAPI } from '../helpers/saga'
import { API } from '../config/endpoints'
import { indexedObject } from '../helpers/utils'

function* loadAll() {
  try {
    const collection = yield callAPI.get(API.categories)
    yield put({
      type: actions.categories.updateAll,
      value: indexedObject(collection, 'slug')
    })

  } catch ({ errors }) { yield put({ type: actions.alert.error, errors }) }
}

function* loadItems({ slug }) {
  try {
    const value = yield callAPI.get(API.category(slug))
    yield put({ type: actions.categories.updateOne, slug, value })

  } catch ({ errors }) { yield put({ type: actions.alert.error, errors }) }
}

export function* categoriesSaga() {
  yield all([
    takeLatest(actions.application.init, loadAll),
    takeLatest(actions.categories.loadAll.request, loadAll),
    takeLatest(actions.categories.loadOne.request, loadItems)
  ])
}
