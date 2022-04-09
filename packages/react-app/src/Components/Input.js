import React from "react";
import PropTypes from "prop-types";

const Input = ({ label, name, placeholder, type, ...props }) => {
  return (
    <div className="w-max space-x-16 text-2xl mx-auto font-semibold">
      <label htmlFor={name}>{label}:</label>
      <input
        type="text"
        placeholder={placeholder}
        id={name}
        name={name}
        className="w-[300px] lg:w-[500px] px-5 py-2 border rounded-full text-lg focus:outline-double"
        {...props}
      />
    </div>
  );
};

Input.propTypes = {
  label: PropTypes.string,
  name: PropTypes.string,
  placeholder: PropTypes.string,

  type: PropTypes.oneOf(["address", "amount"]),
};

Input.defaultProps = {
  placeholder: "Type in your Address",
};

export default Input;
