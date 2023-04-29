import React from 'react'
import { useState, useEffect, useRef } from 'react'
import { useLocation } from 'react-router-dom';
import axios from 'axios'
import base64 from "base-64"
import utf8 from "utf8"
import Chip from '@mui/material/Chip';
import CancelIcon from '@mui/icons-material/Cancel';
import AddCircleIcon from '@mui/icons-material/AddCircle';
import '../MenuForm/MenuFormStyles.css'

export function MenuForm({ }) {
    const { state } = useLocation()
    console.log("state", state)
    let toggle = false
    let cat = []
    let newCat = state.food.foodCategory;
    console.log(newCat)
    const ref = useRef({
        category: state.food.foodCategory
    })
    console.log("useRef", ref.current.category)
    const [defaultCat, setDefaultCat] = useState([])
    const [currCat, setCurrCat] = useState(newCat)
    console.log(currCat)
    // const [currCat, setCurrCat] = useState(state== null ? defaultCat : state.food.foodCategory)
    const [image, setImage] = useState(state == null ? null : state.food.foodImage)
    // const [newCat, setNewCat] = useState(state == null?[]:state.food.foodCategory)
    const [foodName, setFoodName] = useState(state == null ? "Enter food Name" : state.food.foodName)
    const [newFoodName, setNewFoodName] = useState(foodName)
    const [foodPrice, setFoodPrice] = useState(state == null ? "Enter food Price" : state.food.foodPrice)
    const [newFoodPrice, setNewFoodPrice] = useState(foodPrice)

    const [newFood, setNewFood] = useState({
        "oldFoodName": state.food.foodName,
        "foodName": newFoodName,
        "foodPrice": newFoodPrice,
        "foodImage": image,
        "foodCategory": [currCat]
    })

    function setNewImage(pic) {
        setImage(pic)
        setNewFood({
            ...newFood,
            "foodImage": pic
                .replace("data:", "")
                .replace(/^.+,/, ""),
        })
    }


    const convertBase64 = (file) => {
        return new Promise((resolve, reject) => {
            const fileReader = new FileReader();
            fileReader.readAsDataURL(file);
            fileReader.onload = () => {
                // console.log(
                //   fileReader.result.replace("data:", "").replace(/^.+,/, "")
                // );
                resolve(
                    // console.log(fileReader.result),
                    setNewImage(fileReader.result)
                );
                // resolve(fileReader.result.replace("data:", "").replace(/^.+,/, ""));
            };
            fileReader.onerror = (error) => {
                reject(error);
            };
        });
    };

    async function getCategory() {
        const category = await axios.get('http://localhost:8000/api/category/getAllCategory').then(e => { setDefaultCat(e.data.categories) })
    }

    async function addFood() {
        // setCurrCat(...currCat,[currCat])
        let ct = []
        for(var i in currCat){
            console.log(currCat[i])
            ct.push(currCat[i])
        }
        console.log("ct",ct)
        console.log("newFood", currCat)
        console.log("newFood", newFood.foodCategory)
        
        await axios.post("http://localhost:8000/api/food/addFood", {
            "foodName":newFood.foodName,
            "foodPrice":newFood.foodPrice,
            "foodimage":newFood.foodImage,
            "foodCategory":ct,
            "oldFoodName":newFood.oldFoodName
        }).then(e => { console.log("response", e) })
    }

    const onImageChange = (event) => {
        if (event.target.files && event.target.files[0]) {
            // setImage(URL.createObjectURL(event.target.files[0]));
            convertBase64(event.target.files[0])
        }
    }


    function deleteCat(cat) {
        let count = 0;
        // let temp = ref.current.category
        // console.log("temp",temp)
        ref.current.category.map(elem => {
            if (elem.categoryName === cat) {
                console.log("before", ref.current.category[count].isPresent)
                ref.current.category[count].isPresent = false
                console.log("after", ref.current.category[count].isPresent)
            }
            count++
            // elem.categoryName === cat?ref.current.category[count].isPresent = true:elem.isPresent=elem.isPresent
            // count++
        })
        console.log("delete new food",newFood)

        // setCurrCat(newCat)
        setCurrCat(elem => ({ ...elem, ...ref.current.category[count] }))
        setNewFood(newFood => ({ ...newFood, ...{ "foodCategory": currCat } }))

    }

    function addCat(cat) {
        let count = 0;
        ref.current.category.map(elem => {
            if (elem.categoryName === cat) {
                console.log("before", ref.current.category[count].isPresent)
                ref.current.category[count].isPresent = true
                console.log("after", ref.current.category[count].isPresent)
            }
            count++
            // elem.categoryName === cat?ref.current.category[count].isPresent = true:elem.isPresent=elem.isPresent
            // count++
        })

        console.log("delete new food",newFood)
        setCurrCat(elem => ({ ...elem, ...ref.current.category[count] }))
        setNewFood(newFood => ({ ...newFood, ...{ "foodCategory": currCat } }))
        // newCat.map(elem=>{ 
        //     elem.categoryName === cat?elem.isPresent = true:elem.isPresent=elem.isPresent
        // })
        // setCurrCat(newCat)
    }

    useEffect(() => {
        getCategory()
        // genCat()
    }, [])

    // useEffect(()=>{
    //     setCurrCat(ref.current.category)
    // },[currCat])


    return (
        <>
            <div className="menuForm">

                <div className="mainForm">
                    <div className="menu-credentials">
                        <div className="header">
                            <h2>Food Details</h2>
                        </div>
                        <div class="input-container">
                            <input type="text" id="input" required="" placeholder={foodName} onChange={e => {
                                setNewFoodName(e.target.value)
                                setNewFood(newFood => ({ ...newFood, ...{ "foodName": e.target.value } }))
                            }}></input>
                            <label for="input" class="label">Enter Name</label>
                            {/* <div class="underline"></div> */}
                        </div>
                        <div class="input-container">
                            <input type="text" id="input" required="" placeholder={foodPrice} onChange={e => {
                                setNewFoodPrice(e.target.value)
                                setNewFood(newFood => ({ ...newFood, ...{ "foodPrice": e.target.value } }))
                            }}></input>
                            <label for="input" class="label">Enter Price</label>
                            {/* <div class="underline"></div> */}
                        </div>
                        <div className="foodCategory">
                            <p>Food catgeory</p>
                            {/* <AddCircleIcon className="addIcon"/> */}
                            {console.log("After currcat", currCat)}
                            {ref.current.category.map(elem => { 
                                if (elem.isPresent == true) {
                                    return <Chip
                                        icon={<CancelIcon className="canIcon" onClick={() => { deleteCat(elem.categoryName) }} />}
                                        label={elem.categoryName}
                                        className="deleteCatChip"
                                        sx={{ justifyContent: "left", maxWidth: "8vw", height: "32px", backgroundColor: "rgb(226, 196, 107)" }}
                                    //   onDelete={data.label === 'React' ? undefined : handleDelete(data)}
                                    />
                                } else {
                                    return <Chip
                                        icon={<AddCircleIcon className="canIcon" onClick={() => { addCat(elem.categoryName) }} />}
                                        label={elem.categoryName}
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
                            
                            <button className='submitButton' onClick={()=>{
                                addFood()
                            console.log("newFood",newFood)}}> Add
                            </button>
                        </div>



                    </div>
                    <div className="menu-Image">
                        {image == null ? <div className='imagePreview'><h4>Image Preview .Not more than 500KB</h4></div> :
                            <img className="imagePreview" alt="preview image" src={`${image}`} />
                            // <img className="imagePreview"    alt="preview image" src={`data:image/jpeg;base64,${image}`} />
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
