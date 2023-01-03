import React, { Fragment, useEffect } from 'react'
import { connect } from 'react-redux'
import actions from '../actions'
import { Link } from './common/Link'
import { SearchForm } from './forms/SearchForm'
import { HoverMenu } from './common/HoverMenu'

export const Header = connect(s => ({ user: s.user, page: s.page }))
(({ user, dispatch }) => {

    useEffect(() => { dispatch({ type: actions.application.init }) }, [])

    const handleInvite = () => { dispatch({ type: actions.modal.show, name: 'inviteFriend' }) }

    const handleLogin = () => { dispatch({ type: actions.modal.show, name: 'signInDialog' }) }

    const handleLogout = () => { dispatch({ type: actions.user.logout.request }) }

    const handleSettings = () => { dispatch({ type: actions.router.go, page: 'profile', params: { id: user.slug } }) }

    return (
      <div>
        <div className="left-side">
          <Link className="header-item logo" to="/">
            <span className="header-logo"/>
          </Link>
          <a id="sidenav-button" className="header-item toggle-sidebar-button icon-hamburger"/>
        </div>
        <div className="center-side">
          <Link className="header-item logo" to="/">
            <span className="header-logo"/>
          </Link>
        </div>
        <div className="right-side">
          <div className="header-item header-search-link">
            <i className="icon-search-header"/>
            <i className="icon-close-bold"/>
          </div>

          <span className="header-item header-search">
              <SearchForm/>
            </span>

          {user.isAuthenticated &&
           <div
             className="header-item" onClick={handleInvite}>
             <div className="icon-wrapper">
               <div className="icon-invite"/>
               <div className="icon-text uppercase">Invite</div>
             </div>
           </div>}

          {!user.isAuthenticated &&
           <div
             className="header-item" onClick={handleLogin}>
             <div className="icon-wrapper">
               <div className="icon-login"/>
               <div className="icon-text uppercase">Sign in</div>
             </div>
           </div>}

          <HoverMenu trigger={
            user.isAuthenticated &&
            <div className="header-item">
              <div className="icon-wrapper">
                <div
                  className="user-avatar"
                  style={{ backgroundImage: `url(${user.profile_pic})` }}
                />
              </div>
            </div>
          }>
            <div className="header-dropdown">
              <div className="header-item" onClick={handleSettings}>
                <div className="icon-wrapper">
                  <div className="icon-list"/>
                  <div className="icon-text uppercase">Settings</div>
                </div>
              </div>
              <div className="header-item" onClick={handleLogout}>
                <div className="icon-wrapper">
                  <div className="icon-login"/>
                  <div className="icon-text uppercase">Logout</div>
                </div>
              </div>
            </div>
          </HoverMenu>

        </div>
      </div>
    )
  }
)
