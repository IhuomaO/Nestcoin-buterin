import React from "react";

const Card = ({ id, bgImage, body, value, name }) => {
  return (
    <div className="lg:w-1/3 w-full mb-6 lg:p-3">
      <div className="bg-gray-200 rounded-xl  h-[500px]">
        <img src={bgImage} className="w-full h-60" alt={bgImage} />
        <div className="px-6 pb-6 pt-3">
          <h2 className="text-xl font-bold mb-2 uppercase">{name}</h2>
          <p className="text-gray-600 leading-5 mb-4">{body}</p>
          <input type="hidden" value={id} />
          <p className="text-2xl font-thin mb-6">{value} BTR</p>
          <button className="text-indigo-500 px-4 py-3 bg-gray-300 rounded hover:bg-indigo-500 hover:text-white transition duration-300 inline-flex items-center justify-center leading-snug">
            Get Reward
          </button>
        </div>
      </div>
    </div>
  );
};

export default Card;
