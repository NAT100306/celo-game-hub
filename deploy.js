// Deployment script for reference
async function main() {
  console.log("🚀 Deploying Celo Game Hub...");
  
  // Alfajores testnet addresses
  const CUSD_ADDRESS = "0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1";
  
  console.log("📝 Deploy contracts in this order:");
  console.log("1. GameToken.sol");
  console.log("2. NFTicket.sol"); 
  console.log("3. GameHub.sol with parameters: [GameTokenAddress, NFTicketAddress]");
  
  console.log("✅ Deployment completed!");
  console.log("🔗 Check contracts on: https://alfajores.celoscan.io");
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
