import React from "react";
import './mainpage.css';
import Card from "../Card/Card.js";

export default function Mainpage() {
    return(                         
<div class="row">
  <div class="column sidebar">

  <div class="logo-details">
      <h1 class="logo_name">Admin</h1>
    </div>
   
    <ul class="nav-links">
        <li>
          <a href="#">
            <h4 class="links_name">Breakfast</h4>
          </a>
        </li>
        <li>
          <a href="#">
            <h4 class="links_name">lunch</h4>
          </a>
        </li>
        <li>
          <a href="#">
            <h4 class="links_name">Other</h4>
          </a>
        </li>
      </ul>
      <div className="logot">
      <button className="logout_">
           <span>Logout</span>
      </button>
      </div>
  </div>

  <div class="column middle">
    <div className="mt">
      <p>Menu Cards</p>
      <div className="cardholder">
        <Card/>
      </div>
      <div className="cardholder">
        <Card/>
      </div>
      <div className="cardholder">
        <Card/>
      </div>
      <div className="cardholder">
        <Card/>
      </div>
      <div className="cardholder">
        <Card/>
      </div>
      <div className="cardholder">
        <Card/>
      </div>
      <div className="cardholder">
        <Card/>
      </div>
      <div className="cardholder">
        <Card/>
      </div>
      <div className="cardholder">
        <Card/>
      </div>
    </div>
  </div>

  <div class="column right">
    <div className="FinalzeMenu"> 
    <a class="btn" href="#">Finalze Menu</a>
    </div>

    <div className="rightcard">
        <Card/>
      </div>
      <div className="rightcard">
        <Card/>
      </div>
      <div className="rightcard">
        <Card/>
      </div>
      <div className="rightcard">
        <Card/>
      </div>

  </div>

</div>    
    )
}