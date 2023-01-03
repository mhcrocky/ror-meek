import React, { useEffect, useCallback, Fragment } from 'react'
import { connect } from 'react-redux'
import actions from '../actions'
import { CURRENT_BACKGROUND, TRENDS } from '../config/strings'
import { MediaItem } from './common/MediaItem'
import { isEmpty } from '../helpers/utils'
import Media from 'react-media';
import ReactIdswiper from "react-id-swiper";

export const Home = connect(s => ({ backgrounds: s.backgrounds, trends: s.trends, user: s.user, recent: s.recent }))
(({ backgrounds, trends, dispatch, user, recent }) => {

  const page = backgrounds[CURRENT_BACKGROUND] || {}

    useEffect(
      () => {
        for (let kind of TRENDS) {
          isEmpty(trends[kind]) && dispatch({ type: actions.trends.load.request, kind })
        }
        isEmpty(page) && dispatch({ type: actions.backgrounds.load.request, name: CURRENT_BACKGROUND })
      }, [])

    const params = {
        slidesPerView: 2,
        autoplay: false,
        loop: true,
        pagination: {
            el: '.swiper-pagination',
            type: 'bullets',
        }
    }

    const renderItem = useCallback(
        media => (
            <div className="list-box-item" key={media.id}>
                <MediaItem media={media} dispatch={dispatch}/>
            </div>
        ),
        []
    );

    return (
      <div>
        <div id="home">
          <div>
            <div dangerouslySetInnerHTML={{ __html: user.id? page.logged_in_header : page.section_1 }}/>

            {(recent.undefined && recent.undefined.length > 0 && user.isAuthenticated) &&
              <div className='recommended-header left-right-offset recent-episodes'>
                <span className='big-header'> Recent Episodes </span>
                <div className='list-box grid-view'>
                  <Media queries={{
                    mobile: "(max-width: 736px)",
                    other: "(min-width: 737px)"
                  }}>
                    {matches => (
                      <Fragment>
                        {matches.mobile && <ReactIdswiper {...params}>{recent.undefined.map(renderItem)}</ReactIdswiper>}
                        {matches.other && recent.undefined.map(renderItem)}
                      </Fragment>
                    )}
                  </Media>
                </div>
              </div>}

            {(trends.latest_episodes && trends.latest_episodes.length) &&
             <div className="recommended-header left-right-offset">
               <span className="big-header"> New Releases For You </span>
               <ul className="list-box grid-view">
                 {trends.latest_episodes.map(media =>
                   <li className="list-box-item" key={media.id}>
                     <MediaItem media={media} dispatch={dispatch}/>
                   </li>)}
               </ul>
             </div>}

            <div dangerouslySetInnerHTML={{ __html: page.section_2 }}/>

              {(trends.podcasts_to_try && trends.podcasts_to_try.length) &&
              <div className="recommended-header left-right-offset podcasts-to-try">
                <span className="big-header"> Podcasts To Try </span>
                <ul className="list-box grid-view">
                  {trends.podcasts_to_try.map(media =>
                    <li className="list-box-item" key={media.id}>
                      <MediaItem media={media} dispatch={dispatch} options={{podcast: true}}/>
                    </li>)}
                </ul>
              </div>}

            <div dangerouslySetInnerHTML={{ __html: page.section_3 }}/>

            {(trends.episodes && trends.episodes.length) &&
              <div className="recommended-header left-right-offset top-episodes">
                <span className="big-header"> Top Episodes </span>
                <div className="list-box grid-view">
                  <Media queries={{
                    mobile: "(max-width: 736px)",
                    other: "(min-width: 737px)"
                  }}>
                    {matches => (
                      <Fragment>
                        {matches.mobile && <ReactIdswiper {...params}>{trends.episodes.map(renderItem)}</ReactIdswiper>}
                        {matches.other && trends.episodes.map(renderItem)}
                      </Fragment>
                    )}
                  </Media>
                </div>
              </div>}

            <div dangerouslySetInnerHTML={{ __html: page.section_4 }}/>

          </div>
        </div>
      </div>
    )
  }
)
