import React from "react";
import { useEffect,useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { Outlet, Link } from "react-router-dom";
import EditIcon from '@mui/icons-material/Edit';
import DeleteIcon from '@mui/icons-material/Delete';
import "../MenuCard/MenuCardStyles.css"

export default function MenuCard({food}){

    const navigate = useNavigate()
    

    return (
        <>
        {/* {console.log("food Menu card",food)} */}
            <div className="MenuCard">
                <div className="foodName">
                    <h4>{food.foodName}</h4>
                </div>
                <div className="foodCategory">
                    {/* {console.log("food",food)} */}
                    {food.foodCategory.length == 0?<h4>No Category</h4>:
                    food.foodCategory.map(e=>{
                        <h4>{e}</h4>
                    })}
                </div>
                <div className="foodPrice">
                    <h4>{food.foodPrice} Rs</h4>
                </div>
                <div className="foodIcon">
                    {/* <Link to="/menu-form"> */}
                    {/* <Link > */}
                    <EditIcon className="actionIcon" onClick={()=>{navigate('/menu-form', { state: { food} });}}/>
                    {/* </Link> */}
                    <DeleteIcon className="actionIcon"/> 
                </div>
            </div>
        </>
    )
}