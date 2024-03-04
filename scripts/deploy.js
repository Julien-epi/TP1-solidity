const hre = require("hardhat");

async function getOverrides() {
  const provider = hre.ethers.provider;
  const gasPrice = await provider.getGasPrice();
  return {
    gasLimit: 3000000, // Ajustez cette valeur en fonction de vos besoins
    gasPrice: gasPrice.mul(120).div(100), // Ajustez ce pourcentage en fonction de vos besoins
    nonce: await provider.getTransactionCount(deployer.getAddress(), "latest")
  };
}

async function deployUser() {
  const User = await hre.ethers.getContractFactory("User");
  const user = await User.deploy(await getOverrides());

  await user.waitForDeployment();

  console.log(`User contract deployed to ${user.target}`);

  return user;
}

async function deployMatch(user) {
  const Match = await hre.ethers.getContractFactory("Match");
  const match = await Match.deploy(user.address, await getOverrides());

  await match.waitForDeployment();

  console.log(`Match contract deployed to ${match.target}`);

  return match;
}

async function deployBet(match, entryFee) {
    const Bet = await hre.ethers.getContractFactory("Bet");
    const bet = await Bet.deploy(match.address, entryFee, await getOverrides());

    await bet.waitForDeployment();

    console.log(`Bet contract deployed to ${bet.target}`);

    return bet;
}

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("🚀 ~ main ~ deployer:", deployer)
  const user = await deployUser();
  const match = await deployMatch(user);
  const entryFee = hre.ethers.parseEther("0.1");
  await deployBet(match, entryFee);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
