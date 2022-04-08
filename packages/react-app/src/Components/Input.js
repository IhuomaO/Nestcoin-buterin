import React from "react";
import PropTypes from "prop-types";

const Input = ({ label, name, placeholder, type }) => {
  return (
    <div className="flex space-x-20 text-lg">
      <label htmlFor={name}>{label}</label>
      <input
        type="text"
        placeholder={placeholder}
        id={name}
        className="px-5 py-2 border rounded-2xl text-lg focus:outline-double"
      />
    </div>
  );
};

Input.propTypes = {
  label: PropTypes.string,
  name: PropTypes.string,
  placeholder: PropTypes.string,
  type: PropTypes.oneOf(["address", "amount"])
};

Input.defaultProps = {
  placeholder: "Type in your address"
};

export default Input;
