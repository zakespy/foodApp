import React from 'react'
import { useState, useEffect ,useRef} from 'react'
import { useLocation } from 'react-router-dom';
import axios from 'axios'
import Chip from '@mui/material/Chip';
import CancelIcon from '@mui/icons-material/Cancel';
import AddCircleIcon from '@mui/icons-material/AddCircle';
import '../MenuForm/MenuFormStyles.css'

export function MenuForm({ }) {
    const {state} = useLocation()
    console.log("state",state)
    let toggle = false
    // const e = {
    //     "foodName": "daal",
    //     "foodPrice": 20,
    //     "category": [
    //         {
    //             "categoryName": "Lunch",
    //             "isPresent":true
    //         }, 
    //         {
    //             "categoryName": "Breakfast",
    //             "isPresent":false
    //         },
    //         {
    //             "categoryName": "Drinks",
    //             "isPresent":true
    //         },
    //         {
    //             "categoryName": "Dinner",
    //             "isPresent":true
    //         }
    //     ]
    // }

    let newCat = state.food.foodCategory;

    const ref = useRef({
        category:state.food.foodCategory
    })
    console.log("useRef",ref.current.category)
    const [defaultCat, setDefaultCat] = useState([])
    const [currCat, setCurrCat] = useState(newCat)
    // const [currCat, setCurrCat] = useState(state== null ? defaultCat : state.food.foodCategory)
    const [image, setImage] = useState()
    // const [newCat, setNewCat] = useState(state == null?[]:state.food.foodCategory)
    const [foodName, setFoodName] = useState(state == null ? "Enter food Name" : state.food.foodName)
    const [newFoodName,setNewFoodName] = useState()
    const [foodPrice, setFoodPrice] = useState(state == null ? "Enter food Price" : state.food.foodPrice)
    const [newFoodPrice,setNewFoodPrice] = useState()
    

    // function genCat() {
    //     // console.log("defaultCat",defaultCat)
    //     defaultCat.map(e => {
    //         // console.log(e)
    //         cat.push(
    //             {
    //                 "categoryName": e.categoryName,
    //                 "isPresent": false
    //             }
    //         )
    //     })
    //     // console.log("cat ",cat)
    //     cat.map(e => {
    //         currCat.map(n => {
    //             if (e.categoryName == n.categoryName) {
    //                 e.isPresent = true
    //             }
    //         })
    //     })
    //     // console.log("final cat value",cat)
    //     setNewCat(cat)
    // }

    async function getCategory() {
        const category = await axios.get('http://localhost:8000/api/category/getAllCategory').then(e => { setDefaultCat(e.data.categories) })
    }

    const onImageChange = (event) => {
        if (event.target.files && event.target.files[0]) {
            setImage(URL.createObjectURL(event.target.files[0]));
        }
    }


    function deleteCat(cat){
        let count = 0;
        let temp = ref.current.category
        ref.current.category.map(elem=>{
            if(elem.categoryName === cat){
                console.log("before",ref.current.category[count].isPresent)
                ref.current.category[count].isPresent = false
                console.log("after",ref.current.category[count].isPresent)   
            }
            count++
            // elem.categoryName === cat?ref.current.category[count].isPresent = true:elem.isPresent=elem.isPresent
            // count++
        })
        
        // setCurrCat(newCat)
        setCurrCat(temp=>({...temp,...ref.current.category[count]}))   
        
    }

    function addCat(cat){
        let count = 0;
        ref.current.category.map(elem=>{
            if(elem.categoryName === cat){
                console.log("before",ref.current.category[count].isPresent)
                ref.current.category[count].isPresent = true
                console.log("after",ref.current.category[count].isPresent)        
            }
            count++
            // elem.categoryName === cat?ref.current.category[count].isPresent = true:elem.isPresent=elem.isPresent
            // count++
        })
        setCurrCat(temp=>({...temp,...ref.current.category[count]}))     
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
                            <input type="text" id="input" required="" placeholder={foodName} onChange={e=>{setNewFoodName(e.target.value)}}></input>
                            <label for="input" class="label">Enter Name</label>
                            {/* <div class="underline"></div> */}
                        </div>
                        <div class="input-container">
                            <input type="text" id="input" required="" placeholder={foodPrice} onChange={e=>{setNewFoodPrice(e.target.value)}}></input>
                            <label for="input" class="label">Enter Price</label>
                            {/* <div class="underline"></div> */}
                        </div>
                        <div className="foodCategory">
                            <p>Food catgeory</p>
                            {/* <AddCircleIcon className="addIcon"/> */}
                            {console.log("After currcat",currCat)}                            
                            {ref.current.category.map(elem => {  
                                // console.log(e)  
                                if (elem.isPresent == true) {
                                    return <Chip
                                        icon={<CancelIcon className="canIcon" onClick={()=>{deleteCat(elem.categoryName)}}/>}
                                        label={elem.categoryName}
                                        className="deleteCatChip"
                                        sx={{ justifyContent: "left", maxWidth: "8vw", height: "32px", backgroundColor: "rgb(226, 196, 107)" }}
                                    //   onDelete={data.label === 'React' ? undefined : handleDelete(data)}
                                    />
                                } else {
                                    return <Chip
                                        icon={<AddCircleIcon className="canIcon" onClick={()=>{addCat(elem.categoryName)}}/>}
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
