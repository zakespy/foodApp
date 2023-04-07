import React from "react";
import "../Sidebar/SidebarStyle.css"

export default function Sidebar() {

    return (
        <>
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
                            <a href="#" class="active">
                                <span class="icon"><i class="fas fa-home"></i></span>
                                <span class="item">Home</span>
                            </a>
                        </li>
                        <li className="dashboardItem">
                            <a href="#">
                                <span class="icon"><i class="fas fa-desktop"></i></span>
                                <span class="item">My Dashboard</span>
                            </a>
                        </li>
                        <li className="dashboardItem">
                            <a href="#">
                                <span class="icon"><i class="fas fa-user-friends"></i></span>
                                <span class="item">People</span>
                            </a>
                        </li>
                        <li className="dashboardItem">
                            <a href="#">
                                <span class="icon"><i class="fas fa-tachometer-alt"></i></span>
                                <span class="item">Perfomance</span>
                            </a>
                        </li>
                        <li className="dashboardItem">
                            <a href="#">
                                <span class="icon"><i class="fas fa-database"></i></span>
                                <span class="item">Development</span>
                            </a>
                        </li>
                        <li className="dashboardItem">
                            <a href="#">
                                <span class="icon"><i class="fas fa-chart-line"></i></span>
                                <span class="item">Reports</span>
                            </a>
                        </li>
                        <li className="dashboardItem">
                            <a href="#">
                                <span class="icon"><i class="fas fa-user-shield"></i></span>
                                <span class="item">Admin</span>
                            </a>
                        </li>
                        <li className="dashboardItem">
                            <a href="#">
                                <span class="icon"><i class="fas fa-cog"></i></span>
                                <span class="item">Settings</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div >
        </>
    )
}