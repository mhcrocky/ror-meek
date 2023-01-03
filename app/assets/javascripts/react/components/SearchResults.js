import React, { useEffect } from 'react'
import { connect } from 'react-redux'
import actions from '../actions'
import { SEARCHES, ERRORS } from '../config/strings'
import { SearchedItems } from './common/SearchedItems'
import { SearchForm } from './forms/SearchForm'
import { isEmpty } from '../helpers/utils'
import { BreadCrumbs } from './common/BreadCrumbs'

export const SearchResults =
  connect(s => ({ search: s.search }))
  (({ search, dispatch }) => {

      useEffect(
        () => {
          return () => {dispatch({ type: actions.search.updateQuery, query: '' })}
        }, [])

      const { query } = search
      const isNoResults = SEARCHES.every(t => isEmpty(search[t].collection))

      const handleLoadMore = (kind, page) => { dispatch({ type: actions.search.loadMore.request, query, kind, page }) }

      return (
        <div className="static-page static-search">
          <div className="header-page">

            <BreadCrumbs items={[
              { to: '/', title: 'Home' },
              { to: 'search', title: 'search results' },
              { title: query }
            ]}/>

            <div className="categories uppercase">Search results</div>

            <div className="info">
              {query && <span> results for <i><b> {query} </b></i></span>}
            </div>

            <div className="left-right-offset">
              <SearchForm/>
            </div>

          </div>

          {!isNoResults && SEARCHES.map(type =>
            <SearchedItems
              key={type}
              result={search[type]}
              type={type}
              dispatch={dispatch}
              onLoadMore={handleLoadMore}
            />)}

          {isNoResults &&
           <div className="left-right-offset ng-scope">
             <h1 className="title"> {ERRORS.SEARCH_NO_RESULTS} </h1>
           </div>}

        </div>
      )
    }
  )
