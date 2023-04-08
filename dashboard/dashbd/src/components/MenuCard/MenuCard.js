import React from "react";
import EditIcon from '@mui/icons-material/Edit';
import DeleteIcon from '@mui/icons-material/Delete';
import "../MenuCard/MenuCardStyles.css"

export default function MenuCard({foodName,foodPrice,foodCategory}){
    return (
        <>
            <div className="MenuCard">
                <div className="foodName">
                    <h4>{foodName}</h4>
                </div>
                <div className="foodCategory">
                    <h4>{foodCategory}</h4>
                </div>
                <div className="foodPrice">
                    <h4>{foodPrice} Rs</h4>
                </div>
                <div className="foodIcon">
                    <EditIcon/>
                    <DeleteIcon/>
                </div>
            </div>
        </>
    )
}