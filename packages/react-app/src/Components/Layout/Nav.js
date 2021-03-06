import React from "react";
import { useState } from 'react';
import Button from "../Button";
import { requestAccount } from "../../Utils/helpers/ConnectMetamask.helper";


const Nav = ({ page, pageHandler, connectWallet }) => {
  const links = ["Home", "Admin", "User"];
  const [walletAddress, setWalletAddress] = useState("");

  return (
    <div className="flex h-20 items-center shadow-md p-2 sticky bg-gray-50 top-0 z-10">
      <nav className="flex flex-1 justify-center space-x-7">
        {links.map((link, index) => (

          <div
            key={index}
            className={`flex h-full font-semibold text-xl  px-4 py-2 active:text-indigo-300 hover:text-indigo-500 transition duration-300 cursor-pointer z-10 ${page === index && 'text-indigo-500  '} `}
            onClick={() => pageHandler(index)}
          >
            {link}
          </div>
        ))}
      </nav>
      <div className="w-[550px] flex items-center ">
        <h3 className="font-semibold">Wallet Address: <br /> <span className="font-normal"> {walletAddress || 'None connected'}</span></h3>

        <Button className="mx-auto" onClick={() => requestAccount(setWalletAddress)}>
          Connect
        </Button>
      </div>
      
    </div>
  );
};

export default Nav;
