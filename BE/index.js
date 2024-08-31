const express = require("express");
const { ethers } = require("ethers");
const app = express();
const cors = require("cors");
require("dotenv").config();
const PORT = 3001;
const ABI = require("./abi.json");

app.use(cors());
app.use(express.json());

const CHAIN_ID = "0x13882";
const CONTRACT_ADDRESS = "0xCc59014F908F7cf128De57FEf996048481f280a0";
const provider = new ethers.JsonRpcProvider(process.env.INFURA_URL);
const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

function convertArrayToObjects(arr) {
  const dataArray = arr.map((transaction, index) => ({
    key: (arr.length + 1 - index).toString(),
    type: transaction[0],
    amount: transaction[1],
    message: transaction[2],
    address: `${transaction[3].slice(0, 4)}...${transaction[3].slice(0, 4)}`,
    subject: transaction[4],
  }));

  return dataArray.reverse();
}

app.get("/name", async (req, res) => {
  const { address } = req.query;
  try {
    const responseEth = await contract.getUserName(address);
    return res.status(200).json(responseEth);
  } catch (err) {
    console.log(err);
    return res.status(500).json({ error: err });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
