import React from "react";
import { useEffect,useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios"
import CircularProgress from '@mui/material/CircularProgress';
import "../MenuPage/MenuPageStyles.css"
import MenuCard from "../MenuCard/MenuCard";
import AddIcon from '@mui/icons-material/Add';
import { Link } from "react-router-dom";

export default function MenuPage(){
    var menu = []
    var cat = []
    const navigate = useNavigate()
    const [food,setFood] = useState([])
    const [defaultCat, setDefaultCat] = useState([])

    function fetchFood(){
        // await axios.get("http://localhost:8000/api/food/allFood").then(e=>{setFood(e.data.menu)})
         axios.get("http://localhost:8000/api/food/allFood").then(e=>{setFood(e.data.menu)})
    }

    async function getCategory(){
        const category = await axios.get('http://localhost:8000/api/category/getAllCategory').then(e => { setDefaultCat(e.data.categories) })
        // const category = await axios.get('http://localhost:8000/api/category/getAllCategory').then(e => { cat = e.data.categories })
    }

    useEffect(()=>{
        fetchFood()
        getCategory()
    },[])

    return (
        <>
            <div className="MenuPageContainer">
                <div className="MenuContainer">
                    {/* {console.log("food",menu)} */}
                    {/* <CircularProgress/> */}
                    {/* {food.length} */}
                    {/* {food.map(e=>{console.log(e)})} */}
                    {food.length == 0? <CircularProgress/>: food.map(e=>{return <MenuCard food={e} />})}
                    {/* {food.length !== 0? food.map(e=>{<MenuCard/>}): <CircularProgress/>} */}
                    {/* {food.map(e=>{
                        <MenuCard/>
                    })} */}
                    {/* <MenuCard/> */}
                    {/* <Link to="/menu-form"> */}
                    {console.log("cat",cat)}
                        <div className="addItem" onClick={()=>{navigate('/menu-form', { state: { food:{
                            "foodName":null,
                            "foodPrice":null,
                            "foodCategory":defaultCat
                        }} });}}>
                            <AddIcon className="add-Button"/> 
                            <h4 > Add Menu</h4>
                        </div>
                    {/* </Link> */}
                </div> 
            </div> 
        </>
    )
}