//
// this script executes when you run 'yarn test'
//
// you can also test remote submissions like:
// CONTRACT_ADDRESS=0x43Ab1FCd430C1f20270C2470f857f7a006117bbb yarn test --network rinkeby
//
// you can even run mint commands if the tests pass like:
// yarn test && echo "PASSED" || echo "FAILED"
//

const hre = require("hardhat");
const { ethers } = hre;
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("๐ฉ Challenge Nestcoin: ๐ต Buterin Vendor ๐ค", function () {

  this.timeout(125000);

  let yourToken;



  if(process.env.CONTRACT_ADDRESS){
    // live contracts, token already deployed
  }else{
    it("Should deploy YourToken", async function () {
      const YourToken = await ethers.getContractFactory("YourToken");
      yourToken = await YourToken.deploy();
    });
    describe("totalSupply()", function () {

      it("Should have a total supply of at least 1000", async function () {

        const totalSupply = await yourToken.totalSupply();
        const totalSupplyInt = parseInt(ethers.utils.formatEther(totalSupply))
        console.log('\t'," ๐งพ Total Supply:",totalSupplyInt)
        expect(totalSupplyInt).to.greaterThan(999);

      });
    })

  }


  let vendor;

  if(process.env.CONTRACT_ADDRESS){
    it("Should connect to external contract", async function () {
      vendor = await ethers.getContractAt("Vendor",process.env.CONTRACT_ADDRESS);
      console.log(`\t`,"๐ฐ Connected to:",vendor.address)

      console.log(`\t`,"๐ก Loading the yourToken address from the Vendor...")
      console.log(`\t`,"โ ๏ธ Make sure *yourToken* is public in the Vendor.sol!")
      let tokenAddress = await vendor.yourToken();
      console.log('\t',"๐ท Token Address:",tokenAddress)

      yourToken = await ethers.getContractAt("YourToken",tokenAddress);
      console.log(`\t`,"๐ฐ Connected to YourToken at:",yourToken.address)
    });
  }else{
    it("Should deploy YourToken", async function () {
      const Vendor = await ethers.getContractFactory("Vendor");
      vendor = await Vendor.deploy(yourToken.address);

      console.log("Transferring 1000 tokens to the vendor...")
      await yourToken.transfer(
        vendor.address,
        ethers.utils.parseEther("1000")
      );
    });
  }

  
});
