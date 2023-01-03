import React, { Fragment, useRef, useState, useEffect } from 'react'
import ReactDOM from 'react-dom'

export const HoverMenu = ({ trigger, children }) => {

  const triggerNode = useRef()
  const menuNode = useRef()
  const [menuActive, setMenuActive] = useState(false)
  let menuDOMNode
  let triggerDOMNode
  const isTouchableDevice = window.ontouchstart

  useEffect(() => {
    addListeners()
    menuDOMNode = ReactDOM.findDOMNode(menuNode.current)
    triggerDOMNode = ReactDOM.findDOMNode(triggerNode.current)

    return removeListeners
  })

  const addListeners = () => {
    triggerNode.current.addEventListener('mouseenter', handleOpenMenu)
    menuNode.current.addEventListener('mouseleave', handleCloseMenu)
    window.addEventListener('click', checkClickOut)
    isTouchableDevice && window.addEventListener('mousemove', checkClickOut)
  }

  const removeListeners = () => {
    triggerNode.current.removeEventListener('mouseenter', handleOpenMenu)
    menuNode.current.removeEventListener('mouseleave', handleCloseMenu)
    window.removeEventListener('click', checkClickOut)
    isTouchableDevice && window.removeEventListener('mousemove', checkClickOut)
  }

  const checkClickOut = ({ target }) => {
    if (menuDOMNode.contains(target) || triggerDOMNode.contains(target)) { return }
    setMenuActive(false)
  }

  const handleOpenMenu = () => { setMenuActive(true) }

  const handleCloseMenu = () => { setMenuActive(false) }

  return (
    <Fragment>
      <span ref={triggerNode}>
        {trigger}
      </span>

      <div ref={menuNode} onClick={handleCloseMenu}>
        {menuActive && children}
      </div>
    </Fragment>
  )
}
