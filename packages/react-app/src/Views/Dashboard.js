import React, { useState } from 'react'
import Web3 from 'web3'
import Button from '../Components/Button';
import Input from '../Components/Input'

const Dashboard = () => {
  const [sendAddress, setSendAddress] = useState('')

  const isValidAddress = (address) => {
    try {
      const web3 = new Web3()
      web3.utils.toChecksumAddress(address)
      return true
    } catch (error) {
      return false
    }
  }

  const handleSubmit = (e) => {
    e.preventDefault();
    if (isValidAddress(sendAddress)) return

  }

  return (
    <div className='md:p-10 space-y-5'>
      <div className='w-full text-center text-4xl uppercase py-20'>
        Balance heading
      </div>
      <form id='transfer' className='w-[550px] lg:w-[800px] py-10 rounded-md bg-white shadow-md mx-auto flex flex-col border text-center space-y-5' onSubmit={handleSubmit}>
        <h3 className='text-4xl uppercase font-semibold py-5'>Transfer Token</h3>

        <Input label={'Address'} name='send-address' onChange={(e) => setSendAddress(() => e.target.value)} value={sendAddress} />
        <Input label={'Amount'} name='Amount' placeholder='Amount to send in BTU' />
        {
          sendAddress.length > 10 && !isValidAddress(sendAddress) &&
          <div className='text-red-700'> Not a valid address </div>
        }

        <div className='w-full'>
          <Button submit form="transfer" value="Submit">Send</Button>
        </div>
      </form>
    </div>
  )
}

export default Dashboard