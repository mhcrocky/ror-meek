import React from 'react'
import { connect } from 'react-redux'
import actions from '../../actions'

export const SearchForm = connect(s => ({ search: s.search }))
(({ dispatch, search }) => {

  const { query } = search

  const handleSubmit = e => {
    e.preventDefault()
    if (query) { dispatch({ type: actions.search.searchAll.request, query }) }
  }

  const handleUpdate = ({ target: { value } }) => {
    dispatch({ type: actions.search.updateQuery, query: value })
  }

  return (
    <form className="search-form">
      <span className="search-block">
          <input
            id="search_input"
            className="form-control"
            autoComplete='off'
            placeholder='SEARCH'
            onChange={handleUpdate}
            value={query}
          />
        <button className="icon-search-header" type="submit" onClick={handleSubmit}/>
      </span>
    </form>
  )
})