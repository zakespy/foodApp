import React from "react";
import './App.css';
import Sidebar from "../src/components/Sidebar/Sidebar";
import { BrowserRouter, Routes, Route, useNavigate } from "react-router-dom";
import { MenuForm } from "./components/MenuForm/MenuForm";
import { Home } from "./components/Home/Home";
import OrderCard from "./components/OrderCard/Ordercard";


function App() {
  return (
    <> 
      <BrowserRouter>
        <Sidebar/>
        {/* <Routes>
          <Route path="/*" exact element={<Home/>}/>
        </Routes> */}
        {/* <OrderCard/> */}
      </BrowserRouter>
    </>
  )
}

export default App;
 