import express from "express";

const app = express();

// https://hooks.zapier.com/hooks/catch/24060067/u4isgb2/
// passsword logic

app.post("/hooks/catch/:userId/:zapId", (req, res) => {
    const userId = req.params.userId;
    const zapId = req.params.zapId;

    //store in db a new trigger

    //push it onto the queue(kafka/redis)
})