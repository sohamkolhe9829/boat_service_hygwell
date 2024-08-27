import React from "react";

const CheckBoxField = ({ label, checked, onChange }) => (
  <label className="inline-flex items-center cursor-pointer">
    <input
      type="checkbox"
      className="form-checkbox h-5 w-5 text-blue-600 border-gray-300 rounded-lg  focus:ring-blue-500 dark:focus:ring-blue-600 dark:bg-gray-700 dark:border-gray-600"
      checked={checked}
      onChange={onChange}
    />
    <span className="ml-2">{label}</span>
  </label>
);

export default CheckBoxField;
