import React from 'react'

const Button = ({ className, submit, children, ...props }) => {
  return (
    <button className={`${className} flex h-10 px-5 min-w-[130px] rounded-full active:bg-green-600 transition-colors items-center bg-green-700 justify-center text-xl mx-auto text-green-50`} submit={submit ? 'submit' : ''} {...props} >
      {children}
    </button >
  )
}

export default Button