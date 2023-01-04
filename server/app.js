import express from "express";
import connectDB from "./db/connection.js";
import customer from "./routes/customer.js"
const app = express()
const port = process.env.port || '8000'
const DATABASE_URL =
  process.env.DATABASE_URL ||
  "mongodb+srv://zakespy:Exodus%40123@cluster0.8kk4kls.mongodb.net/?retryWrites=true&w=majority";
  

connectDB(DATABASE_URL) //connection

app.use(express.json())

app.use("/api",customer);


app.listen(port,()=>{
    console.log(`Server LIstening at port http://localhost:${port}`)
})
