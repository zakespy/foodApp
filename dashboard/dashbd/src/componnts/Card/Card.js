import React from "react";
import './Card.css';
import pic from './pic.jpg';


export default function Card() {
    return(
      <body>
<div class="card-container">
	<img class="round" src={pic} alt="user" />
	<h1>Pav Bhaji</h1>
	<h5>Lunch Menu</h5>
	<h3>Price  $100</h3>
	<div>
  <a class="adt" href="#">ADD</a>
  <a class="adt" href="#">DELETE</a>
	</div>
</div>
</body>

    )
}