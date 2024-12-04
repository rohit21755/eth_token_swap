const path = require("path");
const fs = require("fs-extra");
const solc = require("solc");
const buildPath = path.join(__dirname, "build");
fs.removeSync(buildPath);

const tokenSwapPath = path.resolve(__dirname, "contracts", "TokenSwap.sol");
const tokenSwapSource = fs.readFileSync(tokenSwapPath, "utf8");
const input = {
    language: "Solidity",
    sources: {
        'TokenSwap.sol': {
            content: tokenSwapSource
        }
    },
    settings: {
        outputSelection: {
            "*": {
                "*": ["*"]
            }
        }
    }
}
// console.log(input);
const output = JSON.parse(solc.compile(JSON.stringify(input)))

fs.ensureDirSync(buildPath);
console.log(output);
for(let contract in output.contracts['TokenSwap.sol']) {
    fs.outputJSONSync(
        path.join(buildPath, contract + ".json"),
        output.contracts["TokenSwap.sol"][contract]
    )
    

}
console.log("Compiled successfully!");