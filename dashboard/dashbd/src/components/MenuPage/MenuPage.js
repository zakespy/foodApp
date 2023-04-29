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

    function clrRepeat(arr){
        let index = 0
        let count = 0
        let catName = ''
        arr.map(e=>{
            catName = arr[index].categoryName
            for(let i = index+1;i<arr.length;i++){
                if(arr[i].categoryName == catName){
                    arr.splice(i,1)
                }
            }
            index++
        })
        return arr
    }

    function createCatArray(obj){
        console.log("obj",obj)
        obj.map(e=>{
            console.log(e)
            cat.push(e)
        })
        cat  = clrRepeat(cat)
        setDefaultCat(cat)
        console.log("afterCat",cat)
    }

    function fetchFood(){
        // await axios.get("http://localhost:8000/api/food/allFood").then(e=>{setFood(e.data.menu)})
         axios.get("http://localhost:8000/api/food/allFood").then(e=>{setFood(e.data.menu)})
    }

    async function getCategory(){
        const category = await axios.get('http://localhost:8000/api/category/getAllCategory').then(e => { createCatArray(e.data.categories) })
        // const category = await axios.get('http://localhost:8000/api/category/getAllCategory').then(e => { setDefaultCat(e.data.categories) })
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
                    
                    {food.length == 0? <CircularProgress/>: food.map(e=>{return <MenuCard food={e} />})}
            
                    {/* {console.log("cat",cat)} */}
                        <div className="addItem" onClick={()=>{navigate('/menu-form', { state: { food:{
                            "foodName":null,
                            "foodPrice":null,
                            "foodCategory":defaultCat
                        }} });}}>
                            <AddIcon className="add-Button"/> 
                            <h4 > Add Menu</h4>
                        </div>
                </div> 
            </div> 
        </>
    )
}