const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("PayPalModule", (m) => {
  const PayPal = m.contract("PayPal");

  return { PayPal };
});
