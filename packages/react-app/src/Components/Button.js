import React from 'react'

const Button = ({ children, ...props }) => {
  return (
    <button className="text-indigo-500 px-4 py-3 bg-gray-300 rounded hover:bg-indigo-500 active:bg-indigo-400 hover:text-white transition duration-300 inline-flex items-center justify-center leading-snug" {...props}>
      {children}
    </button>
  )
}

export default Button