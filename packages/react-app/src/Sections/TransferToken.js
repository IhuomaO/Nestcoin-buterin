import React, { useState } from 'react'
import Button from '../Components/Button';
import Input from '../Components/Input'
import { isValidAddress } from '../Utils/helpers/CheckAddress';


const TransferToken = ({ title, onChangeAddress, onChangeAmount, valueAddress, valueAmount, buttonText, submit }) => {
  const [sendAddress, setSendAddress] = useState('')
  const [sendAmount, setSendAmount] = useState(0)


  console.log('user', sendAddress);
  console.log('user', sendAmount);
  console.log('');

  const handleSubmit = (e) => {
    e.preventDefault();
    if (isValidAddress(sendAddress)) return

  }

  return (
    <form id='transfer' className='w-[550px] lg:w-[750px] py-5 rounded-md shadow hover:shadow-xl transition duration-300 bg-white mx-auto flex flex-col border text-center space-y-5' onSubmit={submit ?? handleSubmit}>
      <h3 className='text-3xl uppercase font-bold py-5'>{title || 'Transfer Token'}</h3>

      <Input label={'Address'}
        name='send-address'
        onChange={onChangeAddress ?? ((e) => setSendAddress(() => e.target.value))}
        value={valueAddress ?? sendAddress}
      />

      <Input label={'Amount'}
        onChange={onChangeAmount ?? ((e) => {
          if (isNaN(e.target.value)) return
          setSendAmount(() => e.target.value);
        })}
        name='Amount' placeholder='Amount to send in BTU'
        value={valueAmount ?? sendAmount}

      />

      {
        (valueAddress > 5|| sendAddress.length > 5 ) && !isValidAddress(valueAddress|| sendAddress) &&
        <div className='text-red-700'> Not a valid address </div>
      }

      <div className='w-full'>
        <Button className='mx-auto' type='submit' form="transfer" value="Submit">{buttonText || 'Send'}</Button>
      </div>
    </form>
  )
}

export default TransferToken