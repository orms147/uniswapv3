import {ethers} from "ethers";
import dotenv from "dotenv";
dotenv.config();

const privateKey = process.env.PRIVATE_KEY || '';
const rpcUrl = process.env.RPC_URL || '';
const provider = new ethers.JsonRpcProvider(rpcUrl);
const wallet = new ethers.Wallet(privateKey, provider);

const factoryABI = [

]

const main = async () => {

}
main(); 



