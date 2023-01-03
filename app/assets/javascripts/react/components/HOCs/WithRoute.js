import React  from 'react'
import { connect } from 'react-redux'

const Component = ({ router, page, component, children }) =>
  router.page === page
    ? component || children
    : null

export const WithRoute = connect(({ router }) => ({ router }))(Component)
