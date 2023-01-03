import React, { useEffect } from 'react'

export const WithTitle = ({ title, component, children }) => {
  const prevTitle = document.title

  useEffect(
    () => { document.title = title },
    () => { document.title = prevTitle }
  )

  return component || children
}
