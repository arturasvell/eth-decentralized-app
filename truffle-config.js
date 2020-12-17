module.exports = {
  compilers: {
    solc: {
      version: "0.5.0" 
    }
  },
  networks: {
    development: {
      host: "localhost",
      port: 7545,
      network_id: "*"
    }
  } 
};
