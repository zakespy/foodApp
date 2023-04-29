import React from 'react'
import MenuPage from "../MenuPage/MenuPage";
import OrderPage from "../OrderPage/OrderPage";
import { BrowserRouter, Routes, Route, useNavigate } from "react-router-dom";
import { MenuForm } from "../MenuForm/MenuForm";
import { Outlet, Link } from "react-router-dom";
export function Home(){
  return (
    // <BrowserRouter>
    <Routes>
        <Route path="/" exact element={<OrderPage />} />
        <Route path="/menuPage" exact element={<MenuPage />} />
        <Route path="/menu-form" exact element={<MenuForm />} />
        {/* <Route path="/menu-form" exact element={<MenuForm />} /> */}
    </Routes>
// </BrowserRouter>
  )
}
