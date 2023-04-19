import React from "react";
import { Outlet, Link } from "react-router-dom";
import EditIcon from '@mui/icons-material/Edit';
import DeleteIcon from '@mui/icons-material/Delete';
import "../MenuCard/MenuCardStyles.css"

export default function MenuCard({food}){
    return (
        <>
        {console.log("food Menu card",food)}
            <div className="MenuCard">
                <div className="foodName">
                    <h4>{food.foodName}</h4>
                </div>
                <div className="foodCategory">
                    {food.foodCategory.length == 0?<h4>No Category</h4>:
                    food.foodCategory.map(e=>{
                        <h4>{e}</h4>
                    })}
                </div>
                <div className="foodPrice">
                    <h4>{food.foodPrice} Rs</h4>
                </div>
                <div className="foodIcon">
                    <Link to="/menu-form">
                    <EditIcon className="actionIcon"/>
                    </Link>
                    <DeleteIcon className="actionIcon"/> 
                </div>
            </div>
        </>
    )
}