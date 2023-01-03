import React, { useEffect, useState } from 'react'
import { connect } from 'react-redux'
import actions from '../actions'
import { ASSETS_URL } from '../config/strings'
import { isEmpty, deCamelCased, capitalised } from '../helpers/utils'
import { BreadCrumbs } from './common/BreadCrumbs'
import { MediaItem } from './common/MediaItem'
import { ViewModeSwitch } from './common/ViewModeSwitch'
import { BlogItem } from './common/BlogItem'

export const Categories =
  connect(s => ({ router: s.router, categories: s.categories, viewMode: s.switches.viewMode }))
  (({ kind, router, categories, viewMode, dispatch }) => {
      const TYPE_PODCAST = 'podcast'
      const TYPE_RADIO = 'radio'
      const TYPE_ARTICLE = 'article'
      const slug = router.params.id
      const category = categories[slug] || {}
      const { items, itemsType } =
          category.podcasts ? { items: category.podcasts, itemsType: TYPE_PODCAST }
        : category.radio_stations ? { items: category.radio_stations, itemsType: TYPE_RADIO }
        : category.articles ? { items: category.articles, itemsType: TYPE_ARTICLE }
        : { items: [], itemsType: 'none' };

      console.log('items', items, itemsType)

      useEffect(() => {
        if (isEmpty(items)) { dispatch({ type: actions.categories.loadOne.request, slug }) }
      })

      if (isEmpty(category)) { return null }

      const { wallpaper, name, h1 } = category

      return (
        <div id="category-index">
          <div className="header-page" style={{ backgroundImage: `url('${ASSETS_URL}${wallpaper}')` }}>
            <div className="header-page-bg">

              <BreadCrumbs
                items={[
                  { title: kind.toUpperCase() },
                  { title: name }
                ]}
              />

              <div className="categories uppercase"> {kind}, {name} </div>
              <h1 className="title"> {h1} </h1>
              <div className="info">
                Showing {items.length} {capitalised(deCamelCased(kind))}
              </div>

              <ViewModeSwitch />

            </div>
          </div>
          <div className="left-right-offset">
            <ul className={`list-box ${viewMode}`}>
              {items.map(media =>
                <li className="list-box-item" key={media.id}>
                  {kind=='podcast' ?
                    <MediaItem media={media} dispatch={dispatch} options={{
                      podcast: itemsType === TYPE_PODCAST
                    }}/>:
                    <BlogItem media={media} dispatch={dispatch} type={'articles'}/>
                  }
                </li>)}
            </ul>
          </div>
        </div>
      )
    }
  )
