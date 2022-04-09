import React from "react";
import Nav from "./Nav";

const index = ({ children, pageHandler, address, connectWallet, ...props }) => {
  return (
    <div {...props}>
      <Nav
        pageHandler={pageHandler}
        address={address}
        connectWallet={connectWallet}
      />
      {children}
    </div>
  );
};

export default index;
