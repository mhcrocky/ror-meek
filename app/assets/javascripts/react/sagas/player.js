import { all, takeEvery, put } from 'redux-saga/effects'
import actions from '../actions'
import { getAngularVideoPlayer, getAngularPlayer } from '../helpers/angular'
import { ERRORS } from '../config/strings'

function* play({ media, options }) {

  function playPodcast(podcast) {
    const { current_episode } = podcast
    if (current_episode.video) {
      getAngularVideoPlayer().openVideoDialog(current_episode)
    } else {
      getAngularPlayer().startPodcast(podcast, current_episode)
    }
  }

  function playEpisode(episode) {
    const { video, podcast } = episode
    if (video) {
      getAngularVideoPlayer().openVideoDialog(episode)
    } else {
      if (podcast) { getAngularPlayer().startPodcast(podcast, episode) }
      else { playRadio(episode) }
    }
  }

  function playRadio(radioStation) {
    getAngularPlayer().startRadio(radioStation)
  }

  try {
    if (options && options.podcast) {
      playPodcast(media)
    } else if (options && options.radio) {
      playRadio(media)
    } else {
      playEpisode(media)
    }
  } catch (text) {
    console.warn(text)
    yield put({ type: actions.alert.error, text: ERRORS.MEDIA })
  }
}

export function* playerSaga() {
  yield all([
    takeEvery(actions.player.play, play)
  ])
}