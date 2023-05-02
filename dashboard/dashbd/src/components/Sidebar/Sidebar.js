import React, { useState } from "react";
import "../Sidebar/SidebarStyle.css"
import MenuPage from "../MenuPage/MenuPage";
import OrderPage from "../OrderPage/OrderPage";
import { BrowserRouter, Routes, Route, useNavigate } from "react-router-dom";
import { MenuForm } from "../MenuForm/MenuForm";
import { Outlet, Link } from "react-router-dom";
import { Home } from "../Home/Home"; 


export default function Sidebar() {

    const [componentsToggle, setComponentsToggle] = useState(0)


    return (
        <>
            <div className="MainLayout">
                <div class="wrapper">
                    <div class="sidebar">
                        <div class="profile">
                            <img src="https://png.pngtree.com/template/20191014/ourmid/pngtree-building-and-construction-vector-illustration-element-logo-design-template-image_317810.jpg" alt="profile_picture">
                            </img>
                            <h3>BreakBite</h3>
                            {/* <p>Designer</p> */}
                        </div>
                        <ul>
                            <li className="dashboardItem">
                                <Link to="/" className="linkButton">
                                {/* <a onClick={() => { setComponentsToggle(0) }}> */}
                                    {/* {console.log(componentsToggle)} */}
                                    {/* <span class="icon"><i class="fas fa-home"></i></span> */}
                                    <span class="item">Orders</span>
                                {/* </a> */}
                                </Link>
                            </li>
                            <li className="dashboardItem">
                                <Link to="/menuPage" className="linkButton">
                                {/* <a onClick={() => { setComponentsToggle(1) }}> */}
                                    {/* <span class="icon"><i class="fas fa-desktop"></i></span> */}
                                    <span class="item">Menu</span>
                                {/* </a> */}
                                </Link>
                            </li>
                            <li className="dashboardItem">
                                <Link to="/category-form" className="linkButton">
                                {/* <a onClick={() => { setComponentsToggle(2) }}> */}
                                    {/* <span class="icon"><i class="fas fa-user-friends"></i></span> */}
                                    <span class="item">Category</span>
                                {/* </a> */}
                                </Link>
                            </li>
                            <li className="dashboardItem">
                                <Link to="/" className="linkButton">
                                {/* <a onClick={() => { setComponentsToggle(3) }}> */}
                                    {/* <span class="icon"><i class="fas fa-cog"></i></span> */}
                                    <span class="item">Settings</span>
                                {/* </a> */}
                                </Link>
                            </li>
                        </ul>
                    </div>
                </div >
                <div className="components">
                    {/* {componentsToggle === 0?<OrderPage/> : 
                componentsToggle === 1? <MenuPage/>:<MenuPage/>} */}
                    {/* <BrowserRouter>
                        <Routes>
                            <Route path="/" exact element={<OrderPage />} />
                            <Route path="/menuPage" exact element={<MenuPage />} />
                            <Route path="/menu-form" exact element={<MenuForm />} />
                            <Route path="/menu-form" exact element={<MenuForm />} />
                        </Routes>
                    </BrowserRouter> */}
                    <Home/>
                </div>
                
            </div>


        </>
    )
}