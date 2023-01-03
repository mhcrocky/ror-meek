import { createStore, applyMiddleware, compose } from 'redux'
import { IS_DEVELOPMENT } from '../config/strings'
import createSagaMiddleware from 'redux-saga'
import rootReducer from '../reducers'
import { rootSaga } from '../sagas/index'
import { angularSetRedux } from './angular'

const sagaMiddleware = createSagaMiddleware()

const initialState = {}

const enhancers = []

const middleware = [sagaMiddleware]

if (IS_DEVELOPMENT) {
  middleware.push(
    store => next => action => {
      const result = next(action)
      const { type, ...payload } = action

      console.groupCollapsed(`%c ${type}`, 'color: #4d98b7')

      Object.keys(payload).forEach(key =>
        console.log(`%c ${key}:`, 'color: #00aa00;', payload[key]))

      console.log('%c [next state]', 'color: #d94444;', store.getState())

      console.groupCollapsed('%c [call stack]', 'color: #d3b436;')
      console.trace()
      console.groupEnd()

      console.groupEnd()

      return result
    }
  )
  if (window.__REDUX_DEVTOOLS_EXTENSION__) {
    enhancers.push(window.__REDUX_DEVTOOLS_EXTENSION__())
  }
}

const composedEnhancers = compose(
  applyMiddleware(...middleware),
  ...enhancers
)

export const configureStore = () => {
  const store = createStore(
    rootReducer,
    initialState,
    composedEnhancers
  )

  sagaMiddleware.run(rootSaga)
  angularSetRedux(store)

  return store
}
