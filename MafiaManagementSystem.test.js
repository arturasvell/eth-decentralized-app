const _deploy_contracts = require('../migrations/2_deploy_contracts')

const MafiaManagementSystem = artifacts.require("./MafiaManagementSystem.sol")

const assert = require('chai').assert

require('chai')
  .use(require('chai-as-promised'))
  .should()

contract('MafiaManagementSystem', (accounts) => {
    let mafiaManagementSystem

    before(async () => {
        mafiaManagementSystem = await MafiaManagementSystem.deployed()
    })

    describe('deployment', async () => {
        it('System status: Deployed.', async () => {
          const address = await mafiaManagementSystem.address
          assert.notEqual(address, 0x0)
          assert.notEqual(address, '')
          assert.notEqual(address, null)
          assert.notEqual(address, undefined)
        })
    
        it('Continental name matches.', async () => {
          const name = await mafiaManagementSystem.name()
          console.log(name)
          assert.equal(name, 'The Continental')
        })
      })

    describe('Hitman added to the guild successfully.', async () => {
      let hitman, hitmanCount

      before(async() => {
          hitman = await mafiaManagementSystem.AddHitman('0x79358588E6ced868713128e693e7D2f60f8679eD', 'Agent 47', 'Lethal. Inescapable death.', 100)
          hitmanCount = await mafiaManagementSystem.hitmenCount()
      })

      it('Hitman data matches.', async () => {
          assert.equal(hitmanCount, 1)
          const value = hitman.logs[0].args
		  console.log(value)
		  assert.equal(value.id.toNumber(),0,'hitman ID matches')
          assert.equal(value.hitmanAddress, '0x79358588E6ced868713128e693e7D2f60f8679eD', 'hitman wallet matches')
          assert.equal(value.codename, 'Agent 47', 'hitman codename matches')
          assert.equal(value.description, 'Lethal. Inescapable death.', 'hitman description matches')
          assert.equal(value.price, 100, 'hitman price matches')
          assert.equal(value.isAvailable, true, 'hitman is available')
      })

      
    })
})