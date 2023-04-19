import React from 'react'
import { useState } from 'react'
import '../MenuForm/MenuFormStyles.css'

export function MenuForm({ }) {

    const e = {
        "foodName": "daal",
        "foodPrice": 20
    }
    const [image, setImage] = useState(null)
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
                    <div className="menu-Image">
                        <form class="form">
                            <span class="form-title">Upload your file</span>
                            <p class="form-paragraph">
                                File should be an image
                            </p>
                            <label for="file-input" class="drop-container">
                                <span class="drop-title">Drop files here</span>
                                or
                                <input type="file" accept="image/*" required="" id="file-input" onChange={onImageChange}></input>
                            </label>
                        </form>
                        {image == null ? <div className='imagePreview'><h4>Image Preview</h4></div> :
                            <img className="imagePreview" alt="preview image" src={image} />
                        }
                    </div>
                    <div className="menu-credentials">
                        <div class="input-container">
                            <input type="text" id="input" required="" placeholder={foodName}></input>
                            <label for="input" class="label">Enter Name</label>
                            {/* <div class="underline"></div> */}
                        </div>
                        <div class="input-container">
                            <input type="text" id="input" required="" placeholder={foodName}></input>
                            <label for="input" class="label">Enter Price</label>
                            {/* <div class="underline"></div> */}
                        </div>  

                    </div>
                </div>
            </div>
        </>
    )
}
