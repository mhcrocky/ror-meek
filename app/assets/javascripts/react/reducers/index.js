import { combineReducers } from 'redux'
import staticPages from './staticPages'
import landingPages from './landingPages'
import router from './router'
import feedback from './feedback'
import search from './search'
import angularResources from './angularResources'
import backgrounds from './backgrounds'
import trends from './trends'
import user from './user'
import categories from './categories'
import switches from './switches'
import recent from './recent'

export default combineReducers({
  router,
  staticPages,
  landingPages,
  feedback,
  search,
  angularResources,
  backgrounds,
  trends,
  user,
  categories,
  switches,
  recent
})
