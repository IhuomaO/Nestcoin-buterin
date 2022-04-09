import React from 'react'

const Button = ({ className, children, ...props }) => {
  return (
    <button className={`${className} my-3 h-10 min-w-[130px] text-lg font-semibold text-indigo-500 px-4 py-3 bg-gray-300 rounded-full hover:bg-indigo-500 active:bg-indigo-400 hover:text-white transition duration-300 inline-flex items-center justify-center leading-snug`} {...props} >
      {children}
    </button >
  )
}

  export default Button
