import React from 'react'
import { Link } from './Link'

export const BreadCrumbs = ({ items = [] }) =>
  <div className="list-breadcrumbs left-right-offset">
    {items.map(({ to, title }, i) =>
      <div key={i} className="list-breadcrumbs-item">
        <div className="last-flex-item-container">
          {to
            ? <Link className="uppercase" to={to}>{title}</Link>
            : title}
        </div>
      </div>)}
  </div>
