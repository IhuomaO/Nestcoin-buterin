import React from 'react'
import Nav from './Nav'

const index = ({ children, page, pageHandler, ...props }) => {
  return (
    <div {...props}>
      <Nav page={page} pageHandler={pageHandler} />
      {children}
    </div>
  )
}

export default index