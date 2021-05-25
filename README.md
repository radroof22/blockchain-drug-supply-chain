# Blockchain Supply Chain Management for Drug Therapies
There were two main problems that this project hoped to address: temperature tracking and supply chain monitoring. The temperature tracking works by having the Raspberry Pi send updates, using its temperature sensor, to the blockchain to create a auditable record of the drug and to ensure it did not reach unbearable temperatures that would ruin the substance. Additionally, the supply chain monitoring works via RFID tags which, when they scan the RFID tag. The mobile app will scan the product and send a message to the blockchain updating its location accordingly to where it is currently.

## Awards
- 2nd Place at Montgomery County Science Fair in 11th Grade Division
- Honorable Mention (4th Place) at the Delaware Valley Science Fair in 11th Grade Division

## Purpose
- Create a blockchain implementation of drug suppyl transport for CAR-T therapy (patient to manufacturer to patient)
- Emulate all aspects of the drug transport chain
- Capitalize on growing market for *personalized* medicine which require human cells to be edited and returned back to patients (CAR-T)

## Software
* **Ethereum**: existing blockchain technology
* **Truffle**: Framework for building smart contracts
* **Ganache**: Emulates etherum blockchain for local development
* **Solidity**: Programming language for Ethereum blockchain 

## Drug Supply Chain Flow Chart and Steps
![Flow Chart of Drug Supply Chain](https://user-images.githubusercontent.com/23004551/119527955-cbd89680-bd4e-11eb-9157-d5a1db8a6ef6.PNG)

1. T-Cells are taken from patient and given to hospital / pharmacy
2. Pharmacy/Hospital sends T-Cells to distributor
3. Distributor sends cells to manufacturers them and modifies them for CAR-T therapy
4. Cells go back to distributor, then hospital/pharamcy, and to patient
5. Always upating blockchain record at every step to ensure latest status of cells are known by all parties

## Drug Transport Container
As part of this project, I wanted to create a container for the cells that would not only be able to update the blockchain with a record of temperatures for the sample but also work on correcting the temperature of itself as well.

![Picture of Transport Container](https://user-images.githubusercontent.com/23004551/119529549-350cd980-bd50-11eb-91e2-ccb1a292079a.jpg)

Above is a picture of the container. 
- On the left, you can see a fan that is connected to the Raspberry Pi. Using GPIO controls, the Pi will start to spin the fan in order to decrease the temperature of the container if the temperature of the container goes below a certain temperature
- The bigger blue rectange is the RFID scanner which can scan the RFID tag of the drug container to gather information or write information on that specific sample. 
- The far right blue square is the temperature sensor that is connected to the Pi via GPIO and provides it the temperature of its environment

![Outside of Transport Container](https://user-images.githubusercontent.com/23004551/119529554-35a57000-bd50-11eb-8d65-658e80bc219c.jpg)

Above is the picture of the outside of the container
- The blue object in the medicine bottle is the RFID tag which contains relevant information about the substance
- The amazon box contains a breadboard for all circuit connections and Raspberry Pi

## Mobile App
- Start off by selecting your identity in the supply chain
- Click button on the action you want to take on the drug
- Use Phone's NFC to scan the RFID tag 
- Update the Blockchain from the mobile app

![Identity Selection](https://user-images.githubusercontent.com/23004551/119529564-3807ca00-bd50-11eb-8f55-5e1aeb9484b2.jpg)

The picture depicts the identity selection menu for the mobile app

![Read Drug Information](https://user-images.githubusercontent.com/23004551/119529566-3807ca00-bd50-11eb-813d-e281d1c64ab7.jpg)

Picture displays the read drug information menu. This part of the app will have RFID tag bump into phone and collect RFID data using NFC. The app will then display the information it receives.

**Below is more pictures of the UI for the app**
![Read Drug Information](https://user-images.githubusercontent.com/23004551/119529568-3807ca00-bd50-11eb-99be-ea283d109a27.jpg)

![Patient Scan Drug Information](https://user-images.githubusercontent.com/23004551/119529569-3807ca00-bd50-11eb-8213-1f194b9cb322.jpg)

![Clinic - Create or Confirm Received Drug](https://user-images.githubusercontent.com/23004551/119529570-3807ca00-bd50-11eb-9fde-c238195649bb.jpg)

![Distributor - Confirmation Screen](https://user-images.githubusercontent.com/23004551/119529571-38a06080-bd50-11eb-96db-3ced54369481.jpg)


