import React from "react";
import './mainpage.css';

export default function Mainpage() {
    return(

<body>
  <div class="sidebar">
    <div class="logo-details">
      <i class='bx '></i>
      <span class="logo_name">Menu</span>
    </div>
      <ul class="nav-links">
       
        <li>
          <a href="#">
            <i class='bx'></i>
            <span class="links_name">option 2</span>
          </a>
        </li>
        <li>
          <a href="#">
            <i class='bx'></i>
            <span class="links_name">option 3</span>
          </a>
        </li>
        <li>
          <a href="#">
            <i class='bx'></i>
            <span class="links_name">option 4</span>
          </a>
        </li>
        <li>
          <a href="#">
            <i class='bx'></i>
            <span class="links_name">LogOut</span>
          </a>
        </li>
      </ul>
  </div>

  <section class="home-section">

    <nav>
      <div class="sidebar-button">
        <i class='bx'></i>
        <span class="dashboard">Dashboard</span>
      </div>
      <div class="search-box">
        <input type="text" placeholder="Search..." />
      </div>
      <div class="profile-details">
       
        <span class="admin_name">Admin</span>
        <i class='bx bx-chevron-down' ></i>
      </div>
    </nav>

  </section>

</body>

    )
}