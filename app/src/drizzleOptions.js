import Web3 from "web3";
import SimpleStorage from "./contracts/SimpleStorage.json";
import ComplexStorage from "./contracts/ComplexStorage.json";
import TutorialToken from "./contracts/TutorialToken.json";
import CAR_T from "./contracts/CAR_T.json";

const options = {
  web3: {
    block: false,
    customProvider: new Web3("ws://localhost:7545"),
  },
  contracts: [SimpleStorage, ComplexStorage, TutorialToken, CAR_T],
  events: {
    SimpleStorage: ["StorageSet"],
  },
  polls: {
    accounts: 1500,
  },
};

export default options;
