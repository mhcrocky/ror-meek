import { all, fork } from 'redux-saga/effects'
import { staticPagesSaga } from './staticPages'
import { landingPagesSaga } from './landingPages'
import { feedbackSaga } from './feedback'
import { alertSaga } from './alert'
import { searchSaga } from './search'
import { routerSaga } from './router'
import { backgroundsSaga } from './backgrounds'
import { trendsSaga } from './trends'
import { playerSaga } from './player'
import { modalSaga } from './modal'
import { userSaga } from './user'
import { categoriesSaga } from './categories'
import { switchesSaga } from './switches'
import { recentSaga } from './recent'

export function* rootSaga() {
  yield all([
    fork(staticPagesSaga),
    fork(landingPagesSaga),
    fork(feedbackSaga),
    fork(alertSaga),
    fork(searchSaga),
    fork(routerSaga),
    fork(backgroundsSaga),
    fork(trendsSaga),
    fork(playerSaga),
    fork(modalSaga),
    fork(userSaga),
    fork(categoriesSaga),
    fork(switchesSaga),
    fork(recentSaga)
  ])
}
