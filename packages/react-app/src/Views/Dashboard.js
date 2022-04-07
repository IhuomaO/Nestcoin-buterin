import React from "react";

import CouponSection from "../Sections/CouponSection";
import Input from "../Components/Input";

const Dashboard = () => {
  return (
    <div>
      Dashboard
      <Input label={"Address"} name="address1" />
      <CouponSection />
    </div>
  );
};

export default Dashboard;
