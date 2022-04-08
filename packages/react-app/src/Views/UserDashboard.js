import React from 'react'
import CouponSection from "../Sections/CouponSection";
import TransferToken from '../Sections/TransferToken';
import Balance from '../Components/Balance';

const User = () => {


  return (
    <div className='md:p-10 space-y-20'>
      <div className='w-full text-center text-4xl uppercase py-20'>
        Balance heading
      </div>
      <Balance />
      <TransferToken />
      <CouponSection />

    </div>
  );
};

export default User;
