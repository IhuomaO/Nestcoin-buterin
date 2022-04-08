import React from 'react'
import PropTypes from 'prop-types'

const Input = ({ label, name, placeholder, type , ...props}) => {
  return (
    <div className='w-max space-x-16 text-xl mx-auto font-medium'>
      <label htmlFor={name}>{label}:</label>
      <input type={type || "text"} placeholder={placeholder} id={name} name={name} className="w-[300px] lg:w-[500px] font-normal px-5 py-[6px] border rounded-full text-lg focus:outline-double" {...props} />
    </div>
  )
}

Input.propTypes = {
  label: PropTypes.string,
  name: PropTypes.string,
  placeholder: PropTypes.string,
  type: PropTypes.string
}

Input.defaultProps = {
  placeholder: "Type in your Address"
}

export default Input