import React from "react";
import Card from "../Components/Card";
import { CardInformation } from "../data";

const CouponSection = () => {
  return (
    <div className="container mx-auto flex flex-wrap items-start justify-center my-16">
      {CardInformation.map(card => (
        <Card key={card.id} {...card} />
      ))}
    </div>
  );
};

export default CouponSection;
