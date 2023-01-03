import React, { useEffect, useRef, Fragment } from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux'
import actions from '../actions'
import { isEmpty } from '../helpers/utils'
import { TAG_SIGNUP } from '../config/strings'
import { SignupForm } from './forms/SignupForm'

const INJECTED_CLASSNAME = 'injected-content'

const injectHTML = (contentRef, partials) => {
  const contentDOM = ReactDOM.findDOMNode(contentRef)
  const chunksDOMNodes = contentDOM.querySelectorAll(`.${INJECTED_CLASSNAME}`)

  chunksDOMNodes.forEach((node, i) => { node.outerHTML = partials[i++] })
}

export const getChunks = content => content.split(TAG_SIGNUP)

export const LandingPage =
  connect(s => ({ landingPages: s.landingPages, router: s.router }))
  (({ landingPages, dispatch, router, slug: propsSlug }) => {

      const slug = propsSlug || router.params.id
      const page = landingPages[slug]
      const contentRef = useRef()

      useEffect(
        () => {
          if (isEmpty(page)) { dispatch({ type: actions.landingPages.load.request, slug }) }
          else { injectHTML(contentRef.current, getChunks(page.content)) }
        }, [page])

      if (!page) { return null }

      const parts = getChunks(page.content)
      const formsNum = parts.length - 1

      return (
        <div className="static-page landing-page">
          <div className="left-right-offset" ref={contentRef}>
            {getChunks(page.content).map((html, i) =>
              <Fragment key={i}>
                <div className={INJECTED_CLASSNAME}/>
                {i < formsNum &&
                 <SignupForm/>}
              </Fragment>)}
          </div>
        </div>
      )
    }
  )
