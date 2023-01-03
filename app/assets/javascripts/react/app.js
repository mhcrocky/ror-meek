import React, { Component } from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { WithRoute } from './components/HOCs/WithRoute'
import { StaticPage } from './components/StaticPage'
import { Cookies } from './components/Cookies'
import { WithTitle } from './components/HOCs/WithTitle'
import { ContactUs } from './components/ContactUs'
import { Page404 } from './components/Page404'
import { LandingPage } from './components/LandingPage'
import { Home } from './components/Home'
import { SearchResults } from './components/SearchResults'
import { Header } from './components/Header'
import { configureStore } from './helpers/redux'
import { Categories } from './components/Categories'

const store = configureStore()

render(
  <Provider store={store}>
    <Header/>
  </Provider>,
  document.getElementById('main-header'))

render(
  <Provider store={store}>
    <WithRoute page='home' component={<Home/>}/>
    <WithRoute page='search' component={<SearchResults/>}/>
    <WithRoute page='landingPages' component={<LandingPage/>}/>
    <WithRoute page='setupAccount' component={<LandingPage slug='setup'/>}/>
    <WithRoute page='setupAccountComplete' component={<LandingPage slug='thank-you'/>}/>
    <WithRoute page='podcasts' component={<Categories kind='podcasts'/>}/>
    <WithRoute page='articles' component={<Categories kind='articles'/>}/>

    <WithRoute page='404' component={<Page404/>}/>
    <WithRoute page='about' component={<StaticPage slug='about'/>}/>
    <WithRoute page='terms' component={<StaticPage slug='terms'/>}/>
    <WithRoute page='privacy' component={<StaticPage slug='privacy'/>}/>
    <WithRoute page='cookies' component={<WithTitle title='Cookies' component={<Cookies/>}/>}/>
    <WithRoute page='contactus' component={<WithTitle title='Contact Us' component={<ContactUs/>}/>}/>
  </Provider>,
  document.getElementById('react-container'))

