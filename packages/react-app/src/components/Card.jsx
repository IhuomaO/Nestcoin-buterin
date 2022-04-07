import React from "react";

const Card = ({ id, bgImage, body }) => {
  return (
    <div className="lg:w-1/3 w-full mb-6 lg:p-3">
      <div className="bg-gray-200 rounded-xl">
        <img src={bgImage} className="max-w-full h-auto" alt={bgImage} />
        <div className="px-6 pb-6 pt-3">
          <h2 className="text-xl font-bold mb-2">Name</h2>
          <p className="text-gray-600 leading-5 mb-4">{body}</p>
          <input type="hidden" value={id} />
          <p className="text-2xl font-thin mb-6">Value BTR</p>
          <button className="text-indigo-500 px-4 py-3 bg-gray-300 rounded hover:bg-indigo-500 hover:text-white transition duration-300 inline-flex items-center justify-center leading-snug">
            Get Reward
          </button>
        </div>
      </div>
    </div>
  );
};

export default Card;
