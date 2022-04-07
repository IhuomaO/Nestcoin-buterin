import React from "react";
import Card from "../components/Card";
import { CardInformation } from "../data";
import Helpers from "../helpers/contractInfo";
const CouponSection = () => {
  return (
    <div className="container mx-auto flex flex-wrap items-start justify-center my-16">
      {CardInformation.map(card => (
        <Card key={card.id} {...card} />
      ))}
      {console.log(Helpers)}
    </div>
  );
};

export default CouponSection;
