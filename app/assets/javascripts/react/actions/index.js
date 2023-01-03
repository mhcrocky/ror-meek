import { IS_DEVELOPMENT } from '../config/strings'
import { router } from './router'
import { staticPages } from './staticPages'
import { landingPages } from './landingPages'
import { feedback } from './feedback'
import { alert } from './alert'
import { search } from './search'
import { angularResources } from './angularResources'
import { backgrounds } from './backgrounds'
import { trends } from './trends'
import { player } from './player'
import { user } from './user'
import { modal } from './modal'
import { categories } from './categories'
import { application } from './application'
import { switches } from './switches'
import { recent } from './recent'

const actions = {
  application,
  router,
  staticPages,
  landingPages,
  feedback,
  alert,
  search,
  angularResources,
  backgrounds,
  trends,
  player,
  user,
  modal,
  categories,
  switches,
  recent
}

if (IS_DEVELOPMENT) { console.log(actions) }

export default actions
