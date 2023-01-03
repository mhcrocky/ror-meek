import React from 'react'
import { Link } from './Link'

export const MavMenu = ({ active }) => {

  const itemClass = route => `list-menu-static-page-item ${route === active ? ' active' : ''}`

  return (
    <ul className="list-menu-static-page">
      <li className={itemClass('about')}>
        <Link to="/about">About us</Link>
      </li>
      <li className={itemClass('terms')}>
        <Link to='/terms'> Terms of Use</Link>
      </li>
      <li className={itemClass('privacy')}>
        <Link to='/privacy'> Privacy Policy</Link>
      </li>
      <li className={itemClass('contactus')}>
        <Link to='/contactus'> Contact Us</Link>
      </li>
      <li className={itemClass('cookies')}>
        <Link to='/cookies'> What are Cookies</Link>
      </li>
    </ul>
  )
}