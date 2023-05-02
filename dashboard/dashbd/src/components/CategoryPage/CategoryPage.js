import React from "react";
import { useState, useEffect } from "react";
import axios from "axios";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";
import Typography from "@mui/material/Typography";
import Accordion from "@mui/material/Accordion";
import AccordionDetails from "@mui/material/AccordionDetails";
import AccordionSummary from "@mui/material/AccordionSummary";
import "../CategoryPage/CategoryPageStyles.css"

export default function CategoryPage() {

    const [menu, setMenu] = useState([])
    const [cat,setCat] = useState([])
    const [newCatName,setNewCatName] = useState()

    const updatedMenu = menu
    const newCatMenu = []

    async function getAllMenu() {
        await axios.get("http://localhost:8000/api/food/allFood").then(e => {
            console.log(e.data.menu)
            setMenu(e.data.menu)
        })
    }

    async function getAllCat(){
        axios.get("http://localhost:8000/api/category/getAllCategory").then(e=>{
            setCat(e.data.categories)
            console.log(e.data.categories)
        })
    }

    function checkNupdatedCat(foodName,categoryName){
        if(newCatMenu.length == 0){
            newCatMenu.push({
                "foodName":`${foodName}`,
                "categoryName":`${categoryName}`,
                "isPresent":true
            })
        }else{
            let count = 0
            newCatMenu.map(e=>{
                if(e.foodName == foodName){
                    e.isPresent = !e.isPresent
                    count++
                }
            })
            if(count == 0){
                newCatMenu.push({
                    "foodName":foodName,
                    "categoryName":categoryName,
                    "isPresent":true
                })
            }
        }

    }

    function updateUpdatedMenu(arr){
        for(let i =0;i<arr.length;i++){
            for(let j=0;j<updatedMenu.length;j++){
                updatedMenu[j].foodImage = ''
                if(arr[i].foodName == updatedMenu[j].foodName){
                    let count = 0
                    updatedMenu[j].foodCategory.map(e=>{
                        if(e.categoryName == arr[i].categoryName){
                            e.isPresent = arr[i].isPresent
                            count++
                        }
                    })
                    if(count == 0){
                        updatedMenu[j].foodCategory.push({
                            "categoryName":arr[i].categoryName,
                            "isPresent":arr[i].isPresent
                        })
                    }
                }else{
                    let count = 0
                    updatedMenu[j].foodCategory.map(e=>{
                        if(e.categoryName == arr[i].categoryName){
                            count++
                        }
                    })
                    if(count == 0){
                        updatedMenu[j].foodCategory.push({
                            "categoryName":arr[i].categoryName,
                            "isPresent":false
                        })
                    }
                    // console.log(arr[i].categoryName)
                    
                }
            }
        }
        console.log(updatedMenu)
        setMenu(updatedMenu)
        addCat2DB()
        editMenu2DB()
    }

    async function addCat2DB(){
        await axios.post("http://localhost:8000/api/category/addCategory",{
            "categoryName":newCatName
        }).then(e=>{console.log(e)})
    }

    async function editMenu2DB(){
        await axios.post("http://localhost:8000/api/category/editAllMenu",{
            "updatedMenu":updatedMenu
        }).then(e=>{console.log(e)})
    }

    useEffect(() => {
        getAllMenu()
        getAllCat()
    }, [])

    let Menu = [
        {
            "foodName": "panner",
        },
        {
            "foodName": "panner",
        },
        {
            "foodName": "panner",
        },
        {
            "foodName": "panner",
        },
        {
            "foodName": "panner",
        },
    ]

    return (
        <>
            <div className="mainCatCont">
                <div className="catCont">
                    <div className="catForm">
                        <h2 className="catDesc">Add Category</h2>
                        <div class="input-container">
                            <input type="text" id="input" placeholder="Name" required="" onChange={(e)=>{
                                setNewCatName(e.target.value)
                            }}></input>
                            <label for="input" class="label">Enter Name</label>
                        </div>
                        <div className="catOption">
                            <Accordion>
                                <AccordionSummary
                                    expandIcon={<ExpandMoreIcon />}
                                    aria-controls="panel1a-content"
                                    id="panel1a-header">
                                    <Typography>Select Food items</Typography>
                                </AccordionSummary>
                                <AccordionDetails>
                                    {menu.map((e) => {
                                        return (<>
                                            <div className="optionCard">
                                                <label class="cyberpunk-checkbox-label">
                                                    <input class="cyberpunk-checkbox" type="checkbox" onClick={elem=>{
                                                        checkNupdatedCat(e.foodName,newCatName)
                                                        console.log(e.foodName)
                                                        console.log(newCatMenu)
                                                    }}></input>
                                                    {e.foodName}</label>
                                            </div>
                                        </>
                                        );
                                    })}
                                </AccordionDetails>
                            </Accordion>
                        </div>
                        <div className="submitBtn">
                            
                            <button className='submitButton' onClick={()=>{
                                updateUpdatedMenu(newCatMenu)
                            }}> Add
                            </button>
                        </div>

                    </div>
                    <div className="catPage">
                        <h2 className="cardDesc">All Category</h2>
                      {cat.map(e=>{
                        return (
                            <>
                                <CategoryCard categoryName={e.categoryName}/>
                            </>
                        )
                      })}  
                    </div>
                </div>
            </div>
        </>
    )
}

function CategoryCard({categoryName}){
    return (
        <>
            <div className="cardCont">
                <p className="cardText">
                    {categoryName}
                </p>
            </div>
        </>
    )
}