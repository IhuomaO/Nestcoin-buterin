import React from 'react'
import Button from '../Button'

const Nav = ({ page, pageHandler }) => {
  const links = ['Home', 'Admin', 'User']
  return (
    <div className='flex h-20 items-center shadow-md p-2 sticky bg-gray-50 top-0'>
      <nav className='flex flex-1 justify-center space-x-7'>
        {links.map((link, index) => (
          <div key={link} className={` flex h-full font-semibold text-xl text-black  px-4 py-2 active:text-indigo-300 hover:text-indigo-500 transition duration-300 cursor-pointer z-10 ${page === index && 'text-indigo-700'}`} onClick={() => pageHandler(index)}>
            {link}
          </div>
        ))}
      </nav>
      <div className='w-40 '>
        <Button className='mx-auto'>Connect</Button>
      </div>
    </div>
  )
}

export default Nav