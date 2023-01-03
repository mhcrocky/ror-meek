import React from 'react'
import { angularRouteTo } from '../../helpers/angular'

export const Link = props => {

  const { to, ...rest } = props

  const handleClick = event => {
    event.preventDefault()
    angularRouteTo(to)
  }

  return (
    <a
      href={to}
      {...rest}
      onClick={handleClick}
    >
      {props.children}
    </a>
  )
}