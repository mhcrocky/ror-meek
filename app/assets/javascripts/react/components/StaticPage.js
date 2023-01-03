import React, { useEffect } from 'react'
import { connect } from 'react-redux'
import { MavMenu } from './common/NavMenu'
import actions from '../actions'
import { BreadCrumbs } from './common/BreadCrumbs'
import { isEmpty } from '../helpers/utils'

export const StaticPage =
  connect(s => ({ staticPages: s.staticPages }))
  (({ slug, staticPages, dispatch }) => {
      const page = staticPages[slug]

      useEffect(
        () => { isEmpty(page) && dispatch({ type: actions.staticPages.load.request, slug }) },
        [])

      if (!page) { return null }

      return (
        <div className={`static-page ${slug}`}>
          <div className="header-page">

            <BreadCrumbs items={[
              { to: '/', title: 'Home' },
              { title: page.name }
            ]}/>

            <div className="categories">
              Meek.ly
            </div>
            <h1 className="title">
              { page.name }
            </h1>
          </div>
          <MavMenu active={slug}/>
          <div className="left-right-offset" dangerouslySetInnerHTML={{ __html: page.content }}/>
        </div>
      )
    }
  )
