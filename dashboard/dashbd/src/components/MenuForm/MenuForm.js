import React from 'react'
import { useState } from 'react'
import Chip from '@mui/material/Chip';
import CancelIcon from '@mui/icons-material/Cancel';
import AddCircleIcon from '@mui/icons-material/AddCircle';
import '../MenuForm/MenuFormStyles.css'

export function MenuForm({ }) {

    const e = {
        "foodName": "daal",
        "foodPrice": 20,
        "category":[
            "dinner",
            "lunch",
            "breakfast"
        ]
    }

    // const cancel = <CancelIcon className="canIcon" />

    const [image, setImage] = useState(null)
    const [defaultCat,setDefaultCat] = useState([])
    const [foodName, setFoodName] = useState(e.foodName.length == 0 ? "Enter food Name" : e.foodName)
    const [foodPrice, setFoodPrice] = useState(e.foodName == null ? "Enter food Price" : e.foodPrice)
    const onImageChange = (event) => {
        if (event.target.files && event.target.files[0]) {
            setImage(URL.createObjectURL(event.target.files[0]));
        }
    }


    return (
        <>
            <div className="menuForm">

                <div className="mainForm">
                    <div className="menu-credentials">
                        <div className="header">
                            <h2>Food Details</h2>
                        </div>
                        <div class="input-container">
                            <input type="text" id="input" required="" placeholder={foodName}></input>
                            <label for="input" class="label">Enter Name</label>
                            {/* <div class="underline"></div> */}
                        </div>
                        <div class="input-container">
                            <input type="text" id="input" required="" placeholder={foodPrice}></input>
                            <label for="input" class="label">Enter Price</label>
                            {/* <div class="underline"></div> */}
                        </div>
                        <div className="foodCategory">
                            <p>Food catgeory</p>
                            <AddCircleIcon className="addIcon"/>
                            {e.category.map(cat=>{
                                return(

                                
                                <Chip
                                icon={<CancelIcon className="canIcon" />}
                                label={cat}
                                className="catChip"
                                sx={{justifyContent:"left",maxWidth:"8vw",height:"32px"}}
                            //   onDelete={data.label === 'React' ? undefined : handleDelete(data)}
                            />)
                            })}
                            
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
