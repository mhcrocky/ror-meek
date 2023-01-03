import React from 'react'
import { SearchForm } from './forms/SearchForm'
import { BreadCrumbs } from './common/BreadCrumbs'

export const Page404 = () =>
  <div className="static-page static-404">
    <div className="header-page">

      <BreadCrumbs items={[
        { to: '/', title: 'Home' },
        { title: 404 }
      ]}/>

      <div className="categories uppercase">
        That page wasn't found here
      </div>
      <h1 className="title left-right-offset">
        We are so sorry!
      </h1>
      <div className="info">
        Try searching here of use menu to find what you need.
      </div>
      <div className="left-right-offset">
        <SearchForm/>
      </div>
    </div>
  </div>
