import { useState, useEffect } from "react";
import "./App.css";
import Layout from "./Components/Layout";
import UserDashboard from "./Views/UserDashboard";
import Web3 from "web3";
import LandingPage from "./Components/LandingPage";

function App() {
  const [page, setPage] = useState(0);
  const pageHandler = (index) => {
    setPage(index);
  };
  const NotCreated = () => <div>Not Created yet</div>;
  return (
    <Layout pageHandler={pageHandler}>
      {page === 2 ? <UserDashboard /> : <LandingPage />}
    </Layout>
  );
}

export default App;
