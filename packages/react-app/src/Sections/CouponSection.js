import React, { useState } from "react";
import Button from "../Components/Button";
import Card from "../Components/Card";
import { CardInformation } from "../data";

const CouponSection = () => {
  const [cardIds, setCardIds] = useState([]);

  const purchaseCoupon = (e) => {
    e.preventDefault();
    console.log(cardIds);
    setCardIds([]);
    console.log(cardIds);
  };
  return (
    <>
      <div className="w-full text-center text-4xl uppercase py-2">
        Available rewards
      </div>
      <div className="container mx-auto flex flex-wrap items-start justify-center my-16">
        {CardInformation.map((card) => (
          <Card
            key={card.id}
            {...card}
            setCardIds={setCardIds}
            cardIds={cardIds}
          />
        ))}
      </div>
      {console.log(cardIds)}
      {cardIds.length > 0 && (
        <form onSubmit={purchaseCoupon}>
          <Button>Submit</Button>
        </form>
      )}
    </>
  );
};

export default CouponSection;
