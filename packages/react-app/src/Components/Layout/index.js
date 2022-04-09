import React from "react";
import Nav from "./Nav";

const index = ({ children, page, pageHandler, address, connectWallet, ...props }) => {
  return (
    <div {...props}>
      <Nav
        page={page}
        pageHandler={pageHandler}
        address={address}
        connectWallet={connectWallet}
      />
      {children}
    </div>
  );
};

export default index;
