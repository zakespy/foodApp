import express from "express";
import dotenv from 'dotenv';
import connectDB from "./db/connection.js";
import customer from "./routes/customer.js"
import food from "./routes/food.js"

const app = express()
dotenv.config({ path: "./config.env" });

const port = process.env.port || '8000'
const DATABASE_URL =
  process.env.DATABASE_URL 
  

connectDB(DATABASE_URL) //connection

app.use(express.json())

app.use("/api",customer);
app.use("/api/food",food)



app.listen(port,()=>{
    console.log(`Server LIstening at port http://localhost:${port}`)
})
