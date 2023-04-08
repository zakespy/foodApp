import React,{useState} from "react";
import "../Sidebar/SidebarStyle.css"
import MenuPage from "../MenuPage/MenuPage";
import OrderPage from "../OrderPage/OrderPage";

export default function Sidebar() {

    const [componentsToggle,setComponentsToggle] = useState(0)


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
                            <a  onClick={()=>{setComponentsToggle(0)}}>
                                {/* {console.log(componentsToggle)} */}
                                {/* <span class="icon"><i class="fas fa-home"></i></span> */}
                                <span class="item">Orders</span>
                            </a>
                        </li>
                        <li className="dashboardItem">
                            <a  onClick={()=>{setComponentsToggle(1)}}>
                                {/* <span class="icon"><i class="fas fa-desktop"></i></span> */}
                                <span class="item">Menu</span>
                            </a>
                        </li>
                        <li className="dashboardItem">
                            <a  onClick={()=>{setComponentsToggle(2)}}>
                                {/* <span class="icon"><i class="fas fa-user-friends"></i></span> */}
                                <span class="item">Category</span>
                            </a>
                        </li>
                        <li className="dashboardItem">
                            <a  onClick={()=>{setComponentsToggle(3)}}>
                                {/* <span class="icon"><i class="fas fa-cog"></i></span> */}
                                <span class="item">Settings</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div >
            <div className="components">
                {componentsToggle === 0?<OrderPage/> : 
                componentsToggle === 1? <MenuPage/>:<MenuPage/>}
                    {/* <MenuPage/>
                    <OrderPage/> */}
                </div>
            </div>
            

        </>
    )
}