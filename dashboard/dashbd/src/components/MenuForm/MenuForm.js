import React from 'react'
import { useState, useEffect } from 'react'
import axios from 'axios'
import Chip from '@mui/material/Chip';
import CancelIcon from '@mui/icons-material/Cancel';
import AddCircleIcon from '@mui/icons-material/AddCircle';
import '../MenuForm/MenuFormStyles.css'

export function MenuForm({ }) {

    let toggle = false
    const e = {
        "foodName": "daal",
        "foodPrice": 20,
        "category": [
            {
                "categoryName": "Lunch",
                "isPresent":true
            }, 
            {
                "categoryName": "Breakfast",
                "isPresent":false
            },
            {
                "categoryName": "Drinks",
                "isPresent":true
            },
            {
                "categoryName": "Dinner",
                "isPresent":true
            }
        ]
    }
    const [currCat, setCurrCat] = useState(e.category.length == 0 ? [] : e.category)
    const [image, setImage] = useState(null)
    const [defaultCat, setDefaultCat] = useState([])
    const [newCat, setNewCat] = useState({})
    const [foodName, setFoodName] = useState(e.foodName.length == 0 ? "Enter food Name" : e.foodName)
    const [newFoodName,setNewFoodName] = useState()
    const [foodPrice, setFoodPrice] = useState(e.foodName == null ? "Enter food Price" : e.foodPrice)
    const [newFoodPrice,setNewFoodPrice] = useState()
    let cat = [];

    function genCat() {
        // console.log("defaultCat",defaultCat)
        defaultCat.map(e => {
            // console.log(e)
            cat.push(
                {
                    "categoryName": e.categoryName,
                    "isPresent": false
                }
            )
        })
        // console.log("cat ",cat)
        cat.map(e => {
            currCat.map(n => {
                if (e.categoryName == n.categoryName) {
                    e.isPresent = true
                }
            })
        })
        // console.log("final cat value",cat)
        setNewCat(cat)
    }

    async function getCategory() {
        const category = await axios.get('http://localhost:8000/api/category/getAllCategory').then(e => { setDefaultCat(e.data.categories) })
    }

    const onImageChange = (event) => {
        if (event.target.files && event.target.files[0]) {
            setImage(URL.createObjectURL(event.target.files[0]));
        }
    }


    function deleteCat(cat){
        e.category.map(elem=>{
            elem.categoryName == cat?elem.isPresent = false:elem.isPresent=elem.isPresent
        })
        setCurrCat(e.category)
    }

    function addCat(cat){
        e.category.map(elem=>{
            elem.categoryName == cat?elem.isPresent = true:elem.isPresent=elem.isPresent
        })
        setCurrCat(e.category)
    }

    useEffect(() => {
        getCategory()
        // genCat()
    }, [])

    
    return (
        <>
            <div className="menuForm">

                <div className="mainForm">
                    <div className="menu-credentials">
                        <div className="header">
                            <h2>Food Details</h2>
                        </div>
                        <div class="input-container">
                            <input type="text" id="input" required="" placeholder={foodName} onChange={e=>{setNewFoodName(e.data)}}></input>
                            <label for="input" class="label">Enter Name</label>{console.log(newFoodName)}
                            {/* <div class="underline"></div> */}
                        </div>
                        <div class="input-container">
                            <input type="text" id="input" required="" placeholder={foodPrice} onChange={e=>{setNewFoodName(e.data)}}></input>
                            <label for="input" class="label">Enter Price</label>{console.log(newFoodPrice)}
                            {/* <div class="underline"></div> */}
                        </div>
                        <div className="foodCategory">
                            <p>Food catgeory</p>
                            {/* <AddCircleIcon className="addIcon"/> */}
                            {/* {console.log("category", defaultCat)} */}
                            {currCat.map(e => {  
                                // console.log(e)
                                if (e.isPresent === true) {
                                    return <Chip
                                        icon={<CancelIcon className="canIcon" onClick={()=>{deleteCat(e.categoryName)}}/>}
                                        label={e.categoryName}
                                        className="deleteCatChip"
                                        sx={{ justifyContent: "left", maxWidth: "8vw", height: "32px", backgroundColor: "rgb(226, 196, 107)" }}
                                    //   onDelete={data.label === 'React' ? undefined : handleDelete(data)}
                                    />
                                } else {
                                    return <Chip
                                        icon={<AddCircleIcon className="canIcon" onClick={()=>{addCat(e.categoryName)}}/>}
                                        label={e.categoryName}
                                        className="catChip"
                                        sx={{ justifyContent: "left", maxWidth: "8vw", height: "32px" }}
                                    //   onDelete={data.label === 'React' ? undefined : handleDelete(data)}
                                    />
                                }
                            })}
                            {/* {currCat.map(e=>{
                                return (
                                    <Chip
                                icon={<CancelIcon className="canIcon"/>}
                                label={e.categoryName}
                                className="deleteCatChip"
                                sx={{justifyContent:"left",maxWidth:"8vw",height:"32px",backgroundColor:"rgb(226, 196, 107)"}}
                            //   onDelete={data.label === 'React' ? undefined : handleDelete(data)}
                            />
                                )
                            })}
                            {defaultCat.map(cat=>{
                                return(
                                <Chip
                                icon={<AddCircleIcon className="canIcon"/>}
                                label={cat.categoryName}
                                className="catChip"
                                sx={{justifyContent:"left",maxWidth:"8vw",height:"32px"}}
                            //   onDelete={data.label === 'React' ? undefined : handleDelete(data)}
                            />)
                            })} */}

                        </div>
                        <div className="submitBtn">
                            <button className='submitButton'>
                                Submit
                            </button>
                        </div>



                    </div>
                    <div className="menu-Image">
                        {image == null ? <div className='imagePreview'><h4>Image Preview</h4></div> :
                            <img className="imagePreview" alt="preview image" src={image} />
                        }
                        <form class="form">
                            <span class="form-title">Upload Food Image</span>
                            <p class="form-paragraph">
                                File should be an image
                            </p>
                            <label for="file-input" class="drop-container">
                                <span class="drop-title">Drop files here</span>
                                or
                                <input type="file" accept="image/*" required="" id="file-input" onChange={onImageChange}></input>
                            </label>
                        </form>

                    </div>

                </div>
            </div>
        </>
    )
}
