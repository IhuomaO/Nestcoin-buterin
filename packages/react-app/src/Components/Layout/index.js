import React from 'react'
import Nav from './Nav'

const index = ({ children, pageHandler, ...props }) => {
  return (
    <div {...props}>
      <Nav pageHandler={pageHandler} />
      {children}
    </div>
  )
}

export default index